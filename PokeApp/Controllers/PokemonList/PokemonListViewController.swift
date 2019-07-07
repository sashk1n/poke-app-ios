//
//  PokemonListViewController.swift
//  PokeApp
//
//  Created by marcenuk on 06/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

final class PokemonListViewController: UIViewController {
    
    private var viewModel: PokemonListViewModel
    
    private let tableViewController: UITableViewController
    
    private let tableAdapter: TableAdapter
    
    // MARK: Views
    private var tableView: UITableView {
        return self.tableViewController.tableView
    }
    
    init(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
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
        self.viewModel.fetchFirstPage()
    }
    
    func setup() {
        self.setupNavigationBar()
        self.setupTable()
        self.setupBindings()
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = "Pokemon list"
        self.view.backgroundColor = UIColor.white
    }
    
    func setupTable() {
        self.tableView.backgroundColor = UIColor.white
        self.tableView.contentInsetAdjustmentBehavior = .never
        self.tableView.register(cellClass: PokemonTableViewCell.self)

        self.tableViewController.willMove(toParent: self)
        self.addChild(self.tableViewController)
        self.view.addSubview(self.tableView)        
        self.tableViewController.didMove(toParent: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("nav = nil: \(self.navigationController == nil)")
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
    }
    
    func setupBindings() {
        self.viewModel.onFirstPage = { [weak self] models in
            let sectionModel = DefaultTableSectionModel(cells: models, header: nil, footer: nil)
            self?.tableAdapter.update(viewModels: [sectionModel])
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.tableView.frame = CGRect(x: 0.0, 
                                      y: self.view.safeAreaInsets.top, 
                                      width: self.view.safeAreaLayoutGuide.layoutFrame.width, 
                                      height: self.view.safeAreaLayoutGuide.layoutFrame.height)
    }
}
