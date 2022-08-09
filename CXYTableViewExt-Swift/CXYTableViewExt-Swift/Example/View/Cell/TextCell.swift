//
//  TextCell.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import UIKit

class TextCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
}

extension TextCell: CXYTableItemProtocol {
    
    func configItem(data: Any?) {
        if let model = data as? Int {
            self.title.text = "\(model)"
        }
    }
}
