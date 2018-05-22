//
//  ZLHeadStackTableViewController.swift
//  Money
//
//  Created by 李占理 on 2018/5/21.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit

class ZLHeadStackTableViewController: BaseUITableViewController {
    var headFrame:CGRect!
    var headView:ZLImageHeadView!
    override func viewDidLoad() {
        style = .grouped
        super.viewDidLoad()
        cellArray = [UITableViewCell()]
        let headView = ZLImageHeadView(frame: CGRect(x: 0, y: -200, width: ZLScreenWidth, height: 200))
        self.view.insertSubview(headView, at: 0)
        self.headView = headView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0)
        tableView.setContentOffset(CGPoint(x: 0, y: -200), animated: true)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.headView.frame = headFrame
        logInfo("\(headFrame)")
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        logInfo("\(scrollView.contentOffset.y)")
        var frame = CGRect(x: 0, y: -200, width: ZLScreenWidth, height: 200)
        frame.origin.y = scrollView.contentOffset.y * 0.6 - 200 * 0.4
        self.headFrame = frame
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 36
    }
}
