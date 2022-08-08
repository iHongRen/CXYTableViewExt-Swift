//
//  CXYTableDataItem.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import Foundation

public typealias CXYItemClosure = (_ data: Any?, _ indexPath: IndexPath) -> Void

public struct CXYTableDataItem {
    var itemClass: AnyClass
    var data: Any?
    weak var delegate: AnyObject?
    var closure: CXYItemClosure?
}
