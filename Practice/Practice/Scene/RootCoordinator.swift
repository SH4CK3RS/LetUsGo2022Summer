//
//  RootCoordinator.swift
//  Practice
//
//  Created by Ever on 2022/07/30.
//

import UIKit

final class RootCoordinator: Coordinator {
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    private var window: UIWindow
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let imageListCoordinator = ImageListCoordinator(navigationController: navigationController)
        children.append(imageListCoordinator)
        imageListCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
