//
//  SwitchCell.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import UIKit

protocol SwitchCellDelegate {
    func onSwitchChanged(data: SettingModel, isOn: Bool)
}

class SwitchCell: UITableViewCell {
 
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var switchView: UISwitch!
    
    var data: Any?
    var delegate: AnyObject?
    
    @IBAction func onSwitch(_ sender: Any) {
        if let d = self.delegate as? SwitchCellDelegate, let model = self.data as? SettingModel {
            d.onSwitchChanged(data: model, isOn: self.switchView.isOn)
        }
    } 
}

extension SwitchCell: CXYTableItemProtocol {
    static func heightForItem(data: Any?) -> CGFloat {
        return 50
    }
    
    func configItem(data: Any?, indexPath: IndexPath, delegate: AnyObject?) {
        self.data = data
        self.delegate = delegate
         
        if let model = data as? SettingModel {
            self.title.text = model.title
            self.switchView.isOn = model.isOn
        }
    }
}
