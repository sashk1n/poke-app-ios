//
//  VersionGroupDetail.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public struct VersionGroupDetail: Codable {
    public let levelLearnedAt: Int
    public let versionGroup, moveLearnMethod: Species
    
    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case versionGroup = "version_group"
        case moveLearnMethod = "move_learn_method"
    }
    
    public init(levelLearnedAt: Int, versionGroup: Species, moveLearnMethod: Species) {
        self.levelLearnedAt = levelLearnedAt
        self.versionGroup = versionGroup
        self.moveLearnMethod = moveLearnMethod
    }
}
