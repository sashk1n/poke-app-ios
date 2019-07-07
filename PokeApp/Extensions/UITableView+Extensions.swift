//
//  UITableView+Extensions.swift
//  JWeek
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register(cellClass: UITableViewCell.Type) {
        self.register(cellClass,
                      forCellReuseIdentifier: String(describing: cellClass))
    }
    
    func register(headerFooterViewClass: UITableViewHeaderFooterView.Type) {
        self.register(headerFooterViewClass,
                      forHeaderFooterViewReuseIdentifier: String(describing: headerFooterViewClass))
    }
}
