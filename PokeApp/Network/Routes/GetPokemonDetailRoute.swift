//
//  GetPokemonDetailRoute.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation
import Domain

struct GetPokemonDetailRoute: NetworkRoute {
    
    private let id: Int
    
    var path: String {
        return "/api/v2/pokemon/\(self.id)/"
    }
    
    var parameters: [URLQueryItem] {
        return []
    }
    
    var method: String {
        return "GET"
    }
    
    init(id: Int) {
        self.id = id
    }
}
