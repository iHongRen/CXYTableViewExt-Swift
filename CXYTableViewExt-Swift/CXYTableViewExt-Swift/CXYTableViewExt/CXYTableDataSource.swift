//
//  CXYTableDataSource.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import Foundation
import UIKit

public typealias DidSelectHandler = (_ tableView: UITableView, _ indexPath: IndexPath) -> Void
 
public class CXYTableDataSource : NSObject, UITableViewDataSource, UITableViewDelegate {
   public var didSelect: DidSelectHandler?
}

extension CXYTableDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return tableView.t.numberOfSections()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView.t.numberOfCellItems(atSection: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.t.reusableCell(atIndexPath: indexPath);
    }
    
}

extension CXYTableDataSource {
  
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.t.heightForCell(atIndexPath: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.t.heightForHeader(atSection: section)
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return tableView.t.heightForFooter(atSection: section)
    }
}

extension CXYTableDataSource {
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.t.reusableHeader(atSection: section)
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableView.t.reusableFooter(atSection: section)
    }
}

extension CXYTableDataSource {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect?(tableView, indexPath)
        
        let item = tableView.t.cellItem(forIndexPath: indexPath)
        item?.closure?(item?.data, indexPath)
    }
}

