//
//  HeldItemVersionDetail.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public struct HeldItemVersionDetail: Codable {
    public let rarity: Int
    public let version: Species
    
    public init(rarity: Int, version: Species) {
        self.rarity = rarity
        self.version = version
    }
}
