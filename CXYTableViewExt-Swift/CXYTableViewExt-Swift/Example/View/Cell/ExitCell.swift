//
//  ExitCell.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/9.
//

import UIKit

class ExitCell: UITableViewCell {

    var title: UILabel = {
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
        title.textAlignment = .center
        title.textColor = .systemRed
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ExitCell: CXYTableItemProtocol {
    static func heightForItem(data: Any?) -> CGFloat {
        return 50
    }
    
    func configItem(data: Any?) {
        if let t = data as? String {
            self.title.text = t
        }
    }
}
