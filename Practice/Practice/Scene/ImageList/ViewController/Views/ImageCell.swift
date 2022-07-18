//
//  ImageCell.swift
//  UIPractice
//
//  Created by Ever on 2022/07/10.
//

import UIKit
import SnapKit

class ImageCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureCell(with image: UnsplashPhoto) {
        let thumbUrl = image.urls.thumb
        self.downloadImage(with: thumbUrl)
    }
    
    private func setupImageView() {
        self.contentView.addSubview(self.imageView)
        self.imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func downloadImage(with urlStr: String) {
        guard let url = URL(string: urlStr) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
        task.resume()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
}

