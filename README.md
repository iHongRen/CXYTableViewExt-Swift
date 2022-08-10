# CXYTableViewExt-Swift
Make UITableView configuration easier. 让你更简单的配置UITableView，极大的简化逻辑



## Usage(使用)

1、Customize your Cell , then implement the **CXYTableItemProtocol** protocol

(自定义Cell，然后实现 **CXYTableItemProtocol** 协议)

```swift
class TextCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
}

extension TextCell: CXYTableItemProtocol {
    func configItem(data: Any?) {
        if let model = data as? Int {
            self.title.text = "\(model)"
        }
    }
}
```



2、Configure your TableView  

(配置TableView，无需提前注册Cells)

```swift
override func viewDidLoad() {
    super.viewDidLoad()        
    configTable()
}

func configTable() {
    self.tableView.t.makeConfig { make in
        make.addCellItems(cellClass: TextCell.self, dataList: Array(1...10))
    }
}
```

