//
//  UIImageView.swift
//  PokeApp
//
//  Created by marcenuk on 09/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(from url: URL?,
                  placeholder: UIImage? = nil,
                  targetSize: CGSize? = nil) {
        guard let url = url else {
            self.image = placeholder
            return
        }
        
        self.kf.setImage(with: url, 
                         placeholder: placeholder,
                         options: self.makeOptions(targetSize: targetSize))
    }
    
    private func makeOptions(targetSize: CGSize?) -> KingfisherOptionsInfo {
        var options: KingfisherOptionsInfo = [.transition(ImageTransition.fade(0.2)), .backgroundDecode]
        if let targetSize = targetSize,
            targetSize.width > CGFloat.leastNormalMagnitude,
            targetSize.height > CGFloat.leastNormalMagnitude {
            let processor = ResizingImageProcessor(referenceSize: targetSize, mode: .aspectFill)
            options.append(.processor(processor))
        }
        options.append(.scaleFactor(UIScreen.main.scale))
        return options
    }
}
