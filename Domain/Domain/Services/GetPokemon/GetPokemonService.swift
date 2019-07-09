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
        let route = GetPokemonRoute(id: id)
        NetworkManager.request(route: route) { [weak self] result in
            self?.onComplete?(result)
        }
    }
    
    public init() {}
}
