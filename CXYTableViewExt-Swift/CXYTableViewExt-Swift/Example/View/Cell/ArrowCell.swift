//
//  ArrowCell.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import UIKit

class ArrowCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
}

extension ArrowCell: CXYTableItemProtocol {
    static func heightForItem(data: Any?) -> CGFloat {
        return 50
    }
    
    func configItem(data: Any?) {
        if let model = data as? SettingModel {
            self.title.text = model.title
            self.detail.text = model.detail
        }
    }
}
