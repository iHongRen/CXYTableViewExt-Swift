//
//  CXYTableViewExt.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import Foundation
import UIKit


public struct CXYTableNamespaceWrapper<T> {
    private let table: T
    public init(_ table: T) {
        self.table = table
    }
}

public protocol CXYTableNamespaceWrappable {
    associatedtype WrapperType
    var t: WrapperType { get }
}

public extension CXYTableNamespaceWrappable {
    var t: CXYTableNamespaceWrapper<Self> {
        return CXYTableNamespaceWrapper(self)
    }
}

extension UITableView: CXYTableNamespaceWrappable { }

extension CXYTableNamespaceWrapper where T: UITableView {
    
    public func configDataSource(_ dataSource: CXYTableDataSource) {
        table.defaultDataSource = dataSource
        table.dataSource = dataSource
        table.delegate = dataSource
    }
    
    public func makeConfig(_ closure: @escaping (_ make: Self) -> Void) {
        removeItems()
        closure(table.t)
        table.reloadData()
    }
    
    public func useDefaultDataSource() {
        configDataSource(CXYTableDataSource())
    }
}

extension CXYTableNamespaceWrapper where T: UITableView {
    
    func register(itemClasses clss: Array<AnyClass>) {
        for cls in clss {
            self.register(itemClass: cls)
        }
    }
    
    func register(itemClass cls: AnyClass) {
        let name = String(describing: cls)
        let path = Bundle.main.path(forResource: name, ofType: "nib")

        if cls is UITableViewCell.Type {
            if let _ = path {
                table.register(UINib(nibName: name, bundle: nil) , forCellReuseIdentifier: name)
            } else {
                table.register(cls, forCellReuseIdentifier: name)
            }
            
        } else if cls is UITableViewHeaderFooterView.Type {
            if let _ = path {
                table.register(UINib(nibName: name, bundle: nil), forHeaderFooterViewReuseIdentifier: name)
            } else {
                table.register(cls, forHeaderFooterViewReuseIdentifier: name)
            }
        } else {
            fatalError("\(name) is an illegal class!")
        }
    }
}

/**
 *  后添加item
 */
public extension CXYTableNamespaceWrapper where T: UITableView {
   
    func addHeaderItem(headerClass cls: AnyClass, data: Any?, delegate: AnyObject? = nil) {
        registerIfNeed(itemClass: cls)
        useDefaultDataSourceIfNeed()

        let headerItem = CXYTableDataItem(itemClass: cls, data: data, delegate: delegate)
     
        if let sec = table.m.sections.last, isEmpty(sectionItem: sec) {
            sec.headerItem = headerItem
        } else {
            let sectionItem = CXYTableSectionItem()
            sectionItem.headerItem = headerItem
            table.m.sections.append(sectionItem)
        }
    }

    func addCellItem(cellClass cls: AnyClass, data: Any? = nil) {
        addCellItem(cellClass: cls, data: data, delegate: nil, closure: nil)
    }
    
    func addCellItem(cellClass cls: AnyClass, delegate: AnyObject?) {
        addCellItem(cellClass: cls, data: nil, delegate: delegate, closure: nil)
    }
    
    func addCellItem(cellClass cls: AnyClass, closure: CXYItemClosure?) {
        addCellItem(cellClass: cls, data: nil, delegate: nil, closure: closure)
    }
    
    func addCellItem(cellClass cls: AnyClass, data: Any?, closure: CXYItemClosure?) {
        addCellItem(cellClass: cls, data: data, delegate: nil, closure: closure)
    }
    
    func addCellItem(cellClass cls: AnyClass, data: Any?, delegate: AnyObject?, closure:CXYItemClosure? = nil) {
        registerIfNeed(itemClass: cls)
        useDefaultDataSourceIfNeed()
        
        if let sec = table.m.sections.last {
            if let _ = sec.footerItem {
                table.m.sections.append(CXYTableSectionItem())
            }
        } else {
            table.m.sections.append(CXYTableSectionItem())
        }
        
        let sectionItem = table.m.sections.last;
        
        let cellItem = CXYTableDataItem(itemClass: cls, data: data, delegate: delegate, closure: closure)
        sectionItem?.cellItems.append(cellItem)
    }
    
    func addCellItems(cellClass cls: AnyClass, dataList: Array<Any?>, delegate: AnyObject? = nil) {
        if dataList.isEmpty {
            return
        }
        
        registerIfNeed(itemClass: cls)
        useDefaultDataSourceIfNeed()
        
        let items = dataList.map {
            CXYTableDataItem(itemClass: cls, data: $0, delegate: delegate)
        }
        
        if let sec = table.m.sections.last {
            if let _ = sec.footerItem {
                table.m.sections.append(CXYTableSectionItem())
            }
        } else {
            table.m.sections.append(CXYTableSectionItem())
        }
        
        let sectionItem = table.m.sections.last;
        sectionItem?.cellItems += items
    }
    

