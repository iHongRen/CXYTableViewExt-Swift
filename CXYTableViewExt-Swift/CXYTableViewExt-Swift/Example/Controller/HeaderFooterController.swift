//
//  HeaderFooterController.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/9.
//

import UIKit

class HeaderFooterController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Header&Footer"
        configTable()
    }

    func configTable() {
        self.tableView.t.makeConfig { make in
            make.addHeaderItem(headerClass: Header1.self, data: "Header1", delegate: self)
            make.addCellItems(cellClass: TextCell.self, dataList: [1,2,3,4,5])
            make.addFooterItem(footerClass: Footer1.self, data: "Footer1")
            
            make.addHeaderItem(headerClass: Header2.self, data: "Header2")
            make.addCellItems(cellClass: TextCell.self, dataList: [6,7,8,9,10])
            make.addFooterItem(footerClass: Footer2.self, data: "Footer2")
        }
        
        self.tableView.t.didSelectItem { tableView, indexPath in
            tableView.deselectRow(at: indexPath, animated: true)
            print(indexPath)
        }
    }
}

/// Header1 delegate
extension HeaderFooterController: Header1Delegate {
    func onArrowClick(data: Any?) {
        print(#function)
    }
}
