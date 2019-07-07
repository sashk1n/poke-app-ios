//
//  TypeElement.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public struct TypeElement: Codable {
    public let slot: Int
    public let type: Species
    
    public init(slot: Int, type: Species) {
        self.slot = slot
        self.type = type
    }
}
