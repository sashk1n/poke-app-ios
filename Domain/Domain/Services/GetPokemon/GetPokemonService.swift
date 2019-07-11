//
//  GetPokemonService.swift
//  Domain
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public typealias PokemonHandler = (Result<Pokemon, Error>) -> ()

public protocol GetPokemonService {
    
    func get(byId id: Int, completion: @escaping PokemonHandler)
    
    func get(byName name: String, completion: @escaping PokemonHandler)
}

public class GetPokemonServiceImp: GetPokemonService {
    
    public func get(byId id: Int, completion: @escaping PokemonHandler) {
        let route = GetPokemonRoute(id: id)
        NetworkClient.request(route: route, completion: completion)
    }
    
    public func get(byName name: String, completion: @escaping PokemonHandler) {
        let route = GetPokemonRoute(name: name)
        NetworkClient.request(route: route, completion: completion)
    }
    
    public init() {}
}
