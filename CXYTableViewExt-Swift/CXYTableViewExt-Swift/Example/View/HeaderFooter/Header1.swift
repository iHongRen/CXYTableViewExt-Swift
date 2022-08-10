//
//  Header1.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import UIKit

protocol Header1Delegate {
    func onArrowClick(data: Any?)
}

class Header1: UITableViewHeaderFooterView {
    var data: Any?
    weak var delegate :AnyObject?
    
    var title: UILabel = {
        let title = UILabel(frame: CGRect(x: 15, y: 0, width: 200, height: 40))
        title.textColor = .black
        return title
    }()

    lazy var arrow: UIButton = {
        let btn = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width-45, y: 0, width: 40, height: 40))
        btn.addTarget(self, action: #selector(arrowClick), for: .touchUpInside)
        return btn
    }() 
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        self.contentView.addSubview(self.title)
        self.contentView.addSubview(self.arrow)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    
    @objc func arrowClick() {
        if let d = self.delegate as? Header1Delegate {
            d.onArrowClick(data: self.data)
        } 
    }
}

extension Header1: CXYTableItemProtocol {
    static func heightForItem(data: Any?) -> CGFloat {
        return 40
    }
    
    func configItem(data: Any?, indexPath: IndexPath, delegate: AnyObject?) {
        self.data = data
        self.delegate = delegate
        
        if let model = data as? SettingModel {
            self.title.text = model.title
            let name = model.isOn ? "chevron.down" : "chevron.up"
            self.arrow.setImage(UIImage(systemName: name), for: .normal)
        } 
    }
}
