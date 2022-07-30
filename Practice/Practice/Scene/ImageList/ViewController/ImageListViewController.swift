//
//  ViewController.swift
//  UIPractice
//
//  Created by Ever on 2022/06/28.
//

import UIKit
import SnapKit

class ImageListViewController: UIViewController {
    private let mainView = ImageListView()
    
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
        let queryString = PhotoRequestDTO(page: 1, perPage: 20).queryString
        let urlString = "https://api.unsplash.com/photos" + queryString
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue("Client-ID \(Constants.clientId)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let list = try? JSONDecoder().decode([UnsplashPhoto].self, from: data) {
                self.mainView.imageList = list
            }
        }
        task.resume()
    }
}

extension ImageListViewController: ImageViewListActionListener {
    func imageViewListDidTapDetailButton(with photo: UnsplashPhoto?) {
        let detailViewController = ImageDetailViewController()
        detailViewController.photo = photo
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
