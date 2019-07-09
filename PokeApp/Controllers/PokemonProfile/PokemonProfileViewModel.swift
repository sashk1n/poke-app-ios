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
    
    // TODO: in delegates!
    var onProfileData: SingleHandler<[TableSectionModel]>?
    
    private var name: String
    
    private var service: GetPokemonService
    
    init(args: PokemonProfileArgs, service: GetPokemonService) {
        self.name = args.pokemonName
        self.service = service
    }
    
    func fetchProfile() {
        
    }
}
