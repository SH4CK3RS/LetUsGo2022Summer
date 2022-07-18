//
//  ViewController.swift
//  UIPractice
//
//  Created by Ever on 2022/06/28.
//

import UIKit
import SnapKit

class ImageListViewController: UIViewController {
    // MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate  = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        return collectionView
    }()
    
    private let infoContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let infoView = ImageInfoView()
    private lazy var goToDetailButton: UIButton = {
        let button = UIButton()
        button.setTitle("상세화면", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(goToDetail), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Private Properties
    
    private var imageList: [UnsplashPhoto] = []
    private var selectedImage: UnsplashPhoto? {
        didSet {
            guard let selectedImage = selectedImage else {
                return
            }
            infoView.configureInfo(with: selectedImage)
        }
    }
    
    // MARK: - Life Cycles
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getImages()
    }
    
    // MARK: - Layout
    private func setupViews() {
        self.setupCollectionView()
        self.setupInfoView()
        self.setupGoToDetailButton()
    }
    
    private func setupCollectionView() {
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    private func setupInfoView() {
        self.view.addSubview(self.infoContainerView)
        infoContainerView.addSubview(self.infoView)
        self.infoContainerView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview().inset(32)
        }
        
        infoView.snp.makeConstraints {
            $0.top.equalTo(16)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupGoToDetailButton() {
        self.infoContainerView.addSubview(self.goToDetailButton)
        self.goToDetailButton.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
    }
    
    // MARK: - Networking
    private func getImages() {
        let queryString = PhotoRequestDTO(page: 1, perPage: 20).queryString
        let urlString = "https://api.unsplash.com/photos" + queryString
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue("Client-ID \(Constants.clientId)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let list = try? JSONDecoder().decode([UnsplashPhoto].self, from: data) {
                self.imageList = list
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        task.resume()
    }
    
    // MARK: - Navigation
    @objc
    private func goToDetail() {
        let detailViewController = ImageDetailViewController()
        detailViewController.photo = self.selectedImage
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - DataSource & Delegate
extension ImageListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
            return .init()
        }
        let image = self.imageList[indexPath.item]
        cell.configureCell(with: image)
        return cell
    }
}

extension ImageListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = imageList[indexPath.item]
        self.selectedImage = image
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width / 5
        let height = width
        return .init(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}
