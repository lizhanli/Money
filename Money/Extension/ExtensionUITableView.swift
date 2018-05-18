//
//  ExtensionUITableView.swift
//  unique
//
//  Created by 李占理 on 17/7/29.
//  Copyright © 2017年 李占理. All rights reserved.
//

import UIKit

extension UITableView{

    static func zl_defaultTableView(frame:CGRect,style:UITableViewStyle = UITableViewStyle.plain) ->UITableView{
        let tableView = UITableView(frame: frame, style: style)
        tableView.backgroundColor = ZLColor.Background
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        return tableView
    }
  
}
