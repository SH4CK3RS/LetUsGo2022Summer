//
//  AppDelegate.swift
//  UIPractice
//
//  Created by Ever on 2022/06/28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let imageListViewController = ImageListViewController()
        let navigationController = UINavigationController(rootViewController: imageListViewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        return true
    }
    
}

