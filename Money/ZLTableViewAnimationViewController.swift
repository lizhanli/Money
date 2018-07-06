//
//  ZLTableViewAnimationViewController.swift
//  Money
//
//  Created by 李占理 on 2018/7/5.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit

class ZLTableViewAnimationViewController: UIViewController {
    
    var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.zl_configTitle(title: "TableView动画")
        self.view.backgroundColor = UIColor.white
        tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.separatorStyle = .none
//        startAnimate()
    }
    func startAnimate(){
        self.tableView.reloadData()
        let cellCount = tableView.visibleCells.count
        for i in 0..<cellCount {
            let currentCell = tableView.visibleCells[i]
            currentCell.transform = CGAffineTransform(translationX: -ZLScreenWidth, y: 0)
            UIView.animate(withDuration: 0.25, delay: Double(i)*(0.3 / Double(cellCount)), options: [], animations: {
                currentCell.transform = CGAffineTransform.identity
            }) { (flag) in
            }
        }
    }
}
extension ZLTableViewAnimationViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let contentV = UIView(frame: CGRect(x: 20, y: 10, width: ZLScreenWidth - 40, height: 80))
        contentV.backgroundColor = UIColor.orange
        contentV.layer.cornerRadius = 9
        contentV.clipsToBounds = true
        cell.contentView.addSubview(contentV)
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        shrinkToTopAnimationWithTableView(cell: cell, indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    //MARK: -从左边开始进入
    func startAnimateFromLeft(cell:UITableViewCell,indexPath:IndexPath){
        cell.transform = CGAffineTransform(translationX: -ZLScreenWidth, y: 0)
        let cellCount = tableView.numberOfRows(inSection: indexPath.section)
        UIView.animate(withDuration: 0.5, delay: Double(indexPath.row)*(1 / Double(cellCount)), options: [], animations: {
            cell.transform = CGAffineTransform.identity
        }) { (flag) in
        }
    }
    //MARK: -从左边开始进入并有弹簧效果
    func startAnimateFromLeftWithDaSpringmping(cell:UITableViewCell,indexPath:IndexPath){
        cell.transform = CGAffineTransform(translationX: -ZLScreenWidth, y: 0)
        let cellCount = tableView.numberOfRows(inSection: indexPath.section)
        UIView.animate(withDuration: 0.5, delay: Double(indexPath.row)*(1 / Double(cellCount)), usingSpringWithDamping: 0.7, initialSpringVelocity: 1/0.7, options: UIViewAnimationOptions.curveEaseIn, animations: {
            cell.transform = .identity
        }) { (flag) in
            
        }
    }
    //MARK: -通过改变alpha实现动画
    func alphaAnimationWithTableView(cell:UITableViewCell,indexPath:IndexPath){
        cell.alpha = 0
        let cellCount = tableView.numberOfRows(inSection: indexPath.section)
        UIView.animate(withDuration: 0.5, delay: Double(indexPath.row)*(1 / Double(cellCount)), options: [], animations: {
            cell.alpha = 1.0
        }) { (flag) in
        }
    }
    //MARK: -坠落动画
    func fallAnimationWithTableView(cell:UITableViewCell,indexPath:IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: -ZLScreenHeight)
        let cellCount = tableView.numberOfRows(inSection: indexPath.section)
        UIView.animate(withDuration: 0.5, delay: Double(indexPath.row)*(1 / Double(cellCount)), options: [], animations: {
            cell.transform = .identity
        }) { (flag) in
        }
    }
    //MARK: -左右双向动画
    func shakeAnimationWithTableView(cell:UITableViewCell,indexPath:IndexPath){
        if indexPath.row % 2 == 0 {
            cell.transform = CGAffineTransform(translationX: -ZLScreenWidth, y: 0)
        }else{
            cell.transform = CGAffineTransform(translationX: ZLScreenWidth, y: 0)
        }
        let cellCount = tableView.numberOfRows(inSection: indexPath.section)
        UIView.animate(withDuration: 0.5, delay: Double(indexPath.row)*(1 / Double(cellCount)), usingSpringWithDamping: 0.7, initialSpringVelocity: 1/0.7, options: UIViewAnimationOptions.curveEaseIn, animations: {
            cell.transform = .identity
        }) { (flag) in
            
        }
    }
    //MARK: -绕X轴翻转
    func overTurnAnimationWithTableView(cell:UITableViewCell,indexPath:IndexPath){
        cell.layer.opacity = 0
        cell.layer.transform = CATransform3DRotate(cell.layer.transform, CGFloat(Double.pi), 1, 0, 0)
        let cellCount = tableView.numberOfRows(inSection: indexPath.section)
        UIView.animate(withDuration: 0.5, delay: Double(indexPath.row)*(1 / Double(cellCount)), options: [], animations: {
            cell.layer.opacity = 1
            cell.layer.transform = CATransform3DIdentity
        }) { (flag) in
        }
    }
    //MARK: -从下向上进入
    func toTopAnimationWithTableView(cell:UITableViewCell,indexPath:IndexPath){
        cell.transform = CGAffineTransform(translationX: 0, y: ZLScreenHeight)
        let cellCount = tableView.numberOfRows(inSection: indexPath.section)
        UIView.animate(withDuration: 0.5, delay: Double(indexPath.row)*(1 / Double(cellCount)), options: [], animations: {
            cell.transform = .identity
        }) { (flag) in
        }
    }
    //MARK: -通过改变cell的y
    func shrinkToTopAnimationWithTableView(cell:UITableViewCell,indexPath:IndexPath){
        let rect = cell.convert(cell.bounds, to: tableView)
        cell.transform = CGAffineTransform(translationX: 0, y: -rect.origin.y)
        UIView.animate(withDuration: 0.5) {
            cell.transform = .identity
        }
    }
}
