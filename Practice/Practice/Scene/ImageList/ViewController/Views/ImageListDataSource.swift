//
//  ImageListDataSource.swift
//  Practice
//
//  Created by Ever on 2022/07/30.
//

import UIKit

final class ImageListDataSource: NSObject, UICollectionViewDataSource {
    var imageList: [UnsplashPhoto] = []
    
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
