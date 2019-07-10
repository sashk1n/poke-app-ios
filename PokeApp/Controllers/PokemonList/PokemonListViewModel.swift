//
//  PokemonListViewModel.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation
import Domain

private struct Constants {
    static let title: String = "Pokemon profile"
}

final class PokemonListViewModel {
    
    var onFirstPage: (([TableCellModel]) -> Void)?
    var onNextPage: (([TableCellModel]) -> Void)?
    var onError: ((Error) -> Void)?
    var onOutOfPages: ActionHandler?
    var onSelectPokemon: StringHandler?
    
    private var nextPageURL: URL? = nil
    private var isLoading: Bool = true
    
    private var service: GetPokemonListService
    
    init(service: GetPokemonListService) {
        self.service = service
    }
    
    func fetchFirstPage() {
        self.isLoading = true
        self.service.firstPage(completion: { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            self?.isLoading = false
            switch result {
            case .success(let page):
                strongSelf.nextPageURL = page.next
                
                var models = page.results.map { strongSelf.makePokemonCellViewModel(pokemonModel: $0) }
                if page.next != nil {
                    models.append(strongSelf.makeLoadingCellViewModel())
                }
                
                self?.onFirstPage?(models)
            case .failure(let error):
                self?.onError?(error)
            }
        })
    }
    
    func fetchNextPage() {
        guard !self.isLoading else {
            return
        }
        
        guard let nextPageUrl = self.nextPageURL else {
            self.onOutOfPages?()
            self.isLoading = false            
            return
        }
        
        self.isLoading = true
        self.service.nextPage(nextPageUrl: nextPageUrl, completion: { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            self?.isLoading = false
            
            switch result {
            case .success(let page):
                strongSelf.nextPageURL = page.next
                
                var models = page.results.map { strongSelf.makePokemonCellViewModel(pokemonModel: $0) }
                if page.next != nil {
                    models.append(strongSelf.makeLoadingCellViewModel())
                }
                
                self?.onNextPage?(models)
            case .failure(let error):
                self?.onError?(error)
            }
        })
    }
}

// MARK: Cells.
private extension PokemonListViewModel {
    
    func makePokemonCellViewModel(pokemonModel: NamedEntity) -> TableCellModel {
        let cellSelectionHandler: CellSelectionHandler = { [unowned self] _ in
            self.onSelectPokemon?(pokemonModel.name)
        }
        let cellViewModel = PokemonCellViewModel(name: pokemonModel.name.capitalized,
                                                 imageURL: pokemonModel.pokemonImageURL,
                                                 cellSelectionHandler: cellSelectionHandler)
        return cellViewModel
    }
    
    func makeLoadingCellViewModel() -> TableCellModel {
        let cellViewModel = LoadingTableCellViewModel() 
        return cellViewModel
    }
}
