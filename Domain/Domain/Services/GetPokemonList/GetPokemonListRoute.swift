//
//  GetPokemonListRoute.swift
//  Domain
//
//  Created by marcenuk on 09/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public struct GetPokemonListRoute: NetworkRoute {
    public var path: String
    public var method: String { return "GET" }
    public var parameters: [URLQueryItem]?
    
    public init() { 
        self.path = "/api/\(ApiConstants.version)/pokemon/"
    }
    
    public init(nextPageURL: URL) {
        self.path = nextPageURL.path
        let items = URLComponents(url: nextPageURL, resolvingAgainstBaseURL: false)?.queryItems
        self.parameters = items
    }
}
