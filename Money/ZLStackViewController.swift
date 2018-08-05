//
//  ZLStackViewController.swift
//  Money
//
//  Created by 李占理 on 2018/7/10.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit

class ZLStackViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.zl_configTitle(title: "页面层叠")
        self.view.backgroundColor = UIColor.green
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.present(ZLStaticChildViewController(), animated: true, completion: nil)
    }
}
class ZLStaticChildViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    var backImageView:UIImageView!
    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backImageView = UIImageView(frame: self.view.bounds)
        self.view.addSubview(backImageView)
        backImageView.image = getPresentedViewController()?.view.takeSnapShot()
        tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
       
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        if #available(iOS 11.0,*){
            tableView.contentInsetAdjustmentBehavior = .never
        }
    }
    //MARK: -显示当前控制器
    func showMenuController(){
        UIView.animate(withDuration: 0.3) {
            self.tableView.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height)
        }
    }
    //MARK: -退出当前控制器
    func dismissMenuController(){
        UIView.animate(withDuration: 0.3, animations: {
            var tempFrame = self.tableView.frame
            tempFrame.origin.y = self.tableView.bounds.size.height
            self.tableView.frame = tempFrame
        }) { (flag) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let alpha = offsetY / 200
        scrollView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1 - -alpha)
    }
    //MARK: -取消拖动
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if -scrollView.contentOffset.y < 120 {
            showMenuController()
        }else{
            scrollView.backgroundColor = UIColor.clear
            dismissMenuController()
        }
    }
    //MARK: -获取上一个控制器
    func getPresentedViewController() ->UIViewController?{
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        var topVC = rootVC
        if topVC?.parent != nil {
            topVC = topVC?.parent
        }
        return topVC
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)======"
        return cell
    }
}
