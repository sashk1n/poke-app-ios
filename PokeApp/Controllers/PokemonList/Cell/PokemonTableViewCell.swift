//
//  PokemonTableViewCell.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

private struct Constants {
    static let font: UIFont = UIFont.systemFont(ofSize: 14)
    static let textColor: UIColor = UIColor.black    
    static let horizontalOffset: CGFloat = 16.0
}

final class PokemonTableViewCell: TableViewCell {
    
    private lazy var nameTextLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.font
        label.textColor = Constants.textColor
        label.numberOfLines = 1
        return label
    }()
    
    override func setup() {
        super.setup()
        
        self.contentView.addSubview(self.nameTextLabel)
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.nameTextLabel.frame = CGRect(x: Constants.horizontalOffset, 
                                          y: 0.0, 
                                          width: self.contentView.bounds.width - 2 * Constants.horizontalOffset, 
                                          height: self.contentView.bounds.height)
    }
    
    override func bind(viewModel: TableCellModel) {
        let model = viewModel as! PokemonCellViewModel
        
        self.nameTextLabel.text = model.name
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    override class func height(for viewModel: TableCellModel, tableView: UITableView) -> CGFloat {
        return 50.0
    }
}

struct PokemonCellViewModel: TableCellModel {
    var cellType: TableViewCell.Type { return PokemonTableViewCell.self }
    var cellSelectionHandler: CellSelectionHandler?
    
    let name: String
    
    init(name: String, cellSelectionHandler: CellSelectionHandler?) {
        self.name = name
        self.cellSelectionHandler = cellSelectionHandler
    }
}
