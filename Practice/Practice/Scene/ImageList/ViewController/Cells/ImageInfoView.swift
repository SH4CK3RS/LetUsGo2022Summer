//
//  ImageInfoView.swift
//  UIPractice
//
//  Created by Ever on 2022/07/14.
//

import UIKit
import SnapKit

class ImageInfoView: UIView {
    let userNameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "user name:"
        label.textColor = .black
        return label
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let widthTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "width:"
        label.textColor = .black
        return label
    }()
    
    let widthLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let heightTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "height:"
        label.textColor = .black
        return label
    }()
    
    let heightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureInfo(with image: UnsplashPhoto) {
        self.userNameLabel.text = image.user.name
        self.widthLabel.text = "\(image.width)"
        self.heightLabel.text = "\(image.height)"
    }
    
    private func setupViews() {
        [
            userNameTitleLabel, userNameLabel,
            widthTitleLabel, widthLabel,
            heightTitleLabel, heightLabel
        ].forEach {
            self.addSubview($0)
        }
        
        userNameTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
        }
        
        widthTitleLabel.snp.makeConstraints {
            $0.top.equalTo(userNameTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
        }
        
        widthLabel.snp.makeConstraints {
            $0.centerY.equalTo(widthTitleLabel)
            $0.trailing.equalToSuperview()
        }
        
        heightTitleLabel.snp.makeConstraints {
            $0.top.equalTo(widthTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        heightLabel.snp.makeConstraints {
            $0.centerY.equalTo(heightTitleLabel)
            $0.trailing.equalToSuperview()
        }
    }
}
