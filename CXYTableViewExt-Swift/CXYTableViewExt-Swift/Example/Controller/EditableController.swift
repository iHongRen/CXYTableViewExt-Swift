//
//  EditableController.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/9.
//

import UIKit

class EditableController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var data = 0

    var emptyTip: UILabel = {
        let tip = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        tip.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        tip.textColor = .lightGray
        tip.textAlignment = .center
        tip.text = "click + to Add"
        return tip
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Editable"
        self.view.addSubview(self.emptyTip)
        
        // config custom CXYTableDataSource
        self.tableView.t.configDataSource(EditDataSource())
    }
    
    func showEmptyTipIfNeed() {
        self.emptyTip.isHidden = !self.tableView.t.isEmpty
    }
    
    @IBAction func onAdd(_ sender: Any) {
        let indexPath = IndexPath(row: 0, section: 0)
        data -= 1
        self.tableView.t.insertCellItem(cellClass: TextCell.self, data: data, indexPath: indexPath)
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .left)
        showEmptyTipIfNeed()
    }
}

class EditDataSource: CXYTableDataSource {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.t.removeCellItem(indexPath: indexPath)
        tableView.deleteRows(at: [indexPath], with: .right)

        if let vc = tableView.t.vc as? EditableController {
            vc.showEmptyTipIfNeed()
        }
    }
}



