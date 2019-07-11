//
//  PokemonListViewController.swift
//  PokeApp
//
//  Created by marcenuk on 06/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

private struct Constants {
    static let title: String = "Pokemons"
}

final class PokemonListViewController: UIViewController {
    
    var viewModel: PokemonListViewModel!
    var router: PokemonListRouter!
    
    private let tableViewController: UITableViewController
    
    private let tableAdapter: TableAdapter
    
    // MARK: Views
    private var tableView: UITableView {
        return self.tableViewController.tableView
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view 
    }()
    
    init() {
        self.tableViewController = UITableViewController(style: .plain)
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

      // зачем это делать в методе viewWillAppear?
      // каждый раз, когда ты будешь переходить с экрана Детали на экран Список, будет вызываться этот метод.
      // setupNavigationBar надо перенести в setup()
        self.setupNavigationBar()
    }
    
    func setup() {
      // зачем везде писать self?! из контекста же ясно, к чему это относится
        self.view.backgroundColor = UIColor.white
        
        self.setupTable()
        self.setupBindings()
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = Constants.title
    }
    
    func setupTable() {
        self.tableViewController.willMove(toParent: self)
        self.addChild(self.tableViewController)
        self.view.addSubview(self.tableView)        
        self.tableViewController.didMove(toParent: self)
        
        self.tableViewController.refreshControl = self.refreshControl
        
        self.tableView.backgroundColor = UIColor.white
        self.tableView.contentInsetAdjustmentBehavior = .never
        
        self.tableView.register(cellClass: PokemonTableViewCell.self)
        self.tableView.register(cellClass: LoadingTableViewCell.self)
        
        self.tableAdapter.onScrollToBottom = { [weak self] in
            self?.viewModel.fetchNextPage()
        }
    }
    
    func setupBindings() {
      // VC держит refreshControl => время жизни refreshControl больше или меньше VC?
      // мб здесь и ниже нужно использовать unowned self?
        self.viewModel.onStartLoading = { [weak self] in
            self?.refreshControl.beginRefreshing()
        }
        self.viewModel.onStopLoading = { [weak self] in
            self?.refreshControl.endRefreshing()
        }
        self.viewModel.onFirstPage = { [weak self] models in
            let sectionModel = DefaultTableSectionModel(cells: models, header: nil, footer: nil)
            self?.tableAdapter.update(viewModels: [sectionModel])
        }
        
        self.viewModel.onNextPage = { [weak self] models in
            self?.tableAdapter.performUpdates { tableAdapter in
                tableAdapter.delete(tableAdapter.rows(in: 0) - 1, in: 0)
                tableAdapter.append(models, in: 0)
            }
        }
        self.viewModel.onOutOfPages = { [unowned self] in
            self.tableAdapter.delete(self.tableAdapter.rows(in: 0) - 1, in: 0)
        }
        self.viewModel.onSelectPokemon = { [unowned self] name in
            let args = PokemonProfileArgs(pokemonName: name)
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

// MARK: Actions
private extension PokemonListViewController {
    
    @objc
    func refresh(sender: UIRefreshControl) {
        self.viewModel.fetchFirstPage()
    }
}
