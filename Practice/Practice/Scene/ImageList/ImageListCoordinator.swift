//
//  ImageListCoordinator.swift
//  Practice
//
//  Created by Ever on 2022/07/30.
//

import UIKit
protocol ImageListCoordinatorDelegate: AnyObject {
    func goToDetail(with photo: UnsplashPhoto?)
}
final class ImageListCoordinator: Coordinator {
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let imageListViewController = ImageListViewController()
        imageListViewController.coordinator = self
        navigationController.setViewControllers([imageListViewController], animated: true)
    }
}

extension ImageListCoordinator: ImageListCoordinatorDelegate {
    func goToDetail(with photo: UnsplashPhoto?) {
        let detailViewController = ImageDetailViewController()
        detailViewController.photo = photo
        self.navigationController.pushViewController(detailViewController, animated: true)
    }
}
