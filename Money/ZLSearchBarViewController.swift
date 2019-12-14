//
//  ZLSearchBarViewController.swift
//  Money
//
//  Created by 李占理 on 2019/3/12.
//  Copyright © 2019 Marsli. All rights reserved.
//

import UIKit

class ZLSearchBarViewController: UIViewController {

    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.definesPresentationContext = true
        self.edgesForExtendedLayout = []
        
        let searchBar = CustomUISearchBar(frame: CGRect(x: 10, y: 100, width: ZLScreenWidth - 20, height: 40))
        searchBar.center.x = self.view.center.x
        self.view.addSubview(searchBar)
        self.searchBar = searchBar
        searchBar.placeholder = "搜索好友账号或昵称"
        
//        searchBar.sizeToFit()
//        searchBar.layer.borderWidth = 1
//        searchBar.layer.borderColor = UIColor.white.cgColor
//        searchBar.layer.cornerRadius = 5
//        searchBar.layer.masksToBounds = true
//        searchBar.tintColor = UIColor.red
//        searchBar.backgroundColor = UIColor.red
//        searchBar.barTintColor = UIColor.white

//        let searchField = searchBar.value(forKey: "_searchField") as? UITextField
//        searchField?.setValue(UIFont.systemFont(ofSize: 15), forKeyPath: "_placeholderLabel.font")
//        searchBar.setImage(UIImage(named: "搜索框内搜索图标"), for: UISearchBarIcon.search, state: UIControlState.normal)

//        searchBar.frame = CGRect(x: 0, y: 2, width: self.view.zl_width - 50, height: 36)
//        searchBar.center.y = self.view.center.y
//        searchBar.center.x = self.view.center.x
        

//        let cancleButton = UIButton(frame: CGRect(x: searchBar.frame.maxX + 10, y: 0, width: 40, height: 36))
//        cancleButton.setTitle("取消", for: UIControlState.normal)
//        cancleButton.setTitleColor(UIColor.white, for: UIControlState.normal)
//        cancleButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        cancleButton.addTarget(self, action: #selector(clickCancelButton), for: UIControlEvents.touchUpInside)
//        normalTitleView.addSubview(cancleButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.resignFirstResponder()
    }
    
}
