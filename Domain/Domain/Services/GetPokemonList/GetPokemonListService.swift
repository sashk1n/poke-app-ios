//
//  GetPokemonListService.swift
//  Domain
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public protocol GetPokemonListService {
    
    func firstPage(completion: @escaping ((Result<Page, Error>) -> ()))
    
    func nextPage(nextPageUrl: URL, completion: @escaping ((Result<Page, Error>) -> ()))
}

public class GetPokemonListServiceImp: GetPokemonListService {
    
    public func firstPage(completion: @escaping ((Result<Page, Error>) -> ())) {
        let route = GetPokemonListRoute()
        NetworkManager.request(route: route, completion: completion)
    }
    
    public func nextPage(nextPageUrl: URL, completion: @escaping ((Result<Page, Error>) -> ())) {
        let route = GetPokemonListRoute(nextPageURL: nextPageUrl)
        NetworkManager.request(route: route, completion: completion)
    }
    
    public init() {}
}
