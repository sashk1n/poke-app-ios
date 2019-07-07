//
//  PokemonListViewController.swift
//  PokeApp
//
//  Created by marcenuk on 06/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

final class PokemonListViewController: UINavigationController {
    
    private var viewModel: PokemonListViewModel = PokemonListViewModel()
    
    private let tableViewController: UITableViewController
    
    private let tableAdapter: TableAdapter
    
    // MARK: Views
    private var tableView: UITableView {
        return self.tableViewController.tableView
    }
    
    init() {
        self.tableViewController = UITableViewController(style: .grouped)
        self.tableAdapter = TableAdapter(tableView: self.tableViewController.tableView)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.view.setNeedsUpdateConstraints()
    }
    
    func setup() {
        self.navigationBar.barStyle = .default
        self.navigationBar.tintColor = UIColor.black
        
        // TODO: Check this
        self.navigationItem.title = "List"
        self.view.backgroundColor = UIColor.white
    }
}
