//
//  SettingController.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import UIKit

class SettingController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var noti = SettingModel(title: "Mute Notification(消息免打扰)", isOn: true)
    var top = SettingModel(title: "Sticky on Top(置顶)", isOn: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Setting"
        
        configTable()
    }
    
    /// Tip:
    /// 1. 无需提前注册cell, 在你调用addCellItem时，会自行帮你注册
    /// 2. 无需设置tableview的dataSource & delegate，内部默认设置了一个代理对象(CXYTableDataSource())
    
    
    func configTable() {
        self.tableView.t.makeConfig { make in
            
            make.addCellItem(cellClass: LineCell.self)
            make.addCellItem(cellClass: ArrowCell.self, data: SettingModel(title: "BaseTableController", detail: "基类实现代理")) { [weak self] data, indexPath in
                self?.navigationController?.pushViewController(SubTableController(), animated: true)
            }
            make.addCellItem(cellClass: ArrowCell.self, data: SettingModel(title: "Refresh&LoadMore", detail: "下拉刷新&加载更多")) { [weak self] data, indexPath in
                
            }
            make.addCellItem(cellClass: ArrowCell.self, data: SettingModel(title: "Header&Footer", detail: "section头和尾")) { [weak self] data, indexPath in
                
            }
            make.addCellItem(cellClass: ArrowCell.self, data: SettingModel(title: "Custom CXYTableDataSource", detail: "自定义代理")) { [weak self] data, indexPath in
                
            }
            make.addCellItem(cellClass: ArrowCell.self, data: SettingModel(title: "Editable", detail: "可编辑")) { [weak self] data, indexPath in
                
            }
            
            make.addCellItem(cellClass: LineCell.self)
            make.addCellItem(cellClass: SwitchCell.self, data: self.noti, delegate: self)
            make.addCellItem(cellClass: SwitchCell.self, data: self.top, delegate: self)
             
            make.addCellItem(cellClass: LineCell.self, data: LineModel(height: 20))
            make.addCellItem(cellClass: ExitCell.self, data: "Exit(退出)") { data, indexPath in
                
            }
        }
        
        // handle tableview deselectRow
        self.tableView.t.didSelectItem { tableView, indexPath in
            tableView.deselectRow(at: indexPath, animated: true)
            // get item data (获取所配置的data)
            let data = tableView.t.cellItemData(forIndexPath: indexPath)
            print("did select indexPath(\(indexPath)), data = \(String(describing: data))")
        }
    }
}


// implement the Cell's delegate
// 实现 cell 的内部代理方法
extension SettingController: SwitchCellDelegate {
    
    func onSwitchChanged(data: SettingModel, isOn: Bool) {
        print("\(data.title) is changed")
        if self.noti.title == data.title {
            // TODO: 😀
        }
    }
}
