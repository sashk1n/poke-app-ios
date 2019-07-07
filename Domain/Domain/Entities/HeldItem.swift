//
//  HeldItem.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public struct HeldItem: Codable {
    public let item: Species
    public let versionDetails: [HeldItemVersionDetail]
    
    enum CodingKeys: String, CodingKey {
        case item
        case versionDetails = "version_details"
    }
    
    public init(item: Species, versionDetails: [HeldItemVersionDetail]) {
        self.item = item
        self.versionDetails = versionDetails
    }
}
