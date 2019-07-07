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
    
    func fetchPokemon() {
        NetworkManager.request(route: GetPokemonDetailRoute(id: 5)) { (result: Result<[String: [Pokemon]], Error>) in
            switch result {
            case .success:
                print(result)
            case .failure:
                print(result)
            }
        }
    }
}
