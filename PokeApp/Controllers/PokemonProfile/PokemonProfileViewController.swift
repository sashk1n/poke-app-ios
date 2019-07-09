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
        self.viewModel.fetchProfile()
    }
    
    func setup() {
        self.view.backgroundColor = UIColor.white
        
        self.setupTable()
        self.setupBindings()
    }
    
    func setupNavigationBar() {
        //self.navigationController?.navigationBar.prefersLargeTitles = false
        //self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = "Pokemon profile"
    }
    
    func setupTable() {
        self.tableViewController.willMove(toParent: self)
        self.addChild(self.tableViewController)
        self.view.addSubview(self.tableView)        
        self.tableViewController.didMove(toParent: self)
        
        self.tableView.backgroundColor = UIColor.white
        self.tableView.contentInsetAdjustmentBehavior = .never
        
        // TODO: register needed cells
        //self.tableView.register(cellClass: PokemonTableViewCell.self)
    }
    
    func setupBindings() {
        self.viewModel.onProfileData = { [weak self] sections in
            self?.tableAdapter.update(viewModels: sections)
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
