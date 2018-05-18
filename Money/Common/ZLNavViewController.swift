//
//  ZLNavViewController.swift
//  fighting
//
//  Created by 李占理 on 16/11/26.
//  Copyright © 2016年 lianxi. All rights reserved.
//

import UIKit

class ZLNavViewController: UINavigationController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        zl_configNavigationBarBackground(color: ZLColor.Navigation)
        zl_configNavgationBarShadowColor(color: nil)
        zl_configNavigationBarTintColor(ZLColor.White)
        zl_configNavigationTitleText(17, color: ZLColor.White)
        zl_configBackImage()
        UIApplication.shared.setStatusBarOrientation(UIInterfaceOrientation.portrait, animated: true)
    }
    
    func setupNavBar() {
        self.navigationBar.barTintColor = UIColor.yellow
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.red]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
       return UIStatusBarStyle.lightContent
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.setNavigationBarHidden(false, animated: false)
        if self.viewControllers.count == 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
    override var prefersStatusBarHidden: Bool{
        return false
    }
    override var shouldAutorotate: Bool {
        guard let topViewController = topViewController else {
            return true
        }
        return topViewController.shouldAutorotate
    }
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
//        return UIInterfaceOrientation.landscapeLeft
//    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        guard let topViewController = topViewController else {
            return .portrait
        }
        return topViewController.supportedInterfaceOrientations
    }
}
extension ZLNavViewController{
    /*
     *isTranslucent:iOS7之后，isTranslucent = true 默认的,则状态栏及导航栏底部为透明的，界面上的组件应该从屏幕顶部开始显示，因为是半透明的，可以看到，所以为了不和状态栏及导航栏重叠，第一个组件的y应该从44+20的位置算起,如果设置成false，则状态栏及导航样不为透明的，界面上的组件就是紧挨着导航栏显示了，所以就不需要让第一个组件在y方向偏离44+20的高度了。
    */
    func zl_configNavigationBarBackground(color:UIColor? = UIColor.white){
        if color != nil {
            let image = UIView.zl_creatImage(color: color!)
            self.navigationBar.isTranslucent = false
            self.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            self.navigationBar.setBackgroundImage(image, for: UIBarMetrics.compact)
        }else{
            self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.compact)
            self.navigationBar.isTranslucent = true
        }
    }
    
    func zl_configNavgationBarShadowColor(color:UIColor?){
        if color == nil {
            self.navigationBar.shadowImage = UIImage()
        }else{
            self.navigationBar.shadowImage = UIView.zl_createImage(size: CGSize(width: ZLScreenWidth, height: 1), fillColor: color!, withCorner: 0)
        }
    }
    
    func zl_configNavigationBarTintColor(_ color: UIColor = UIColor.darkGray) {
        self.navigationBar.tintColor = color
    }
    
    func zl_configNavigationTitleText(_ fontSize: CGFloat = 16, color: UIColor = ZLColor.White) {
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize)]
    }
    
    func zl_configBackImage() {
        let path = DMPathUtils.createPathIndicator(CGRect(x: 1, y: 0, width: 8 ,height: 16), dir: .left)
        path.lineWidth = 1.5
        let image = UIView.zl_createImage(size: CGSize(width: 10, height: 18), strokeColor: self.navigationBar.tintColor, fillColor: UIColor.clear, path: path)
        self.navigationBar.backIndicatorImage = image
        self.navigationBar.backIndicatorTransitionMaskImage = image
    }

}
