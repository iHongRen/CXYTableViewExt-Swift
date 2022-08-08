//
//  SwitchCell.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import UIKit

protocol SwitchCellDelegate {
   func onSwitchChanged(data: Any?, indexPath: IndexPath)
}

class SwitchCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var switchView: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onSwitch(_ sender: Any) {
        
    }
}

extension SwitchCell: CXYTableItemProtocol {
    static func heightForItem(data: Any?) -> CGFloat {
        return 44
    }
    
    func configItem(data: Any?, indexPath: IndexPath, delegate: AnyObject?) {
        
    }
}
