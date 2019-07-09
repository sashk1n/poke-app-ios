//
//  PokemonListRouter.swift
//  PokeApp
//
//  Created by marcenuk on 09/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit
import Domain

final class PokemonListRouter {
    
    func routeToPokemonProfile(args: PokemonProfileArgs, from viewController: UIViewController) {
        let pokemonProfileviewController = self.makePokemonProfileViewController(args: args)
        viewController.navigationController?.pushViewController(pokemonProfileviewController, animated: true)
    }
}

private extension PokemonListRouter {
    
    func makePokemonProfileViewController(args: PokemonProfileArgs) -> UIViewController {
        let viewController = PokemonProfileViewController()
        let viewModel = PokemonProfileViewModel(args: args, service: GetPokemonServiceImp())
        viewController.viewModel = viewModel
        return viewController
    }
}
