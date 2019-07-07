//
//  GetPokemonService.swift
//  Domain
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public protocol GetPokemonService {
    
    var onComplete: ((Result<Pokemon, Error>) -> ())? { get }
    
    func execute(id: Int)
}

public class GetPokemonServiceImp: GetPokemonService {
    
    public var onComplete: ((Result<Pokemon, Error>) -> ())?
    
    public func execute(id: Int) {
        let route = GetPokemonDetailRoute(id: id)
        NetworkManager.request(route: route) { [weak self] result in
            self?.onComplete?(result)
        }
    }
    
    public init() {}
}

public struct GetPokemonDetailRoute: NetworkRoute {
    public var path: String { return "/api/\(ApiConstants.version)/pokemon/\(self.id)/" }
    public var method: String { return "GET" }
    
    private let id: Int
    
    public init(id: Int) {
        self.id = id
    }
}
