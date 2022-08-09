//
//  Footer1.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import UIKit

class Footer1: UITableViewHeaderFooterView {
  
    var title: UILabel = {
        let title = UILabel(frame: CGRect(x: 15, y: 0, width: 200, height: 20))
        title.textColor = .black
        return title
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        self.contentView.addSubview(self.title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Footer1: CXYTableItemProtocol {
    static func heightForItem(data: Any?) -> CGFloat {
        return 20
    }
    
    func configItem(data: Any?) {
        if let model = data as? String {
            self.title.text = model
        }
    }
}
