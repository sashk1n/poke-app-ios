//
//  LoadingTableFooterView.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

public class LoadingTableFooterView: TableHeaderFooterView {
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        return indicator
    }()
    
    public override func setup() {
        super.setup()
        
        self.contentView.addSubview(self.loadingView)
    }
    
    public override func bind(viewModel: TableHeaderFooterModel) {
        self.loadingView.startAnimating()
    }
    
    public override class func height(for viewModel: TableHeaderFooterModel, tableView: UITableView) -> CGFloat {
        return 56.0
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.loadingView.center = self.contentView.center
    }
}

public struct LoadingTableCellViewModel: TableHeaderFooterModel {
    public var viewType: TableHeaderFooterView.Type { return LoadingTableFooterView.self }
}
