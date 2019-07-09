//
//  PokemonProfileViewModel.swift
//  PokeApp
//
//  Created by marcenuk on 09/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

struct PokemonProfileArgs {
    let id: Int
}

final class PokemonProfileViewModel {
    
    var pokemonId: Int
    
    init(args: PokemonProfileArgs) {
        self.pokemonId = args.id
    }
}
