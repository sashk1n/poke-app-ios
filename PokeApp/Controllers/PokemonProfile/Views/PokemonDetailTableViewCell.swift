//
//  PokemondetailTableViewCell.swift
//  PokeApp
//
//  Created by marcenuk on 10/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

private struct Constants {
    static let titleFont: UIFont = UIFont.boldSystemFont(ofSize: 15)
    static let detailFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    static let textColor: UIColor = UIColor.black    
    static let horizontalOffset: CGFloat = 16.0
}

final class PokemonDetailTableViewCell: TableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.titleFont
        label.textColor = Constants.textColor
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.detailFont
        label.textColor = Constants.textColor
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleLabel.frame = CGRect(x: Constants.horizontalOffset, 
                                       y: 0.0, 
                                       width: 0.0, 
                                       height: 0.0)
        self.titleLabel.sizeToFit()
        self.titleLabel.frame.size.height = self.contentView.bounds.height
        
        self.detailLabel.frame = CGRect(x: self.titleLabel.frame.maxX + Constants.horizontalOffset, 
                                        y: 0.0, 
                                        width: self.contentView.bounds.width - self.titleLabel.bounds.width - 3 * Constants.horizontalOffset, 
                                        height: self.contentView.bounds.height)
    }
    
    override func setup() {
        super.setup()
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.detailLabel)
    }
    
    override func bind(viewModel: TableCellModel) {
        let model = viewModel as! PokemonDetailCellViewModel
        
        self.titleLabel.text = model.title
        self.detailLabel.text = model.detail
        
        self.setNeedsLayout()
    }
    
    override class func height(for viewModel: TableCellModel, tableView: UITableView) -> CGFloat {
        return 60.0
    }
}

struct PokemonDetailCellViewModel: TableCellModel {
    var cellType: TableViewCell.Type { return PokemonDetailTableViewCell.self }
    var cellSelectionHandler: CellSelectionHandler?
    
    let title: String
    let detail: String
    
    init(title: String, detail: String, cellSelectionHandler: CellSelectionHandler?) {
        self.title = title
        self.detail = detail
        self.cellSelectionHandler = cellSelectionHandler
    }
}
