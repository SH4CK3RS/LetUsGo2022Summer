//
//  ImageDownloader.swift
//  Practice
//
//  Created by Ever on 2022/07/30.
//

import Foundation

enum ImageDownloaderError: Error {
    case downloadFailed
}

struct ImageDownloader {
    func getImages(completion: @escaping ( Result<[UnsplashPhoto], ImageDownloaderError>) -> Void) {
        guard let request = buildRequest() else {
            completion(.failure(.downloadFailed))
            return
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let list = try? JSONDecoder().decode([UnsplashPhoto].self, from: data) {
                completion(.success(list))
            } else {
                completion(.failure(.downloadFailed))
            }
        }
        task.resume()
    }
    
    private func buildRequest() -> URLRequest? {
        let queryString = PhotoRequestDTO(page: 1, perPage: 20).queryString
        let urlString = "https://api.unsplash.com/photos" + queryString
        guard let url = URL(string: urlString) else { return nil }
        var request = URLRequest(url: url)
        request.setValue("Client-ID \(Constants.clientId)", forHTTPHeaderField: "Authorization")
        return request
    }
}
