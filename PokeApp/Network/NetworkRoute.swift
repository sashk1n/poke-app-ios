//
//  Router.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

protocol NetworkRoute {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: String  { get }
}

extension NetworkRoute {
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "pokeapi.co"
    }
}
