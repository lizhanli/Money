//
//  BaseUIViewController.swift
//  Money
//
//  Created by 李占理 on 2018/5/21.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit

class BaseUIViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tableView:UITableView!
    var style:UITableViewStyle = .plain
    var cellArray = [UITableViewCell]()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(style:UITableViewStyle = .plain) {
        self.style = style
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        var height = ZLScreenHeight - zl_heightNavBar - zl_heightStatusBar - zl_heightTabBar
        if UIDevice.current.isIphoneX() {
            height = height - BOTTOMSAFEHEIGHT
        }
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ZLScreenWidth, height: height), style:style)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    //MARK: -UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        return cell
    }
    //MARK: -UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
class BaseUIViewControllerPlan: BaseUIViewController {
    override init(style: UITableViewStyle) {
        super.init(style: .plain)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
class BaseUIViewControllerGrouped: BaseUIViewController {
    override init(style: UITableViewStyle) {
        super.init(style: .grouped)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
