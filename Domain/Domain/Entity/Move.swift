//
//  Move.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public struct Move: Codable {
    public let move: Species
    public let versionGroupDetails: [VersionGroupDetail]
    
    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
    
    public init(move: Species, versionGroupDetails: [VersionGroupDetail]) {
        self.move = move
        self.versionGroupDetails = versionGroupDetails
    }
}
