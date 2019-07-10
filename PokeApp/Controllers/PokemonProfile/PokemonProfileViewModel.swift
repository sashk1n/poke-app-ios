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
    
    var onProfileData: SingleHandler<[TableSectionModel]>?
    
    private var name: String
    
    private var service: GetPokemonService
    
    init(args: PokemonProfileArgs, service: GetPokemonService) {
        self.name = args.pokemonName
        self.service = service
    }
    
    func fetchProfile() {
        self.service.get(byName: self.name, completion: { [weak self] result in
            switch result {
            case .success(let pokemon):
                guard let strongSelf = self else {
                    return
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

private extension PokemonProfileViewModel {
    
    func makePokemonDetailModel(title: String, detail: String) -> TableCellModel {
        let model = PokemonDetailCellViewModel(title: title, detail: detail, cellSelectionHandler: nil)
        return model
    }
}
