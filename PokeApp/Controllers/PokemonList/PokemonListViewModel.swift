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
    
    private let service: GetPokemonService
    
    init(service: GetPokemonService) {
        self.service = service
    }
    
    func fetchPokemon() {
        self.service.execute(id: 5)
    }
}
