//
//  PokemonProfileViewController.swift
//  PokeApp
//
//  Created by marcenuk on 09/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

final class PokemonProfileViewController: UIViewController {
    
    var viewModel: PokemonProfileViewModel!
    //var router
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        //self.viewModel.fetchFirstPage()
        
    }
    
    func setup() {
        self.view.backgroundColor = UIColor.white
        
        
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = "Pokemon"
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavigationBar()
    }
}
