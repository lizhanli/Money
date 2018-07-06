//
//  ZLCDDViewController.swift
//  Money
//
//  Created by 李占理 on 2018/6/22.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit

class ZLCDDViewController: UIViewController {

    var demoView:ZLDemoView2!
    var handler:ZLCDDDemoDataHandler!
    var bo:ZLCDDDemoBusinessObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.zl_configTitle(title: "CDD模式")
        self.view.backgroundColor = UIColor.white
        initContext()
        demoView = ZLDemoView2(frame: self.view.bounds)
        self.view.addSubview(demoView)
        demoView.context = self.context
        demoView.addBlueView()
        demoView.connectViewModel(model: bo)
        bo.connectModel(model: handler)
    }
    func initContext(){
        handler = ZLCDDDemoDataHandler()
        handler.content = "我是测试1号"
        bo = ZLCDDDemoBusinessObject()
        bo.baseController = self
        self.context = ZLCDDContext(dataHandler: handler, businessObject: bo)
    }
}
class ZLDemoView2: UIView {
    var blue:ZLBlueView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.green
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickTap))
        self.addGestureRecognizer(tap)
    }
    func addBlueView(){
        blue = ZLBlueView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        blue.center = self.center
        self.addSubview(blue)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func clickTap(){
        logInfo(#function)
        (self.context?.businessObject as? ZLCDDDemoBusinessObject)?.clickTest()
    }
    //绑定ViewModel
    func connectViewModel(model:ZLCDDDemoBusinessObject){
        model.addObserver(self, forKeyPath: "contentStr", options: NSKeyValueObservingOptions.new, context: nil)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let _ = object as? ZLCDDDemoBusinessObject,keyPath == "contentStr" {
            let str = change?[NSKeyValueChangeKey.newKey] as? String
            blue.contentLabel.text = str
        }
    }
}
class ZLBlueView: UIView {
    lazy var contentLabel: UILabel = {
        let label = UILabel.zl_defaultLabel(text: "", color: UIColor.red)
        label.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(label)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickTapBlueView))
        self.addGestureRecognizer(tap)
        self.backgroundColor = UIColor.blue
        contentLabel.frame = self.bounds
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func clickTapBlueView(){
        logInfo(#function)
        (self.context?.businessObject as? ZLCDDDemoBusinessObject)?.clickTest2()
    }
}
class ZLDemoView: UIView ,UITableViewDelegate,UITableViewDataSource{
    lazy var tableView: UITableView = {
        let _tableView = UITableView(frame: self.bounds, style: UITableViewStyle.plain)
        _tableView.delegate = self
        _tableView.dataSource = self
        _tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        return _tableView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI(){
        self.addSubview(tableView)
    }
    //MARK: -UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)====="
        return cell
    }
    //MARK: -UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        (self.context?.businessObject as? ZLCDDDemoBusinessObject)?.clickTest()
    }
}
class ZLCDDDemoDataHandler: ZLCDDDataHandler {
    var content:String?
}
class ZLCDDDemoBusinessObject: ZLCDDBusinessObject {
    @objc dynamic var contentStr:String?
    var model:ZLCDDDemoDataHandler?
    func clickTest(){
        logInfo("我是测试一号")
    }
    func clickTest2(){
        logInfo("我是测试二号")
        self.model?.content = "我是测试\(arc4random())"
        self.contentStr = self.model?.content
    }
    //绑定model
    func connectModel(model:ZLCDDDemoDataHandler){
        self.model = model
        self.contentStr = model.content
    }
}
