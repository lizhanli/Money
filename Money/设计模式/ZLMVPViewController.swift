//
//  ZLMVPViewController.swift
//  Money
//
//  Created by 李占理 on 2018/6/19.
//  Copyright © 2018年 Marsli. All rights reserved.
//
/*
 *MVP的核心思想就是 V、M相互之间不知道对方的存在
 *由P来跟两者相互通信
 *Controller来管理三者
 *由P来处理逻辑
 */
import UIKit

class ZLMVPViewController: UIViewController {

    var parenter:ZLMVPParenter?
    var mvpView:ZLMVPView?
    var mvpModel:ZLMVPModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.zl_configTitle(title: "MVP")
        self.view.backgroundColor = UIColor.white
        mvpView = ZLMVPView(frame: self.view.bounds)
        self.view.addSubview(mvpView!)
        parenter = ZLMVPParenter()
        mvpModel = ZLMVPModel()
        mvpModel?.content = "我是测试"
        parenter?.model = mvpModel
        parenter?.mvpView = mvpView
        mvpView?.delegate = parenter
        parenter?.showContent()
    }
}

class ZLMVPParenter: NSObject,ZLMVPViewProtocol{
    var model:ZLMVPModel?
    var mvpView:ZLMVPView?
    func showContent(){
        let content = model?.content
        mvpView?.setContentValue(content: content)
    }
    func clickMVPView() {
        self.model?.content = "我是测试\(arc4random() + 10)"
        showContent()
    }
}
class ZLMVPModel: NSObject {
    var content:String?
}
protocol ZLMVPViewProtocol {
    func clickMVPView()
}
class ZLMVPView: UIView {
    lazy var contentLabel: UILabel = {
        let label = UILabel.zl_defaultLabel(text: "", color: UIColor.red)
        label.font = UIFont.systemFont(ofSize: 32)
        self.addSubview(label)
        return label
    }()
    var delegate:ZLMVPViewProtocol?
    
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
    func setContentValue(content:String?){
        contentLabel.text = content
    }
    @objc func clickMVPViewGesture(){
        self.delegate?.clickMVPView()
    }
}



