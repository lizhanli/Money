//
//  BaseUITableViewController.swift
//  Money
//
//  Created by 李占理 on 2018/5/21.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit

class BaseUITableViewController: UITableViewController {

    var style:UITableViewStyle = .plain
    var cellArray = [UITableViewCell]()
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(style:UITableViewStyle = .plain) {
        self.style = style
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        var height = ZLScreenHeight - self.zl_heightNavBar - zl_heightStatusBar
        if UIDevice.current.isIphoneX() {
            height = height - BOTTOMSAFEHEIGHT
        }
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ZLScreenWidth, height: height), style: style)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    //MARK: -Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return cellArray.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)======="
        return cell
    }
}
