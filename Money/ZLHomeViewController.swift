//
//  ZLHomeViewController.swift
//  Money
//
//  Created by 李占理 on 2018/5/17.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit

class ZLHomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        var height = ZLScreenHeight - zl_heightNavBar - zl_heightStatusBar - zl_heightTabBar
        if UIDevice.current.isIphoneX() {
            height = height - BOTTOMSAFEHEIGHT
        }
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ZLScreenWidth, height: height), style: UITableViewStyle.plain)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    
    }
    //MARK: -UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 36
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)======="
        return cell
    }
    //MARK: -UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(ZLDownLoadViewController(), animated: true)
    }
}
