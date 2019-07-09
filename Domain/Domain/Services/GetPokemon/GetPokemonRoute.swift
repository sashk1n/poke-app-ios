//
//  GetPokemonDetailRoute.swift
//  Domain
//
//  Created by marcenuk on 09/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public struct GetPokemonRoute: NetworkRoute {
    public var path: String { return "/api/\(ApiConstants.version)/pokemon/\(self.id)/" }
    public var method: String { return "GET" }
    
    private let id: Int
    
    public init(id: Int) {
        self.id = id
    }
}
