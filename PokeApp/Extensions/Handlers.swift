//
//  Handlers.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

typealias SingleHandler<T> = (T) -> Void

typealias ActionHandler = (() -> Void)
typealias StringHandler = SingleHandler<String>
typealias ImageHandler = SingleHandler<UIImage>
typealias IDActionHandler = SingleHandler<Int>
