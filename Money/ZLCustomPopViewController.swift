//
//  ZLCustomPopViewController.swift
//  Money
//
//  Created by 李占理 on 2018/7/10.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit

class ZLCustomPopViewController: UIViewController,UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning,UITableViewDelegate,UITableViewDataSource{
    
    var tableView:UITableView!
    var iconArray = ["Home_demo_01","Home_demo_02","Home_demo_03"]
    var selectIndexPath:IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.register(CustomPopCell.self, forCellReuseIdentifier: "CustomPopCellId")
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomPopCellId", for: indexPath) as! CustomPopCell
        cell.displayDictionary(icon: iconArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (ZLScreenWidth - 40) * 1.3 + 25
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        UIView.animate(withDuration: 0.2) {
            UIApplication.shared.isStatusBarHidden = false
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ZLCustomPopToViewController()
        controller.bgImage = self.view.takeSnapShot()
        controller.imageName = iconArray[indexPath.row]
        controller.selectIndexPath = indexPath
    self.navigationController?.pushViewController(controller, animated: true)
    }
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        selectIndexPath = indexPath
        let cell = tableView.cellForRow(at: indexPath)
        UIView.animate(withDuration: 0.2) {
            cell?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        return true
    }
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if selectIndexPath == indexPath {
            let cell = tableView.cellForRow(at: indexPath)
            UIView.animate(withDuration: 0.2, delay: 0.2, options: UIViewAnimationOptions.curveLinear, animations: {
                cell?.transform = CGAffineTransform(scaleX: 1, y: 1)

            }, completion: nil)
        }
    }
    //MARK: -UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    //MARK: -UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? ZLCustomPopToViewController
        let cell = self.tableView.cellForRow(at: selectIndexPath) as! CustomPopCell
        let containerView = transitionContext.containerView
        let toView = toVC?.value(forKeyPath: "headImageView") as? UIImageView
        let fromView = cell.bgView
        let snapshotView = UIImageView(image: cell.bgImageView.image)
        snapshotView.frame = containerView.convert(fromView.frame, from: fromView.superview)
        fromView.isHidden = true
        toVC?.view.frame = transitionContext.finalFrame(for: toVC!)
        toVC?.view.alpha = 0
        toView?.isHidden = true
        
        containerView.addSubview((toVC?.view)!)
        containerView.addSubview(snapshotView)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.curveLinear, animations: {
            containerView.layoutIfNeeded()
            toVC?.view.alpha = 1
            snapshotView.frame = containerView.convert(toView!.frame, from: toView!.superview)
        }) { (_) in
            toView?.isHidden = false
            fromView.isHidden = false
            snapshotView.removeFromSuperview()
            self.tableView.reloadData()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
class CustomPopCell: UITableViewCell {
    
    lazy var bgView: UIView = {
        let bgV = UIView(frame: CGRect(x: 20, y: 0, width: ZLScreenWidth - 40, height: (ZLScreenWidth - 40)*1.3))
        self.contentView.addSubview(bgV)
        return bgV
    }()
    lazy var bgImageView: UIImageView = {
        let bgImage = UIImageView(frame: self.bgView.bounds)
        bgImage.contentMode = UIViewContentMode.scaleAspectFill
        bgImage.layer.cornerRadius = 15
        bgImage.layer.masksToBounds = true
        self.bgView.addSubview(bgImage)
        return bgImage
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func displayDictionary(icon:String?){
        if icon == nil {
            return
        }
        bgImageView.image = UIImage(named: icon!)
    }
}
class ZLCustomPopToViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning,UIGestureRecognizerDelegate{
    private var bgImageView:UIImageView!
    var bgImage:UIImage?
    var tableView:UITableView!
    var headView:UIView?
    @objc dynamic var headImageView:UIImageView?
    var imageName:String?
    var selectIndexPath:IndexPath!
    var startPointY:CGFloat = 0
    var startPointX:CGFloat = 0
    var isHorizontal = false
    var scale:CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        self.view.backgroundColor = UIColor.blue
       
        bgImageView = UIImageView(frame: self.view.bounds)
        self.view.addSubview(bgImageView)
        bgImageView.image = bgImage
        tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        headView = UIView(frame: CGRect(x: 0, y: 0, width: ZLScreenWidth, height: ZLScreenWidth * 1.3))
        headImageView = UIImageView(frame: (headView?.bounds)!)
        headImageView?.image = UIImage(named: imageName!)
        headView?.addSubview(headImageView!)
        self.tableView.tableHeaderView = headView
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(pan:)))
        pan.delegate = self
        self.tableView.addGestureRecognizer(pan)
        
    }
    @objc func pan(pan:UIPanGestureRecognizer){
        switch pan.state {//手势开始
        case .began:
            let currentPoint = pan.location(in: self.tableView)
            startPointX = currentPoint.x
            startPointY = currentPoint.y
             // 确定是否可以横划，判断起始点位置
            if startPointX > CGFloat(30){
                isHorizontal = true
            }else{
                isHorizontal = false
            }
        case .changed:
            let currentPoint = pan.location(in: self.tableView)
            // 如果可以横划，判断是横划还是竖划
            if isHorizontal{
                if currentPoint.x - startPointX > currentPoint.y - startPointY{
                    scale = (ZLScreenWidth - (currentPoint.x - startPointX)) / ZLScreenWidth
                }else{
                    scale = (ZLScreenHeight - (currentPoint.y - startPointY)) / ZLScreenHeight
                }
            }else{
                scale = (ZLScreenHeight - (currentPoint.y - startPointY)) / ZLScreenHeight
            }
            if scale > 1{
                scale = 1
            }else if scale < 0.8{
                scale = 0.8
            self.navigationController?.popViewController(animated: true)
            }
            if self.tableView.contentOffset.y <= 0{
                self.tableView.transform = CGAffineTransform(scaleX: scale, y: scale)
                self.tableView.layer.cornerRadius = 15 * (1 - scale)*5*1.08
            }
            if scale < 0.99{
               self.tableView.isScrollEnabled = false
            }else{
                self.tableView.isScrollEnabled = true
            }
        case .ended:
            scale = 1
        default:
            break
        }
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if (otherGestureRecognizer.view?.isKind(of: UITableView.self) != nil) {
            return true
        }
        return false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.2) {
            UIApplication.shared.isStatusBarHidden = true
        }
    }
    //MARK: -UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    //MARK: -UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! ZLCustomPopViewController
        let fromVC = transitionContext.viewController(forKey: .from) as! ZLCustomPopToViewController
        let cell = toVC.tableView.cellForRow(at: selectIndexPath) as! CustomPopCell
        let originView = cell.bgImageView
        let containerView = transitionContext.containerView
        
        let fromView = fromVC.value(forKeyPath: "headImageView") as? UIImageView
        let snapShotView = fromView?.snapshotView(afterScreenUpdates: false)
        snapShotView?.layer.masksToBounds = true
        snapShotView?.layer.cornerRadius = 15
        snapShotView?.frame = containerView.convert(fromView!.frame, from: fromView?.superview)
        fromView?.isHidden = true
        originView.isHidden = true
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        containerView.addSubview(snapShotView!)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.curveLinear, animations: {
            containerView.layoutIfNeeded()
            fromVC.view.alpha = 0
            snapShotView?.layer.cornerRadius = 15
            snapShotView?.frame = containerView.convert(originView.frame, from: originView.superview)
        }) { (_) in
            fromView?.isHidden = true
            originView.isHidden = false
            snapShotView?.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
    }
}
