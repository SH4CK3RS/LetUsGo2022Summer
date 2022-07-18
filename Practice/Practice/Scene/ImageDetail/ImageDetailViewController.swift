//
//  ImageDetailViewController.swift
//  UIPractice
//
//  Created by Ever on 2022/07/14.
//

import UIKit
import SnapKit

class ImageDetailViewController: UIViewController {
    // MARK: - UI
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.delegate = self
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Properties
    var photo: UnsplashPhoto?
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.updateViews()
    }
    
    // MARK: - Layout
    private func setupViews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.imageView)
        
        self.scrollView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.imageView.snp.makeConstraints {
            $0.center.leading.trailing.equalTo(self.scrollView)
        }
    }
    
    // MARK: Networking
    private func updateViews() {
        guard let photo = self.photo,
        let url = URL(string: photo.urls.regular) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
        task.resume()
    }
}

// MARK: - Delegate
extension ImageDetailViewController: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return imageView
  }
}
