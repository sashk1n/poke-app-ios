//
//  PokemonListRouter.swift
//  PokeApp
//
//  Created by marcenuk on 09/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

final class PokemonListRouter {
    
    func routeToPokemonProfile(args: PokemonProfileArgs, from viewController: UIViewController) {
        let pokemonProfileviewController = self.makePokemonProfileViewController(args: args)
        viewController.navigationController?.pushViewController(pokemonProfileviewController, animated: true)
    }
}

private extension PokemonListRouter {
    
    func makePokemonProfileViewController(args: PokemonProfileArgs) -> UIViewController {
        // TODO: Create view model
        let viewController = PokemonProfileViewController()
        
        let viewModel = PokemonProfileViewModel(args: args)
        viewController.viewModel = viewModel
        return viewController
    }
}
