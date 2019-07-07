//
//  TableViewCell.swift
//  JWeek
//
//  Created by marcenuk on 24/06/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

public typealias CellSelectionHandler = ((IndexPath) -> Void)
public typealias CellActionHandler = ((UITableViewCell) -> Void)
public typealias CellEditHandler = ((UITableViewCell.EditingStyle, IndexPath) -> Void)

open class TableViewCell: UITableViewCell {
    
    private var didSetupConstraints = false
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    open func setup() {
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
        self.selectionStyle = .none
    }
    
    open func bind(viewModel: TableCellModel) {
        
    }
    
    open class func height(for viewModel: TableCellModel,
                           tableView: UITableView) -> CGFloat {
        return 0.0
    }
    
    override open func prepareForReuse() {
        super.prepareForReuse()
    }
}

public protocol TableCellModel {
    var cellType: TableViewCell.Type { get }
    var cellSelectionHandler: CellSelectionHandler? { get }
    
    var cellEditHandler: CellEditHandler? { get }
    var editRowActions: [UITableViewRowAction]? { get }
    var canEdit: Bool { get }
}

extension TableCellModel {
    
    var reuseIdentifier: String {
        return String(describing: self.cellType)
    }
}

extension TableCellModel {
    
    var canEdit: Bool {
        return false
    }
    
    var cellEditHandler: CellEditHandler? {
        return nil
    }
    
    var editRowActions: [UITableViewRowAction]? {
        return nil
    }
}
