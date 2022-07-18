//
//  UnsplashPhoto.swift
//  UIPractice
//
//  Created by Ever on 2022/07/10.
//

import UIKit

public struct UnsplashUser: Codable {
  public let name: String?
  
  private enum CodingKeys: String, CodingKey {
    case name
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try? container.decode(String.self, forKey: .name)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try? container.encode(name, forKey: .name)
  }
  
}

public struct UnsplashPhoto: Decodable {
  public struct Urls: Codable {
    public let raw, full, regular, small: String
    public let thumb, smallS3: String
    
    enum CodingKeys: String, CodingKey {
      case raw, full, regular, small, thumb
      case smallS3 = "small_s3"
    }
  }
  
  public let urls: Urls
  public let width: CGFloat
  public let height: CGFloat
  public let user: UnsplashUser
  
  private enum CodingKeys: String, CodingKey {
    case urls
    case width
    case height
    case user
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    urls = try container.decode(Urls.self, forKey: .urls)
    width = try container.decode(CGFloat.self, forKey: .width)
    height = try container.decode(CGFloat.self, forKey: .height)
    user = try container.decode(UnsplashUser.self, forKey: .user)
  }
  
  public func adjustSize(with width: CGFloat) -> CGSize {
    let height = height * width / self.width
    return .init(width: width, height: height)
  }
}

public struct UnsplashSearchResult: Decodable {
  public let results: [UnsplashPhoto]
  
  private enum CodingKeys: String, CodingKey {
    case results
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    results = try container.decode([UnsplashPhoto].self, forKey: .results)
  }
}
