//
//  SettingController.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import UIKit

class SettingController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Setting"
        
        configTable()
    }
    
    func configTable() {
        self.tableView.t.makeConfig { make in
            make.addCellItem(cellClass: TextCell.self)
            make.addCellItem(cellClass: ArrowCell.self, data: 0) { data, indexPath in
                
            }
            make.addCellItem(cellClass: ArrowCell.self, data: 0) { data, indexPath in
                
            }
            make.addCellItem(cellClass: ArrowCell.self, data: 0) { data, indexPath in
                
            }
            make.addCellItem(cellClass: SwitchCell.self, data: 0)
            make.addCellItem(cellClass: SwitchCell.self, data: 0)
        }
        
        self.tableView.t.didSelectItem { tableView, indexPath in
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }


}
