//
//  Coordinator.swift
//  Practice
//
//  Created by Ever on 2022/07/30.
//

import Foundation
import UIKit

protocol Coordinator {
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

