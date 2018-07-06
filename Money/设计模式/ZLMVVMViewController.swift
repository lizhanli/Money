//
//  ZLMVVMViewController.swift
//  Money
//
//  Created by 李占理 on 2018/6/20.
//  Copyright © 2018年 Marsli. All rights reserved.
//
/*
 *MVVM 的核心思想是viewModel 跟view和model的双向绑定
 */


import UIKit

class ZLMVVMViewController: UIViewController {

    var mvvmView:ZLMVVMView?
    var mvvmModel:ZLMVVMModel?
    var mvvmViewModel:ZLMVVMViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.zl_configTitle(title: "MVVM")
        self.view.backgroundColor = UIColor.white
        mvvmView = ZLMVVMView(frame: self.view.bounds)
        self.view.addSubview(mvvmView!)
        mvvmModel = ZLMVVMModel()
        mvvmModel?.content = "我是测试"
        mvvmViewModel = ZLMVVMViewModel()
        mvvmView?.connectViewModel(viewModel: mvvmViewModel!)
        mvvmViewModel?.connectViewModel(model: mvvmModel!)
    }
}
class ZLMVVMViewModel: NSObject {
    @objc dynamic var contentStr: String?
    var model:ZLMVVMModel?
    func connectViewModel(model:ZLMVVMModel){
        self.model = model
        self.contentStr = model.content
    }
    //改变contentStr的值
    func changeContentStr(){
        self.model?.content = "我是测试\(arc4random())"
        self.contentStr = self.model?.content
    }
}
class ZLMVVMModel: NSObject {
    var content: String?
}
class ZLMVVMView: UIView {
    lazy var contentLabel: UILabel = {
        let label = UILabel.zl_defaultLabel(text: "", color: UIColor.red)
        label.font = UIFont.systemFont(ofSize: 32)
        self.addSubview(label)
        return label
    }()
    var mvvmVieModel:ZLMVVMViewModel?
    deinit {
        self.mvvmVieModel?.removeObserver(self, forKeyPath: "contentStr")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickMVPViewGesture))
        self.addGestureRecognizer(tap)
        contentLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self.snp.edges)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func clickMVPViewGesture(){
        self.mvvmVieModel?.changeContentStr()
    }
    //添加观察者模式
    func connectViewModel(viewModel:ZLMVVMViewModel){
        self.mvvmVieModel = viewModel
        viewModel.addObserver(self, forKeyPath: "contentStr", options: NSKeyValueObservingOptions.new, context: nil)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let _ = object as? ZLMVVMViewModel,keyPath == "contentStr" {
            let str = change?[NSKeyValueChangeKey.newKey] as? String
            self.contentLabel.text = str
        }
    }
}
