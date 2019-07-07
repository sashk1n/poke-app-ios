//
//  TableSectionModel.swift
//  JWeek
//
//  Created by marcenuk on 24/06/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

protocol TableSectionModel {
    var cellModels: [TableCellModel] { get set }
    var headerViewModel: TableHeaderFooterModel? { get }
    var footerViewModel: TableHeaderFooterModel? { get }
    var indexTitle: String? { get }
}

extension TableSectionModel {
    
    public var indexTitle: String? {
        return nil
    }
}

struct DefaultTableSectionModel: TableSectionModel {
    var cellModels: [TableCellModel]
    var headerViewModel: TableHeaderFooterModel?
    var footerViewModel: TableHeaderFooterModel?
    
    init(cells: [TableCellModel] = [], 
         header: TableHeaderFooterModel? = nil, 
         footer: TableHeaderFooterModel? = nil) {
        self.cellModels = cells
        self.headerViewModel = header
        self.footerViewModel = footer
    }
}
