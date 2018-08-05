//
//  ZLMidViewController.swift
//  unique
//
//  Created by 李占理 on 17/8/14.
//  Copyright © 2017年 李占理. All rights reserved.
//

import UIKit

protocol Prototype {
    func clone() -> Prototype
}
struct Product: Prototype {
    var title: String
    func clone() -> Prototype {
        return Product(title: title)
    }
}
public class BinarySearchTree<T: Comparable> {
    private(set) public var value: T
    private(set) public var parent: BinarySearchTree?
    private(set) public var left: BinarySearchTree?
    private(set) public var right: BinarySearchTree?
    
    public init(value: T) {
        self.value = value
    }
    public convenience init(array: [T]) {
        precondition(array.count > 0)
        self.init(value: array.first!)
        for v in array.dropFirst() {
            insert(value: v, parent: self)
        }
    }
    public var isRoot: Bool {
        return parent == nil
    }
    
    public var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    public var isLeftChild: Bool {
        return parent?.left === self
    }
    
    public var isRightChild: Bool {
        return parent?.right === self
    }
    
    public var hasLeftChild: Bool {
        return left != nil
    }
    
    public var hasRightChild: Bool {
        return right != nil
    }
    
    public var hasAnyChild: Bool {
        return hasLeftChild || hasRightChild
    }
    
    public var hasBothChildren: Bool {
        return hasLeftChild && hasRightChild
    }
    
    public var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    public func insert(_ value: T) {
        insert(value: value, parent: self)
    }
    private func insert(value: T, parent: BinarySearchTree) {
        if value < self.value {
            if let left = left {
                left.insert(value: value, parent: left)
            } else {
                left = BinarySearchTree(value: value)
                left?.parent = parent
            }
        } else {
            if let right = right {
                right.insert(value: value, parent: right)
            } else {
                right = BinarySearchTree(value: value)
                right?.parent = parent
            }
        }
    }
}
extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <- "
        }
        s += "\(value)"
        if let right = right {
            s += " -> (\(right.description))"
        }
        return s
    }
}

class ZLMidViewController: UIViewController {
    
