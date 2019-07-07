//
//  TableHeaderFooterView.swift
//  JWeek
//
//  Created by marcenuk on 24/06/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

open class TableHeaderFooterView: UITableViewHeaderFooterView {
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    open func setup() {
        
    }
    
    open func bind(viewModel: TableHeaderFooterModel) {
        
    }
    
    open class func height(for model: TableHeaderFooterModel, 
                           tableView: UITableView) -> CGFloat {
        return 0.0
    }
}

public protocol TableHeaderFooterModel {
    var viewType: TableHeaderFooterView.Type { get }
}