    func addFooterItem(footerClass cls: AnyClass, data: Any?, delegate: AnyObject? = nil) {
        registerIfNeed(itemClass: cls)
        useDefaultDataSourceIfNeed()

        let footerItem = CXYTableDataItem(itemClass: cls, data: data, delegate: delegate)
        if let _ = table.m.sections.last?.footerItem {
            let sectionItem = CXYTableSectionItem()
            table.m.sections.append(sectionItem)
            sectionItem.footerItem = footerItem
        } else {
            table.m.sections.last?.footerItem = footerItem
        }
    }
    
    func didSelectItem(didSelect: @escaping DidSelectHandler) {
        table.defaultDataSource?.didSelect = didSelect
    }
}
 

/**
 *  插入item
 */
public extension CXYTableNamespaceWrapper where T: UITableView {
    func insertHeaderItem(headerClass cls: AnyClass, data: Any?, section: Int) {
        insertHeaderItem(headerClass: cls, data: data, delegate: nil, section: section)
    }
    
    func insertHeaderItem(headerClass cls: AnyClass, data: Any?, delegate: AnyObject?, section: Int) {
        guard table.m.sections.count >= section else {
            assertionFailure("section(\(section) is out of range")
            return
        }
        registerIfNeed(itemClass: cls)
        useDefaultDataSourceIfNeed()
        
        let headerItem = CXYTableDataItem(itemClass: cls, data: data, delegate: delegate)

        if let sec = sectionItem(section: section), sec.headerItem==nil {
            sec.headerItem = headerItem
        } else {
            let sectionItem = CXYTableSectionItem()
            sectionItem.headerItem = headerItem
            table.m.sections.insert(sectionItem, at: section)
        }
    }
    
    func insertCellItem(cellClass cls: AnyClass, data: Any?, indexPath: IndexPath) {
        insertCellItem(cellClass: cls, data: data, delegate: nil, indexPath: indexPath)
    }
    
    func insertCellItem(cellClass cls: AnyClass, data: Any?, delegate: AnyObject?, indexPath: IndexPath) {
        insertCellItems(cellClass: cls, dataList: [data], delegate: delegate, indexPath: indexPath)
    }
    
    func insertCellItems(cellClass cls: AnyClass, dataList: Array<Any?>, indexPath: IndexPath) {
        insertCellItems(cellClass: cls, dataList:dataList, delegate: nil, indexPath: indexPath)
    }
    
    func insertCellItems(cellClass cls: AnyClass, dataList: Array<Any?>, delegate: AnyObject?, indexPath: IndexPath) {
        
        guard table.m.sections.count >= indexPath.section else {
            assertionFailure("section(\(indexPath.section)) is out of range")
            return
        }
        
        registerIfNeed(itemClass: cls)
        useDefaultDataSourceIfNeed()
        
        let items = dataList.map {
            CXYTableDataItem(itemClass: cls, data: $0, delegate: delegate)
        }
        
        let sectionItem = sectionItem(section: indexPath.section)
        if let sec = sectionItem {
            guard sec.cellItems.count >= indexPath.row else {
                assertionFailure("row(\(indexPath.row)) is out of range")
                return
            }
            sec.cellItems.insert(contentsOf: items, at: indexPath.row)
        } else if table.m.sections.count >= indexPath.section {
            let sectionItem = CXYTableSectionItem()
            sectionItem.cellItems = items
            table.m.sections.insert(sectionItem, at: indexPath.section)
        }
    }
    
    func insertFooterItem(footerClass cls: AnyClass, data: Any?, section: Int) {
        insertFooterItem(footerClass: cls, data: data, delegate: nil, section: section)
    }
     
    func insertFooterItem(footerClass cls: AnyClass, data: Any?, delegate: AnyObject?, section: Int) {
       
        guard table.m.sections.count >= section else {
            assertionFailure("section(\(section)) is out of range")
            return
        }
        
        registerIfNeed(itemClass: cls)
        useDefaultDataSourceIfNeed()

        let footerItem = CXYTableDataItem(itemClass: cls, data: data, delegate: delegate)
        
        if let sec = sectionItem(section: section), sec.footerItem==nil {
            sec.footerItem = footerItem
        } else if table.m.sections.count >= section {
            let sectionItem = CXYTableSectionItem()
            sectionItem.footerItem = footerItem
            table.m.sections.insert(sectionItem, at: section)
        }
    }
}

