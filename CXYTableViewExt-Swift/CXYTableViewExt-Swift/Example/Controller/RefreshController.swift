//
//  RefreshController.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/9.
//

import UIKit

class RefreshController: BaseTableController {

    var list = [Int]()
    var curpage = 1
    
    var loading: Bool = false {
        didSet {
            if (loading) {
                self.hud.startAnimating()
            } else {
                self.hud.stopAnimating()
            }
        }
    }
    
    var hud: UIActivityIndicatorView = {
        let hud = UIActivityIndicatorView(style: .large)
        hud.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        return hud
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Refresh&LoadMore"
        
        self.view.addSubview(self.hud)
        
        // 懒得去引入Refresh库了，使用按钮点击模拟上拉和下拉
        let refresh = UIBarButtonItem(image: UIImage(systemName: "arrow.down"), style: .done, target: self, action: #selector(onRefresh))
        let loadMore = UIBarButtonItem(image: UIImage(systemName: "arrow.up"), style: .done, target: self, action: #selector(onLoadMore))
        self.navigationItem.rightBarButtonItems = [refresh, loadMore]
        
        request(page: 1)
    }

    @objc func onRefresh() {
        if self.loading {
            return
        }
        request(page: 1)
    }
    
    @objc func onLoadMore() {
        if self.loading {
            return
        }
        request(page: self.curpage+1)
    }
    
    func configTable() {
        self.tableView.t.makeConfig { make in
            make.addCellItems(cellClass: TextCell.self, dataList: self.list)
        }
    }

    
    func request(page: Int) {
        self.loading = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.loading = false
            self.curpage = page
            
            if (page==1) {
                self.list = Array(1...10)
            } else {
                self.list += Array(self.list.count+1...self.list.count+10)
            }
            self.configTable()
        }
    }
}
