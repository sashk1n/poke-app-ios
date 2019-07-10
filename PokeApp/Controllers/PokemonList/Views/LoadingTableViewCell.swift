//
//  LoadingTableViewCell.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

public class LoadingTableViewCell: TableViewCell {
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        return indicator
    }()
    
    public override func setup() {
        super.setup()
        
        self.contentView.addSubview(self.loadingView)
    }
    
    public override func bind(viewModel: TableCellModel) {
        self.loadingView.startAnimating()
    }
    
    public override class func height(for viewModel: TableCellModel, tableView: UITableView) -> CGFloat {
        return 56.0
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.loadingView.center = self.contentView.center
    }
}

public struct LoadingTableCellViewModel: TableCellModel {
    public var cellSelectionHandler: CellSelectionHandler? { return nil }
    public var cellType: TableViewCell.Type { return LoadingTableViewCell.self }
}