/**
 *  删除item
 */
public extension CXYTableNamespaceWrapper where T: UITableView {
    
    func removeItems() {
        table.m.sections.removeAll()
    }
    
    func removeSectionItem(section: Int) {
        table.m.sections.remove(at: section)
    }
    
    func removeHeaderItem(section: Int) {
        let sectionItem = table.t.sectionItem(section: section)
        sectionItem?.headerItem = nil
    }
    
    func removeCellItem(indexPath: IndexPath) {
        let sectionItem = table.t.sectionItem(section: indexPath.section)
        sectionItem?.cellItems.remove(at: indexPath.row)
    }
    
    func removeFooterItem(section: Int) {
        let sectionItem = table.t.sectionItem(section: section)
        sectionItem?.footerItem = nil
    }
}


/**
 *  判空
 */
public extension CXYTableNamespaceWrapper where T: UITableView {
    var isEmpty: Bool {
        let items = sectionItems()
        if items.isEmpty {
            return true
        }
        
        for item in items {
            if !isEmpty(sectionItem: item) {
                return false
            }
        }
        return true
    }
    
    func isEmpty(sectionItem: CXYTableSectionItem) -> Bool {
        if let _ = sectionItem.headerItem {
            return false
        }
        if let _ = sectionItem.footerItem {
            return false
        }
        if !sectionItem.cellItems.isEmpty {
            return false
        }
        return true
    }
        
    func isEmptyCellItem(forSectionItem sectionItem: CXYTableSectionItem) -> Bool {
        return sectionItem.cellItems.isEmpty
    }
}


/**
 *  获取item
 */
public extension CXYTableNamespaceWrapper where T: UITableView {
    
    func sectionItems() -> Array<CXYTableSectionItem> {
        return table.m.sections
    }
    
    func sectionItem(section: Int) -> CXYTableSectionItem? {
        if 0 <= section && section < table.m.sections.count {
            return table.m.sections[section]
        }
        return nil
    }
    
    func headerItemData(section: Int) -> Any? {
        return sectionItem(section: section)?.headerItem?.data
    }
    
    func headerItemDelegate(section: Int) -> AnyObject? {
        return sectionItem(section: section)?.headerItem?.delegate
    }
    
    func headerItemClass(section: Int) -> AnyClass? {
        return sectionItem(section: section)?.headerItem?.itemClass
    }
    
    func footerItemData(section: Int) -> Any? {
        return sectionItem(section: section)?.footerItem?.data
    }
    
    func footerItemDelegate(section: Int) -> AnyObject? {
        return sectionItem(section: section)?.footerItem?.delegate
    }
    
    func footerItemClass(section: Int) -> AnyClass? {
        return sectionItem(section: section)?.footerItem?.itemClass
    }
    
    func cellItems(section: Int) -> Array<CXYTableDataItem>? {
        return sectionItem(section: section)?.cellItems
    }
    
    func cellItem(forIndexPath indexPath: IndexPath) -> CXYTableDataItem? {
        guard let cellItems = cellItems(section: indexPath.section) else {
            return nil
        }
        if 0 <= indexPath.row && indexPath.row < cellItems.count {
            return cellItems[indexPath.row]
        }
        return nil
    }
    
    func cellItemData(forIndexPath indexPath: IndexPath) -> Any? {
        return cellItem(forIndexPath:indexPath)?.data
    }
    
    func cellItemDelegate(forIndexPath indexPath: IndexPath) -> AnyObject? {
        return cellItem(forIndexPath:indexPath)?.delegate
    }
    
    func cellItemClass(forIndexPath indexPath: IndexPath) -> AnyClass? {
        return cellItem(forIndexPath:indexPath)?.itemClass
    }
    
    func headerItemDataList() -> Array<Any?> {
        var list = [Any?]()
        table.m.sections.forEach { item in
            if let headerItem = item.headerItem {
                list.append(headerItem.data)
            }
        }
        return list
    }
    
    func footerItemDataList() -> Array<Any?> {
        var list = [Any?]()
        table.m.sections.forEach { item in
            if let footerItem = item.footerItem {
                list.append(footerItem.data)
            }
        }
        return list
    }
    
    func cellItemDataList(section: Int) -> Array<Any?> {
        var list = [Any?]()
        cellItems(section: section)?.forEach { item in
            list.append(item.data)
        }
        return list
    }
}



/**
 *  获取item数量
 */
public extension CXYTableNamespaceWrapper where T: UITableView {
    func numberOfSections() -> Int {
        return table.m.sections.count
    }
    
    func numberOfCellItems(atSection section: Int) -> Int {
        if section > table.m.sections.count || 0 > section {
            return 0
        }
        return table.m.sections[section].cellItems.count
    }
}



