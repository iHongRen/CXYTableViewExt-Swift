//
//  Footer2.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import UIKit

class Footer2: UITableViewHeaderFooterView {
  
    var title: UILabel = {
        let title = UILabel(frame: CGRect(x: 15, y: 0, width: 200, height: 20))
        title.textColor = .white
        return title
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .red
        
        self.contentView.addSubview(self.title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Footer2: CXYTableItemProtocol {
    static func heightForItem(data: Any?) -> CGFloat {
        return 20
    }
    
    func configItem(data: Any?) {
        if let model = data as? String {
            self.title.text = model
        }
    }
}
