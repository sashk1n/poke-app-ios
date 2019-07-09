//
//  PokemonTableViewCell.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

private struct Constants {
    static let font: UIFont = UIFont.systemFont(ofSize: 15)
    static let textColor: UIColor = UIColor.black    
    static let horizontalOffset: CGFloat = 16.0
    static let imageSize: CGSize = CGSize(width: 50, height: 50)
}

final class PokemonTableViewCell: TableViewCell {
    
    private lazy var nameTextLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.font
        label.textColor = Constants.textColor
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func setup() {
        super.setup()
        
        self.contentView.addSubview(self.nameTextLabel)
        self.contentView.addSubview(self.avatarImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.avatarImageView.frame = CGRect(x: self.contentView.bounds.maxX - Constants.horizontalOffset - Constants.imageSize.width,
                                            y: 5.0, 
                                            width: Constants.imageSize.width, 
                                            height: Constants.imageSize.height)
        
        self.nameTextLabel.frame = CGRect(x: Constants.horizontalOffset, 
                                          y: 0.0, 
                                          width: self.avatarImageView.frame.minX - 2 * Constants.horizontalOffset, 
                                          height: self.contentView.bounds.height)
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView?.image = nil
    }
    
    override func bind(viewModel: TableCellModel) {
        let model = viewModel as! PokemonCellViewModel
        
        self.nameTextLabel.text = model.name
        self.avatarImageView.setImage(from: model.imageURL)
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    override class func height(for viewModel: TableCellModel, tableView: UITableView) -> CGFloat {
        return 65.0
    }
}

struct PokemonCellViewModel: TableCellModel {
    var cellType: TableViewCell.Type { return PokemonTableViewCell.self }
    var cellSelectionHandler: CellSelectionHandler?
    
    let name: String
    let imageURL: URL?
    
    init(name: String, imageURL: URL?, cellSelectionHandler: CellSelectionHandler?) {
        self.name = name
        self.imageURL = imageURL
        self.cellSelectionHandler = cellSelectionHandler
    }
}
