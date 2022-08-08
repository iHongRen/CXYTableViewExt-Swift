//
//  CXYTableItemProtocol.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import Foundation
import UIKit


public protocol CXYTableItemProtocol: AnyObject {
        
    static func heightForItem(data: Any?) -> CGFloat
    
    func configItem(data: Any?)
    func configItem(data: Any?, indexPath: IndexPath, delegate: AnyObject?)
}

extension CXYTableItemProtocol {
    
    static func heightForItem(data: Any?) -> CGFloat { return UITableView.automaticDimension }
    
    func configItem(data: Any?) {}
    func configItem(data: Any?, indexPath: IndexPath, delegate: AnyObject?) {}
}
