//
//  ZLHomeViewController.swift
//  Money
//
//  Created by 李占理 on 2018/5/17.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit
import ZLAccount

class ZLHomeViewController: BaseUIViewControllerPlan{
    
    let dataArray = [
        ["title": "searchBar", "value": "ZLSearchBarViewController"],
        ["title": "视图动画", "value": "ZLAnimationViewController"],
        ["title": "事件", "value": "ZLUITouchViewController"],
        ["title":"断点续传","value":"ZLDownLoadViewController"],
        ["title":"头部层叠效果","value":"ZLHeadStackTableViewController"],
        ["title":"CATransform3D变换的应用","value":"ZLCATransform3DViewController"],
        ["title":"iOS CAAnimation动画体系的介绍","value":"ZLCAAnimationViewController"],
        ["title":"事务CATransaction","value":"ZLCATransactionViewController"],
        ["title":"自定义转场动画","value":"ZLModalTransitionViewController"],
        ["title":"UIBezierPath","value":"ZLBezierPathViewController"],
        ["title":"自定义转场动画","value":"ZLModalTransitionViewController"],
    ["title":"圆环转圈","value":"ZLStaticCircleViewViewController"],
    ["title":"MVP","value":"ZLMVPViewController"],
    ["title":"MVVM","value":"ZLMVVMViewController"],
    ["title":"CDD","value":"ZLCDDViewController"],
    ["title":"layout机制","value":"ZLLayoutViewController"],
    ["title":"TableView动画效果","value":"ZLTableViewAnimationViewController"],
    ["title":"页面层叠效果","value":"ZLStackViewController"],
    ["title":"自定义pop","value":"ZLCustomPopViewController"],
    ["title":"自定义pageVC","value":"ZLPageViewController"],
    ["title":"语音播报","value":"ZLAVSpeechSynthesizer"],
    ["title":"苹果核","value":"ZLLazyScrollViewController"],
    ["title": "图片拉伸", "value": "ZLStretchImageController"],
    ["title": "历史记录", "value": "ZLHistoryViewController"],
    ["title": "shapeLayer", "value": "ZLCustomShapeViewController"]
    ]
    var age:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellArray = [UITableViewCell()]
        
    }
    //MARK: -UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let dict = dataArray[indexPath.row]
        cell.textLabel?.text = dict.stringForKey("title")
        return cell
    }
    //MARK: -UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let value = dataArray[indexPath.row].stringForKey("value"),let nameSpace = Bundle.main.infoDictionary?.stringForKey("CFBundleExecutable"){
            //获取命名空间
            let className:AnyObject = NSClassFromString("\(nameSpace).\(value)")!
            let viewControllerClass = className as! UIViewController.Type
            let viewController = viewControllerClass.init()
        self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
//        let color = UIColor(red: scrollView.contentOffset.y / 255.0, green: 1, blue: 1, alpha: 1)
//    self.navigationController?.navigationBar.setNavigationBackgroundColor(backgroundColor: color)
        
//        logInfo("contentInset.top==\(scrollView.contentInset.top)")
//        logInfo("contentOffset.y===\(scrollView.contentOffset.y)")
    }
}
class ZLImageHeadView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.green
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


