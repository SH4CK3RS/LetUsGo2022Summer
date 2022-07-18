//
//  RequestDTO.swift
//  UIPractice
//
//  Created by Ever on 2022/07/14.
//

import Foundation

struct PhotoRequestDTO {
  let page: Int
  let perPage: Int
  
  var queryString: String {
    var str = "?page=\(page)"
    str += "&per_page=\(perPage)"
    return str
  }
}

struct SearchRequestDTO {
  let query: String
  let page: Int
  let perPage: Int
  
  var queryString: String {
    var str = "?query=\(query)"
    str += "&page=\(page)"
    str += "&per_page=\(perPage)"
    return str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
  }
}
