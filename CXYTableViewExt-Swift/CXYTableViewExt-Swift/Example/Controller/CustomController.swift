//
//  CustomController.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/9.
//

import UIKit

class CustomController: BaseTableController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CustomDataSource"

        // use custom CXYTableDataSource.
        self.tableView.t.configDataSource(CustomDataSource())
        
        // use default CXYTableDataSource.
        // self.tableView.t.useDefaultDataSource()
        
        configTable()
    }
    
    func configTable() {
        self.tableView.t.makeConfig { make in
            make.addHeaderItem(headerClass: Header2.self, data: "Section0-Header")
            make.addCellItems(cellClass: TextCell.self, dataList: Array(1...30))
        }
    }
}

//
class CustomDataSource: CXYTableDataSource {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row % 2 == 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.t.removeCellItem(indexPath: indexPath)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
