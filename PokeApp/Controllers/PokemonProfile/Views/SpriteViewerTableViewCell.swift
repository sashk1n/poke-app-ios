//
//  SpriteViewerTableViewCell.swift
//  PokeApp
//
//  Created by marcenuk on 10/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

private struct Constants {
    static let imageSize: CGSize = CGSize(width: 45.0, height: 45.0)
    static let verticalOffset: CGFloat = 8.0
    static let horizontalOffset: CGFloat = 16.0
}

final class SpriteViewerTableViewCell: TableViewCell {
    
    private var spriteURLs = [URL]()
    
    private lazy var slider: UISlider = {
        let view = UISlider()
        view.addTarget(self, action: #selector(changeVlaue), for: .valueChanged)
        return view
    }()
    
    private lazy var spriteImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.spriteImageView.frame = CGRect(x: 0.0, 
                                            y: Constants.verticalOffset, 
                                            width: Constants.imageSize.width, 
                                            height: Constants.imageSize.height)
        self.spriteImageView.center.x = self.contentView.center.x
        
        self.slider.frame = CGRect(x: Constants.horizontalOffset, 
                                    y: self.spriteImageView.bounds.maxY, 
                                    width: self.contentView.bounds.width - 2 * Constants.horizontalOffset, 
                                    height: 50)
    }
    
    override func setup() {
        super.setup()
        
        self.contentView.addSubview(self.slider)
        self.contentView.addSubview(self.spriteImageView)
    }
    
    override func bind(viewModel: TableCellModel) {
        let model = viewModel as! SpriteViewerCellViewModel
        
        self.slider.maximumValue = Float(model.spriteURLs.count - 1)
        self.slider.value = Float(model.currentValue)
        
        self.spriteURLs = model.spriteURLs
        self.imageView?.setImage(from: model.spriteURLs.first!)
        
        self.setNeedsLayout()
    }
    
    override class func height(for viewModel: TableCellModel, tableView: UITableView) -> CGFloat {
        return 120.0
    }
}

private extension SpriteViewerTableViewCell {
    
    @objc func changeVlaue(_ sender: UISlider) {
        let spriteNumber = Int(sender.value)
        self.spriteImageView.setImage(from: self.spriteURLs[spriteNumber])
    }
}

struct SpriteViewerCellViewModel: TableCellModel {
    var cellType: TableViewCell.Type { return SpriteViewerTableViewCell.self }
    var cellSelectionHandler: CellSelectionHandler? { return nil }

    let currentValue: Int
    let spriteURLs: [URL]
}
