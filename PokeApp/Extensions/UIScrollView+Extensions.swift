//
//  UIScrollView+Extensions.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    var isApproachingToBottom: Bool {
        let currentOffset = self.contentOffset.y
        let maximumOffset = self.contentSize.height - self.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        return deltaOffset <= 200
    }
}
