//
//  SpriteViewerTableViewCell.swift
//  PokeApp
//
//  Created by marcenuk on 10/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

private struct Constants {
    static let imageSize: CGSize = CGSize(width: 95.0, height: 95.0)
    static let verticalOffset: CGFloat = 8.0
    static let horizontalOffset: CGFloat = 16.0
}

final class SpriteViewerTableViewCell: TableViewCell {
    
    private var viewModel: SpriteViewerCellViewModel?
    
    private lazy var slider: UISlider = {
        let view = UISlider()
        view.addTarget(self, action: #selector(changeValue), for: .valueChanged)
        return view
    }()
    
    private lazy var spriteImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.spriteImageView.frame = CGRect(x: 0.0, 
                                            y: Constants.verticalOffset, 
                                            width: Constants.imageSize.width, 
                                            height: Constants.imageSize.height)
        self.spriteImageView.center.x = self.contentView.center.x
        
        self.slider.frame = CGRect(x: 2 * Constants.horizontalOffset, 
                                   y: self.spriteImageView.bounds.maxY + Constants.verticalOffset, 
                                   width: self.contentView.bounds.width - 4 * Constants.horizontalOffset, 
                                   height: 50)
    }
    
    override func setup() {
        super.setup()
        
        self.contentView.addSubview(self.slider)
        self.contentView.addSubview(self.spriteImageView)
    }
    
    override func bind(viewModel: TableCellModel) {
        let model = viewModel as! SpriteViewerCellViewModel
        self.viewModel = model
        
        self.slider.maximumValue = Float(model.spriteURLs.count - 1)
        self.slider.value = Float(model.currentValue)
        
        if let imageURL = model.spriteURLs.first {
            self.spriteImageView.setImage(from: imageURL)            
        }
        
        self.setNeedsLayout()
    }
    
    override class func height(for viewModel: TableCellModel, tableView: UITableView) -> CGFloat {
        return 150.0
    }
}

private extension SpriteViewerTableViewCell {
    
    @objc func changeValue(_ sender: UISlider) {
        let sliderValue = Int(sender.value)
        guard sliderValue != self.viewModel?.currentValue else {
            return
        }
        
        self.spriteImageView.setImage(from: self.viewModel?.spriteURLs[sliderValue])
        self.viewModel?.onChangeValue?(sliderValue)
    }
}

struct SpriteViewerCellViewModel: TableCellModel {
    var cellType: TableViewCell.Type { return SpriteViewerTableViewCell.self }
    var cellSelectionHandler: CellSelectionHandler? { return nil }

    let currentValue: Int
    let spriteURLs: [URL]
    var onChangeValue: ((Int) -> Void)?
}
