//
//  Router.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

struct ApiConstants {
  // можно и не указывать тип :String, это и так видно из объявления
    static let scheme: String = "https"
    static let host: String = "pokeapi.co"
    static let version: String = "v2"
}

public protocol NetworkRoute {
  // почему бы не определить перечисление?
  //  enum Scheme {
  //    case https
  //    case http
  //  }
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parameters: [URLQueryItem]? { get }
  // аналогично
//  enum Method {
//    case get
//    case post
//    case ...
//  }
    var method: String  { get }
}

public extension NetworkRoute {
    
    var scheme: String {
        return ApiConstants.scheme
    }
    
    var host: String {
        return ApiConstants.host
    }
    
    var parameters: [URLQueryItem]? {
        return nil
    }
}
