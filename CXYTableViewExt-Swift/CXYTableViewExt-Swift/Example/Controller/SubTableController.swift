//
//  ViewController.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import UIKit

class SubTableController: BaseTableController {

    var list = Array(1...30)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SubTable"
        configTable1()
//      configTable2()
    }
    
    /// Tip：
    /// configTable1() == configTable2()
    /// 两者调用是等效的, makeConfig只是做了简单的闭包封装
    
    func configTable1() {
        self.tableView.t.makeConfig { make in
            make.addCellItems(cellClass: TextCell.self, dataList: self.list)
        }
    }
    
    func configTable2() {
        self.tableView.t.removeItems()
        self.tableView.t.addCellItems(cellClass: TextCell.self, dataList: self.list)
        self.tableView.reloadData()
    }
}

extension SubTableController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        tableView.t.removeCellItem(indexPath: indexPath)
//        tableView.deleteRows(at: [indexPath], with: .fade)
        
        let data = tableView.t.cellItemData(forIndexPath: indexPath)
        print(data ?? 0)

        self.list.remove(at: indexPath.row)
        self.configTable1()
    }
}
