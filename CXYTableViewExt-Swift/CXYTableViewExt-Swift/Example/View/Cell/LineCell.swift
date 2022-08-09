//
//  LineCell.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import UIKit


class LineCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.backgroundColor = .systemGroupedBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LineCell: CXYTableItemProtocol {
    static func heightForItem(data: Any?) -> CGFloat {
        if let model = data as? LineModel {
            return model.height
        }
        return 10
    }
    
    func configItem(data: Any?) {
        if let model = data as? LineModel {
            self.contentView.backgroundColor = model.color
        }
    }
}
