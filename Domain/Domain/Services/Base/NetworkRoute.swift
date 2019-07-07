//
//  Router.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

struct ApiConstants {
    static let scheme: String = "https"
    static let host: String = "pokeapi.co"
    static let version: String = "v2"
}

public protocol NetworkRoute {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parameters: [URLQueryItem]? { get }
    var method: String  { get }
}

extension NetworkRoute {
    
    public var scheme: String {
        return ApiConstants.scheme
    }
    
    public var host: String {
        return ApiConstants.host
    }
    
    public var parameters: [URLQueryItem]? {
        return nil
    }
}
