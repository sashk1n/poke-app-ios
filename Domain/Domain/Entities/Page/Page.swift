//
//  Page.swift
//  Domain
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public struct Page: Codable {
  // ключевое слово public здесь и далее во все структурах лишнее
    public let count: Int
    public let next: URL?
    public let previous: URL?
    public let results: [NamedEntity]

  // зачем здесь конструктор? он создается за нас по-умолчанию. Здесь и далее во все структурах лишний
    public init(count: Int, 
                next: URL?, 
                previous: URL?, 
                results: [NamedEntity]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}
