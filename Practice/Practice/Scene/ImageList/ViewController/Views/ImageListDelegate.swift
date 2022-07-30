//
//  ImageListDelegate.swift
//  Practice
//
//  Created by Ever on 2022/07/30.
//

import UIKit

final class ImageListDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    var imageList: [UnsplashPhoto] = []
    var selectingImageClosure: ((UnsplashPhoto) -> Void)?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = imageList[indexPath.item]
        self.selectingImageClosure?(image)
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
