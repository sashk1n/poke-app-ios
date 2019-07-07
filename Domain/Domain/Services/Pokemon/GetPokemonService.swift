//
//  GetPokemonService.swift
//  Domain
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public protocol GetPokemonService {
    
    func execute(id: Int)
}

public class GetPokemonServiceImp: GetPokemonService {
    
    var onComplete: ((Result<Pokemon, Error>) -> ())?
    
    public func execute(id: Int) {
        let route = GetPokemonDetailRoute(id: id)
        NetworkManager.request(route: route) { [weak self] result in
            self?.onComplete?(result)
        }
    }
}

public struct GetPokemonDetailRoute: NetworkRoute {
    public var path: String { return "/api/v2/pokemon/\(self.id)/" }
    public var method: String { return "GET" }
    
    private let id: Int
    
    public init(id: Int) {
        self.id = id
    }
}