/**
 *  获取item高度
 */
public extension CXYTableNamespaceWrapper where T: UITableView {
    
    func heightForItem(dataItem: CXYTableDataItem?) -> CGFloat {
        if let cls = dataItem?.itemClass as? CXYTableItemProtocol.Type {
            return cls.heightForItem(data: dataItem?.data)
        }
        return CGFloat.leastNormalMagnitude
    }
    
    func heightForCell(atIndexPath indexPath: IndexPath) -> CGFloat {
        let cellItem = cellItem(forIndexPath: indexPath)
        return heightForItem(dataItem: cellItem)
    }
    
    func heightForHeader(atSection section: Int) -> CGFloat {
        let headerItem = sectionItem(section: section)?.headerItem
        return heightForItem(dataItem: headerItem)
    }
    
    func heightForFooter(atSection section: Int) -> CGFloat {
        let footerItem = sectionItem(section: section)?.footerItem
        return heightForItem(dataItem: footerItem)
    }
}
 
/**
 *  获取重用item
 */
public extension CXYTableNamespaceWrapper where T: UITableView {
    func reusableCell(atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cellItem = cellItem(forIndexPath:indexPath)
        let cls: AnyClass? = cellItem?.itemClass
        let cell = table.dequeueReusableCell(withIdentifier: String(describing: cls!), for: indexPath)
        if let c = cell as? CXYTableItemProtocol {
            c.configItem(data: cellItem?.data)
            c.configItem(data: cellItem?.data, indexPath: indexPath, delegate: cellItem?.delegate)
        }
        return cell
    }
    
    func reusableHeader(atSection section: Int) -> UITableViewHeaderFooterView? {
        let headerItem = sectionItem(section: section)?.headerItem
        let cls: AnyClass? = headerItem?.itemClass
        guard let itemClass = cls else {
            return nil
        }
        let header = table.dequeueReusableHeaderFooterView(withIdentifier: String(describing: itemClass))
        if let h = header as? CXYTableItemProtocol {
            h.configItem(data: headerItem?.data)
            h.configItem(data: headerItem?.data, indexPath: IndexPath(row: 0, section: section), delegate: headerItem?.delegate)
        }
        return header
    }
    
    func reusableFooter(atSection section: Int) -> UITableViewHeaderFooterView? {
        let footerItem = sectionItem(section: section)?.footerItem
        let cls: AnyClass? = footerItem?.itemClass
        guard let itemClass = cls else {
            return nil
        }
        let footer = table.dequeueReusableHeaderFooterView(withIdentifier: String(describing: itemClass))
        if let f = footer as? CXYTableItemProtocol {
            f.configItem(data: footerItem?.data)
            f.configItem(data: footerItem?.data, indexPath: IndexPath(row: 0, section: section),delegate: footerItem?.delegate)
        }
        return footer
    }
}




/**
 *  注册&代理，设置
 */
private extension CXYTableNamespaceWrapper where T: UITableView  {
    func registerIfNeed(itemClass cls: AnyClass) {
        let name = String(describing: cls)
        guard let _ = table.registeredClasses[name] else {
            register(itemClass: cls)
            table.registeredClasses[name] = cls
            return
        }
    }

    func useDefaultDataSourceIfNeed() {
        if table.delegate==nil && table.dataSource==nil {
            useDefaultDataSource()
        }
    }
}


/**
 *  中转sections，避免数组添加元素频繁调用关联对象set方法
 */
private class Middle {
    var sections = [CXYTableSectionItem]()
}

/**
 * 添加的关联属性
 */
private extension UITableView {
    private struct AssociatedKeys {
        static var kRegisteredClassesKey = "kRegisteredClassesKey"
        static var kSectionsKey = "kSectionsKey"
        static var kDataSourceKey = "kDataSourceKey"
        static var kMiddleKey = "kMiddleKey"
    }
    
    var registeredClasses: Dictionary<String, AnyClass> {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.kRegisteredClassesKey) as? Dictionary<String, AnyClass> else {
                let defaultVaule: [String:AnyClass] = [:]
                self.registeredClasses = defaultVaule
                return defaultVaule
            }
            return value
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.kRegisteredClassesKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var m: Middle {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.kMiddleKey) as? Middle else {
                let defaultVaule = Middle()
                objc_setAssociatedObject(self, &AssociatedKeys.kMiddleKey, defaultVaule, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return defaultVaule
            }
            return value
        }
    }
    
    var defaultDataSource : CXYTableDataSource? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.kDataSourceKey) as? CXYTableDataSource
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.kDataSourceKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

