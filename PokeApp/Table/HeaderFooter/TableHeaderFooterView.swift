//
//  TableHeaderFooterView.swift
//  JWeek
//
//  Created by marcenuk on 24/06/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

open class TableHeaderFooterView: UITableViewHeaderFooterView {
    
    fileprivate var didSetupConstraints = false
    
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
    
    open func bind(model: TableHeaderFooterModel) {
        
    }
    
    // TODO: make automatic calculation
    open class func height(for model: TableHeaderFooterModel, 
                           tableView: UITableView) -> CGFloat {
        return 0.0
    }
    
    open func setupConstraints() {
        
    }
    
    open override func updateConstraints() {
        if !self.didSetupConstraints {
            self.setupConstraints()
            self.didSetupConstraints = true
        }
        super.updateConstraints()
    }
}

public protocol TableHeaderFooterModel {
    var viewType: TableHeaderFooterView.Type { get }
}
