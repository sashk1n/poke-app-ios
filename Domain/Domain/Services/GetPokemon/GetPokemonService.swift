//
//  GetPokemonService.swift
//  Domain
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public protocol GetPokemonService {
    
    func get(byId id: Int, completion: @escaping (Result<Pokemon, Error>) -> ())
    
    func get(byName name: String, completion: @escaping (Result<Pokemon, Error>) -> ())
}

public class GetPokemonServiceImp: GetPokemonService {
    
    public func get(byId id: Int, completion: @escaping (Result<Pokemon, Error>) -> ()) {
        let route = GetPokemonRoute(id: id)
        NetworkManager.request(route: route, completion: completion)
    }
    
    public func get(byName name: String, completion: @escaping (Result<Pokemon, Error>) -> ()) {
        let route = GetPokemonRoute(name: name)
        NetworkManager.request(route: route, completion: completion)
    }
    
    public init() {}
}
