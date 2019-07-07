//
//  Sprite.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public struct Sprites: Codable {
    public let backFemale: String?
    public let backShinyFemale: String?
    public let backDefault: String?
    public let frontShinyFemale: String?
    public let backShiny: String?
    public let frontDefault: String?
    public let frontShiny: String?
    public let frontFemale: String?
    
    enum CodingKeys: String, CodingKey {
        case backFemale = "back_female"
        case backShinyFemale = "back_shiny_female"
        case backDefault = "back_default"
        case frontFemale = "front_female"
        case frontShinyFemale = "front_shiny_female"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
    
    public init(backFemale: String?, 
                backShinyFemale: String?, 
                backDefault: String?, 
                frontFemale: String?, 
                frontShinyFemale: String?, 
                backShiny: String?, 
                frontDefault: String?, 
                frontShiny: String?) {
        self.backFemale = backFemale
        self.backShinyFemale = backShinyFemale
        self.backDefault = backDefault
        self.frontFemale = frontFemale
        self.frontShinyFemale = frontShinyFemale
        self.backShiny = backShiny
        self.frontDefault = frontDefault
        self.frontShiny = frontShiny
    }
}
