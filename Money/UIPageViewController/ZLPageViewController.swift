//
//  ZLPageViewController.swift
//  Money
//
//  Created by 李占理 on 2018/7/24.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit

class ZLPageViewController: UIViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    //定义UIPageViewController和内容数组
    var pageController:UIPageViewController!
    var pageContent:[String] = [String]()
    deinit {
        logInfo(#function)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化UIPageViewController
        //transitionStyle: 翻页效果（卷起来翻卷、水平活动翻卷）
        //navigationOrientation：翻页方向（水平方向、竖直方向）
        //options: 这是一个字典，设置翻页控制器的书脊位置（none／min／mid／max）
        pageController = UIPageViewController.init(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: [UIPageViewControllerOptionSpineLocationKey:NSNumber(value:UIPageViewControllerSpineLocation.min.rawValue)])
        pageController.view.frame = self.view.bounds
        
        //设置代理，提供展示相关的信息和接收手势发起的转换的通知
        pageController.delegate = self
        
        //设置数据源,提供展示的内容
        pageController.dataSource = self
        
        //创建显示内容
        self.createContentPages()
        
        //初始化内容控制器
        let initalViewController = self.viewControllerAtIndex(index: 0)
        pageController.setViewControllers([initalViewController!], direction: .forward, animated: false) { (b:Bool) in
            
            //UIPageController必须放在Controller Container中
            self.addChildViewController(self.pageController)
            self.view.addSubview(self.pageController.view)
            self.pageController.didMove(toParentViewController: self)
        }
    }
    
    //自定义方法，创建显示视图
    func viewControllerAtIndex(index:Int) -> ContentViewController? {
        if self.pageContent.count == 0 || index > self.pageContent.count {
            return nil
        }
        let dataViewController = ContentViewController()
        dataViewController.content = self.pageContent[index]
//        dataViewController.dataObject = self.pageContent[index]
//        dataViewController.loadHTMLContent()
        return dataViewController
    }
    
    //自定义方法，获取viewController的页码
    func indexOfViewController(viewControler:ContentViewController) -> Int {
        return self.pageContent.index(of: viewControler.content!)!
    }
    
    //自定义方法，创建显示内容
    func createContentPages() -> Void {
        
        for i in 1..<11 {
            let contentString = "我是第\(i)页"
            pageContent.append(contentString)
        }
    }
    
    //实现UIPageViewControllerDeleagte代理方法
    //将要翻页
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        print("started")
    }
    //翻页结束
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        print("finished")
    }
    //设置书脊位置
    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        return .min
    }
    //设置设备支持方向
    func pageViewControllerSupportedInterfaceOrientations(_ pageViewController: UIPageViewController) -> UIInterfaceOrientationMask {
        return .all
    }
    //设置优选方向
    func pageViewControllerPreferredInterfaceOrientationForPresentation(_ pageViewController: UIPageViewController) -> UIInterfaceOrientation {
        return .portrait
    }
    
    //实现UIPageViewControllerDataSource数据源方法
    //返回总页数
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pageContent.count
    }
    //向前翻页
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        //获取当前viewController的页码
        var index:Int = self.indexOfViewController(viewControler: viewController as! ContentViewController)
        
        //如果是第0页，返回nil
        if index == 0 || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        
        return self.viewControllerAtIndex(index: index)
    }
    //向后翻页
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        //获取当前viewController的页码
        var index:Int = self.indexOfViewController(viewControler: viewController as! ContentViewController)
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        
        //如果是最后一张，返回nil
        if index == self.pageContent.count {
            return nil
        }
        
        return self.viewControllerAtIndex(index: index)
    }
}

class ContentViewController: UIViewController {
    
    var content:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let label = UILabel.zl_defaultLabel(text: "", color: UIColor.black)
        label.frame = self.view.bounds
        self.view.addSubview(label)
        label.text = content
    }
}
