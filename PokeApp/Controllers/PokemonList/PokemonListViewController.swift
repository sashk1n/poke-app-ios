//
//  PokemonListViewController.swift
//  PokeApp
//
//  Created by marcenuk on 06/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

final class PokemonListViewController: UIViewController {
    
    var viewModel: PokemonListViewModel!
    var router: PokemonListRouter!
    
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
        self.viewModel.fetchFirstPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavigationBar()
    }
    
    func setup() {
        self.view.backgroundColor = UIColor.white
        
        self.setupTable()
        self.setupBindings()
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = "Pokemon list"
    }
    
    func setupTable() {
        self.tableViewController.willMove(toParent: self)
        self.addChild(self.tableViewController)
        self.view.addSubview(self.tableView)        
        self.tableViewController.didMove(toParent: self)
        
        self.tableView.backgroundColor = UIColor.white
        self.tableView.contentInsetAdjustmentBehavior = .never
        
        self.tableView.register(cellClass: PokemonTableViewCell.self)
        self.tableView.register(headerFooterViewClass: LoadingTableFooterView.self)
        
        self.tableAdapter.onScrollToBottom = { [weak self] in
            self?.viewModel.fetchNextPage()
        }
    }
    
    func setupBindings() {
        self.viewModel.onFirstPage = { [weak self] models in
            let sectionModel = DefaultTableSectionModel(cells: models, 
                                                        header: nil, 
                                                        footer: LoadingTableCellViewModel())
            self?.tableAdapter.update(viewModels: [sectionModel])
        }
        
        self.viewModel.onNextPage = { [weak self] models in
            self?.tableAdapter.append(models, in: 0)
        }
        self.viewModel.onOutOfPages = { [unowned self] in
            print("out of pages")
            // TODO: remove footer
        }
        self.viewModel.onSelectPokemon = { [unowned self] id in
            let args = PokemonProfileArgs(id: id)
            self.router.routeToPokemonProfile(args: args, from: self)
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
