//
//  AppDelegate.swift
//  PokeApp
//
//  Created by marcenuk on 06/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit
import Domain

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, 
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = self.makeListViewController()
        window!.rootViewController = UINavigationController(rootViewController: viewController)
        window!.makeKeyAndVisible()
        return true
    }
}

private extension AppDelegate {
    
    func makeListViewController() -> UIViewController {
        let viewController = PokemonListViewController()
        
        let viewModel = PokemonListViewModel(service: GetPokemonListServiceImp())
        viewController.viewModel = viewModel
        
        let router = PokemonListRouter()
        viewController.router = router
        
        return viewController
    }
}
