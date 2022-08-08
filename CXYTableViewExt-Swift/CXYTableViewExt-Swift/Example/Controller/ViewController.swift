//
//  ViewController.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import UIKit

class ViewController: BaseTableController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SubTable"
        configTable1()
    }
    
    func configTable1() {
        self.tableView.t.makeConfig { make in
            make.addCellItem(cellClass: TextCell.self)
        }
    }

}

