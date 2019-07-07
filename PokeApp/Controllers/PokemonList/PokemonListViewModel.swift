//
//  PokemonListViewModel.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation
import Domain

final class PokemonListViewModel {
    
    var onFirstPage: (([TableCellModel]) -> Void)?
    var onNextPage: (([TableCellModel]) -> Void)?
    var onError: ((Error) -> Void)?
    var onOutOfPages: ActionHandler?
    var isLoading: Bool = true
    
    private var nextPageURL: URL? = nil
    
    private var service: GetPokemonListService
    
    init(service: GetPokemonListService) {
        self.service = service
        
        self.service.onFirstPage = { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            self?.isLoading = false
            switch result {
            case .success(let page):
                
                
                strongSelf.nextPageURL = page.next
                
                let models = page.results.map { strongSelf.makePokemonCellViewModel(pokemonModel: $0) }
                self?.onFirstPage?(models)
            case .failure(let error):
                self?.onError?(error)
            }
        }
        
        self.service.onNextPage = { [weak self] result in
            guard let strongSelf = self else {
                return
            }

            self?.isLoading = false
            switch result {
            case .success(let page):
                
                
                strongSelf.nextPageURL = page.next
                
                let models = page.results.map { strongSelf.makePokemonCellViewModel(pokemonModel: $0) } 
                self?.onNextPage?(models)
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    
    func fetchFirstPage() {
        self.isLoading = true
        self.service.firstPage()
    }
    
    func fetchNextPage() {
        guard !self.isLoading else {
            return
        }
        
        self.isLoading = true
        guard let nextPageUrl = self.nextPageURL else {
            self.onOutOfPages?()
            return
        }
        
        self.service.nextPage(nextPageUrl: nextPageUrl)
    }
}

// MARK: Support
private extension PokemonListViewModel {
    
    func makePokemonCellViewModel(pokemonModel: NamedEntity) -> TableCellModel {
        let cellViewModel = PokemonCellViewModel(name: pokemonModel.name.capitalized, cellSelectionHandler: nil)
        return cellViewModel
    }
}
