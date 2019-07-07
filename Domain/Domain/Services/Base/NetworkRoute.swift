//
//  Router.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public protocol NetworkRoute {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parameters: [URLQueryItem]? { get }
    var method: String  { get }
}

extension NetworkRoute {
    
    public var scheme: String {
        return "https"
    }
    
    public var host: String {
        return "pokeapi.co"
    }
    
    public var parameters: [URLQueryItem]? {
        return nil
    }
}
