//
//  ImageListView.swift
//  Practice
//
//  Created by Ever on 2022/07/30.
//

import UIKit
import SnapKit

// MARK: - Action Delegation
protocol ImageViewListActionListener: AnyObject {
    func imageViewListDidTapDetailButton(with photo: UnsplashPhoto?)
}

final class ImageListView: UIView {
    // MARK: - View Define
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = dataSource
        collectionView.delegate  = delegate
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
    private var selectedImage: UnsplashPhoto? {
        didSet {
            guard let selectedImage = selectedImage else {
                return
            }
            infoView.configureInfo(with: selectedImage)
        }
    }
    
    private var dataSource = ImageListDataSource()
    private var delegate = ImageListDelegate()
    
    // MARK: Internal Properties
    weak var listener: ImageViewListActionListener?
    var imageList: [UnsplashPhoto] = [] {
        didSet {
            self.dataSource.imageList = imageList
            self.delegate.imageList = imageList
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: View LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        bindAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        bindAction()
    }
    
    // MARK: - Layout
    private func setupViews() {
        self.backgroundColor = .white
        self.setupCollectionView()
        self.setupInfoView()
        self.setupGoToDetailButton()
    }
    
    private func setupCollectionView() {
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    private func setupInfoView() {
        self.addSubview(self.infoContainerView)
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
    
    // MARK: - User Action
    private func bindAction() {
        delegate.selectingImageClosure = { [weak self] selectedImage in
            self?.selectedImage = selectedImage
        }
    }
    
    @objc
    private func goToDetail() {
        listener?.imageViewListDidTapDetailButton(with: selectedImage)
    }
}
