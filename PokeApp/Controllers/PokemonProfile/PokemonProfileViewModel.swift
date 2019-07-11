//
//  PokemonProfileViewModel.swift
//  PokeApp
//
//  Created by marcenuk on 09/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation
import Domain

struct PokemonProfileArgs {
    let pokemonName: String
}

final class PokemonProfileViewModel {
    var onStartLoading: ActionHandler?
    var onStopLoading: ActionHandler?
    var onUpdateSpriteModel: SingleHandler<TableCellModel>?
    var onProfileData: SingleHandler<[TableSectionModel]>?
    var onError: SingleHandler<Error>?
    
    private var name: String
    
    private var service: GetPokemonService
    
    init(args: PokemonProfileArgs, service: GetPokemonService) {
        self.name = args.pokemonName
        self.service = service
    }
    
    func fetchProfile() {
        self.onStopLoading?()
        self.service.get(byName: self.name, completion: { [weak self] result in
            self?.onStopLoading?()
            
            switch result {
            case .success(let pokemon):
                guard let strongSelf = self else {
                    return
                }
                
                var sections = [TableSectionModel]()
                sections.append(strongSelf.makeGeneralSectionModel(pokemon: pokemon))
                sections.append(strongSelf.makeSpriteSectionModel(pokemon: pokemon))
                self?.onProfileData?(sections)
            case .failure(let error):
                self?.onError?(error)
            }
        })
    }
}

// MARK: Sections.
private extension PokemonProfileViewModel {
    
    func makeGeneralSectionModel(pokemon: Pokemon) -> TableSectionModel {
        var viewModels = [TableCellModel]()
        
        let nameViewModel = self.makePokemonDetailModel(title: "Name", detail: "\(pokemon.name.capitalized)")
        let heightViewModel = self.makePokemonDetailModel(title: "Height", detail: "\(pokemon.height) inch")
        let weightViewModel = self.makePokemonDetailModel(title: "Weight", detail: "\(pokemon.weight) fun")
        
        viewModels.append(contentsOf: [nameViewModel, heightViewModel, weightViewModel])
        
        return DefaultTableSectionModel(cells: viewModels, header: nil, footer: nil)
    }
    
    func makeSpriteSectionModel(pokemon: Pokemon) -> TableSectionModel {
        let spriteViewModel = self.makePokemonSpritesModel(currentValue: 0, spriteURLs: pokemon.sprites.allValues)
        return DefaultTableSectionModel(cells: [spriteViewModel], header: nil, footer: nil)
    }
}

// MARK: Cells.
private extension PokemonProfileViewModel {
    
    func makePokemonDetailModel(title: String, detail: String) -> TableCellModel {
        let model = PokemonDetailCellViewModel(title: title, detail: detail, cellSelectionHandler: nil)
        return model
    }
    
    func makePokemonSpritesModel(currentValue: Int, spriteURLs: [URL]) -> TableCellModel {
        let valueChangingHandler: ((Int) -> Void) = { [unowned self] value in
            let model = self.makePokemonSpritesModel(currentValue: value, spriteURLs: spriteURLs)
            self.onUpdateSpriteModel?(model)
        }
        let model = SpriteViewerCellViewModel(currentValue: currentValue, 
                                              spriteURLs: spriteURLs, 
                                              onChangeValue: valueChangingHandler)
        return model
    }
}
