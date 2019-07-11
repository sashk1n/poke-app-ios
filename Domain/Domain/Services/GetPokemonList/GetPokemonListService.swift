//
//  GetPokemonListService.swift
//  Domain
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public typealias ListHandler = (Result<Page, Error>) -> ()

public protocol GetPokemonListService {
  // это два по сути одинаковых метода
    func firstPage(completion: @escaping ListHandler)

    func nextPage(nextPageUrl: URL, completion: @escaping ListHandler)
}

public class GetPokemonListServiceImp: GetPokemonListService {
    
    public func firstPage(completion: @escaping ListHandler) {
        let route = GetPokemonListRoute()
        NetworkClient.request(route: route, completion: completion)
    }
    
    public func nextPage(nextPageUrl: URL, completion: @escaping ListHandler) {
        let route = GetPokemonListRoute(nextPageURL: nextPageUrl)
        NetworkClient.request(route: route, completion: completion)
    }
    
    public init() {}
}
