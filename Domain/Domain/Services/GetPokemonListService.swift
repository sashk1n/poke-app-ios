//
//  GetPokemonListService.swift
//  Domain
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public protocol GetPokemonListService {
    
    var onFirstPage: ((Result<Page, Error>) -> ())? { get set }
    var onNextPage: ((Result<Page, Error>) -> ())? { get set }
    
    func firstPage()
    
    func nextPage(nextPageUrl: URL)
}

public class GetPokemonListServiceImp: GetPokemonListService {
    
    public var onFirstPage: ((Result<Page, Error>) -> ())?
    public var onNextPage: ((Result<Page, Error>) -> ())?
    
    public func firstPage() {
        let route = GetPokemonListRoute()
        NetworkManager.request(route: route) { [weak self] result in
            self?.onFirstPage?(result)
        }
    }
    
    public func nextPage(nextPageUrl: URL) {
        let route = GetPokemonListRoute(nextPageURL: nextPageUrl)
        NetworkManager.request(route: route) { [weak self] result in
            self?.onNextPage?(result)
        }
    }
    
    public init() {}
}

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
