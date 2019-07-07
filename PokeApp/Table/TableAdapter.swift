//
//  TableAdapter.swift
//  JWeek
//
//  Created by marcenuk on 24/06/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

final class TableAdapter: NSObject {
    
    var onScroll: ((CGPoint) -> Void)?
    
    private let tableView: UITableView
    private var viewModels = [TableSectionModel]()
    
    public init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.sectionIndexTrackingBackgroundColor = UIColor.clear
        self.tableView.sectionIndexBackgroundColor = UIColor.clear
        self.tableView.estimatedRowHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
        self.tableView.estimatedSectionFooterHeight = 0
    }
}

// MARK: Info
extension TableAdapter {
    
    var sections: Int {
        return self.viewModels.count
    }
    
    func rows(in section: Int) -> Int {
        return self.viewModels[section].cellModels.count
    }
}

// MARK: Updates
extension TableAdapter {
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func update(viewModels: [TableSectionModel]) {
        self.viewModels = viewModels
        self.tableView.reloadData()
    }
    
    func insert(_ cellViewModel: TableCellModel,
                for row: Int,
                in section: Int,
                animation: UITableView.RowAnimation = .automatic) {
        self.viewModels[section].cellModels.insert(cellViewModel, at: row)
        let indexPath = IndexPath(row: row, section: section)
        self.tableView.insertRows(at: [indexPath], with: animation)
    }
    
    func append(_ cellViewModels: [TableCellModel],
                in section: Int,
                animation: UITableView.RowAnimation = .automatic) {
        let startIndex = self.viewModels[section].cellModels.count
        self.viewModels[section].cellModels.append(contentsOf: cellViewModels)
        let indexPaths = (startIndex..<startIndex + cellViewModels.count).map { return IndexPath(row: $0, section: section) }
        self.tableView.insertRows(at: indexPaths, with: animation)
    }
    
    func update(_ cellViewModel: TableCellModel,
                at indexPath: IndexPath,
                animation: UITableView.RowAnimation = .automatic,
                reload: Bool = true) {
        self.viewModels[indexPath.section].cellModels[indexPath.row] = cellViewModel
        if reload {
            self.tableView.reloadRows(at: [indexPath], with: animation)
        }
    }
    
    func update(_ cellViewModel: TableCellModel,
                for row: Int,
                in section: Int,
                animation: UITableView.RowAnimation = .automatic,
                reload: Bool = true) {
        let indexPath = IndexPath(row: row, section: section)
        self.update(cellViewModel, at: indexPath, animation: animation, reload: reload)
    }
    
    func delete(_ row: Int,
                in section: Int,
                animation: UITableView.RowAnimation = .fade) {
        self.viewModels[section].cellModels.remove(at: row)
        let indexPath = IndexPath(row: row, section: section)
        self.tableView.deleteRows(at: [indexPath], with: animation)
    }
    
    func move(from fromRow: Int,
              in fromSection: Int,
              to toRow: Int,
              in toSection: Int) {
        let model = self.viewModels[fromSection].cellModels.remove(at: fromRow)
        self.viewModels[toSection].cellModels.insert(model, at: toRow)
        let fromIndexPath = IndexPath(row: fromRow, section: fromSection)
        let toIndexPath = IndexPath(row: toRow, section: toSection)
        self.tableView.moveRow(at: fromIndexPath, to: toIndexPath)
    }
    
    func insert(_ sectionViewModel: TableSectionModel,
                in section: Int,
                animation: UITableView.RowAnimation = .automatic) {
        self.viewModels.insert(sectionViewModel, at: section)
        let indexSet = IndexSet(integer: section)
        self.tableView.insertSections(indexSet, with: animation)
    }
    
    func update(_ sectionViewModel: TableSectionModel,
                inSection section: Int,
                animation: UITableView.RowAnimation = .automatic,
                reload: Bool = true) {
        self.viewModels[section] = sectionViewModel
        let indexSet = IndexSet(integer: section)
        if reload {
            self.tableView.reloadSections(indexSet, with: animation)
        }
    }
    
    func delete(section: Int,
                animation: UITableView.RowAnimation = .fade) {
        self.viewModels.remove(at: section)
        let indexSet = IndexSet(integer: section)
        self.tableView.deleteSections(indexSet, with: animation)
    }
    
    func performUpdates(_ updates: (TableAdapter) -> Void) {
        self.tableView.beginUpdates()
        updates(self)
        self.tableView.endUpdates()
    }
    
    func clearData() {
        self.viewModels = []
        self.reloadData()
    }
}

// MARK: UITableViewDataSource
extension TableAdapter: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModels[section].cellModels.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.viewModels[indexPath.section].cellModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: viewModel.cellType),
                                                 for: indexPath) as! TableViewCell
        cell.bind(viewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let viewModel = self.viewModels[indexPath.section].cellModels[indexPath.row]
        return viewModel.canEdit
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        let viewModel = self.viewModels[indexPath.section].cellModels[indexPath.row]
        viewModel.cellEditHandler?(editingStyle, indexPath)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.viewModels.compactMap({ $0.indexTitle })
    }
}

// MARK: UITableViewDelegate
extension TableAdapter: UITableViewDelegate {
    
    func tableView(for tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel = self.viewModels[section].headerViewModel else { 
            return nil 
        }
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: viewModel.viewType)) as! TableHeaderFooterView
        view.bind(model: viewModel)
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let model = self.viewModels[section].footerViewModel else { 
            return nil
        }
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: model.viewType)) as! TableHeaderFooterView
        view.bind(model: model)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let viewModel = self.viewModels[section].footerViewModel else { 
            return 0.0
        }
        
        return viewModel.viewType.height(for: viewModel, tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let model = self.viewModels[section].headerViewModel else {
            return 0.0
        }
        
        return model.viewType.height(for: model, tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = self.viewModels[indexPath.section].cellModels[indexPath.row]
        viewModel.cellSelectionHandler?(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewModel = self.viewModels[indexPath.section].cellModels[indexPath.row]
        return viewModel.cellType.height(for: viewModel, tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let viewModel = self.viewModels[indexPath.section].cellModels[indexPath.row]
        return viewModel.editRowActions
    }
}
