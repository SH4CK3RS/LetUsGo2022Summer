//
//  ViewController.swift
//  UIPractice
//
//  Created by Ever on 2022/06/28.
//

import UIKit
import SnapKit

class ImageListViewController: UIViewController {
    // MARK: View Define
    private let mainView = ImageListView()
    
    // MARK: Private Properties
    private let imageDonwolader = ImageDownloader()
    
    // MARK: - Life Cycles
    override func loadView() {
        self.view = mainView
        mainView.listener = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getImages()
    }
    
    // MARK: - Networking
    private func getImages() {
        imageDonwolader.getImages { [weak self] result in
            switch result {
            case let .success(imageList):
                self?.mainView.imageList = imageList
            case .failure:
                DispatchQueue.main.async {
                    self?.showError()
                }
            }
        }
    }
    
    private func showError() {
        let alert = UIAlertController(title: "오류", message: "이미지 다운로드 실패", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ImageListViewController: ImageViewListActionListener {
    func imageViewListDidTapDetailButton(with photo: UnsplashPhoto?) {
        let detailViewController = ImageDetailViewController()
        detailViewController.photo = photo
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