    var present: ZLTestPresent?
    var testView: ZLTestView?
    var model: ZLTestModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ZLColor.Background
       
        
//        self.zl_configTitle(title: "这是测试")
//        setLeftBarButtonItem(title: "返回")
//        present = ZLTestPresent()
//        present?.currentVC = self
//        testView = ZLTestView(frame: self.view.bounds)
//        self.view.addSubview(testView!)
//        present?.testView = testView
//        present?.model = model
//        present?.loadData()
//        testView?.delegate = present
        
//        var p1 = Product(title: "p1")
//        p1.title = "p2"
//        let p2 = p1.clone()
//        // OUTPUT: p1
//        logInfo("\((p2 as? Product)?.title)")
//        let tree = BinarySearchTree<Int>(value: 7)
//        tree.insert(2)
//        tree.insert(5)
//        tree.insert(10)
//        tree.insert(9)
//        tree.insert(1)
        
        
        var array = [12,54,76,1,23,23,6]
        array.selectSort()
        logInfo("array==\(array)")
        let result = insertionSort(array: array)
        logInfo("result==\(result)")
        let mid = binarySearch(a: result, key: 5, range: 0..<7)
        logInfo("mid==\(mid)")
        if #available(iOS 10.0, *) {
            let queue1 = DispatchQueue(label: "1", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.never, target: nil)
            queue1.async {
                logInfo("qqqq\(Thread.current)")
                let globalQueue = DispatchQueue.global()
                globalQueue.sync {
                    print("0 + \(Thread.current)")
                }
                globalQueue.sync {
                    print("1 + \(Thread.current)")
                }
            }
        } else {
        }
    }
    //二分法（已经是排好顺序的）
    func binarySearch<T: Comparable>(a: [T], key: T, range: CountableRange<Int>) ->Int?{
        if range.startIndex >= range.endIndex {
            return nil
        }else{
            logInfo("range.first==\(range.first)")
            logInfo("range.last==\(range.last)")
            let mid = range.first! + (range.last! - range.first!) / 2
            logInfo("mid==\(mid)")
            if a[mid] > key {
                let start = range.first ?? 0
                logInfo("start==\(start)")
                return binarySearch(a: a, key: key, range: start..<mid)
            }else if a[mid] < key{
                let end = range.last ?? 0
                logInfo("end==\(end)")
                return binarySearch(a: a, key: key, range: mid + 1..<end + 1)
            }else{
                return mid
            }
        }
    }
    func insertionSort(array: [Int]) -> [Int] {
        var data = array
        for var x in 1..<data.count {
            while(x > 0 && data[x] < data[x - 1]){
                data.swapAt(x, x - 1)
                x = x - 1
            }
        }
        return data
    }
    override var prefersStatusBarHidden: Bool{
     return false
    }
    override var shouldAutorotate: Bool{
      return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return UIInterfaceOrientation.landscapeLeft
    }
    func handleDeviceOrientationChange(notification:Notification){
        let deviceOrientation = UIDevice.current.orientation
        switch deviceOrientation {
        case UIDeviceOrientation.faceUp:
            logInfo("屏幕朝上平躺")
        case UIDeviceOrientation.faceDown:
            logInfo("屏幕朝下平躺")
        case UIDeviceOrientation.landscapeLeft:
            logInfo("屏幕向左横置")
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
            UIApplication.shared.statusBarOrientation = .landscapeLeft
        case UIDeviceOrientation.landscapeRight:
            logInfo("屏幕向右横置")
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
            UIApplication.shared.statusBarOrientation = .landscapeRight
        case UIDeviceOrientation.portrait:
            logInfo("屏幕直立")
        case UIDeviceOrientation.portraitUpsideDown:
            logInfo("屏幕直立，上下颠倒")
        case UIDeviceOrientation.unknown:
            logInfo("未知方向")
        }
    }
    override func onLeftBarButtonClicked(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
class ZLTestCell: UITableViewCell {
    lazy var applyButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("点击", for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(UIColor.red, for: UIControlState.normal)
        btn.addTarget(self, action: #selector(clickApplyButton), for: UIControlEvents.touchUpInside)
        self.contentView.addSubview(btn)
        return btn
    }()
    var simpleBack: SimpleCallBack?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.width.equalTo(60)
            make.top.equalTo(self.contentView.snp.top).offset(20)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func clickApplyButton(){
        self.simpleBack?()
    }
}
protocol ZLTestViewProtocol {
    func clickApplyButton()
}
class ZLTestView: UIView,UITableViewDelegate,UITableViewDataSource{
    
    var tableView: UITableView!
    var dataArray: [String]?
    var delegate: ZLTestViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView = UITableView(frame: self.bounds, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        self.addSubview(tableView)
        tableView.register(ZLTestCell.self, forCellReuseIdentifier: "ZLTestCellId")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func getData(arryData:[String]?){
        self.dataArray = arryData
        self.tableView.reloadData()
    }
    //MARK: -UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZLTestCellId", for: indexPath) as! ZLTestCell
        cell.simpleBack = {[weak self] in
            self?.delegate?.clickApplyButton()
        }
        if let str = self.dataArray?[indexPath.row]{
            cell.textLabel?.text = "\(str)"
        }
        return cell
    }
}
class ZLTestPresent: NSObject,ZLTestViewProtocol{
    var dataArray = ["我是测试1","我是测试2","我是测试3","我是测试4","我是测试5","我是测试6"]
    var testView: ZLTestView?
    var model: ZLTestModel?
    weak var currentVC: ZLMidViewController?
    //加载数据
    func loadData(){
        testView?.getData(arryData: dataArray)
    }
    //MARK: -ZLTestViewProtocol
    func clickApplyButton() {
        let controller = UIViewController()
        controller.view.backgroundColor = UIColor.green
    self.currentVC?.navigationController?.pushViewController(controller, animated: true)
    }
}
class ZLTestModel: NSObject {
    
}


