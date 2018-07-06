//
//  ZLCDDContext.swift
//  Money
//
//  Created by 李占理 on 2018/6/21.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit
class ZLCDDDataHandler: NSObject {
   var weakContext: ZLCDDContext?
}
class ZLCDDBusinessObject: NSObject {
   var weakContext: ZLCDDContext?
   var baseController: UIViewController?
}
class ZLCDDContext: NSObject {
   var dataHandler: ZLCDDDataHandler?
   var businessObject: ZLCDDBusinessObject?
    init(dataHandler:ZLCDDDataHandler?,businessObject:ZLCDDBusinessObject?) {
        super.init()
        self.dataHandler = dataHandler
        self.dataHandler?.weakContext = self
        
        self.businessObject = businessObject
        self.businessObject?.weakContext = self
    }
    class func enableCDDContext(){
        UIView.prepareUIViewForCDD()
    }
}
var paramsKey = "context"
extension NSObject{
   @objc dynamic weak var context:ZLCDDContext?{
        get{
            return objc_getAssociatedObject(self, &paramsKey) as? ZLCDDContext
        }
        set(value){
            objc_setAssociatedObject(self, &paramsKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
  @objc dynamic class func swizzledMethod(originalName: String, swizzledName: String) {
        let originalSelector = Selector(originalName)
        let swizzledSelector = Selector(swizzledName)
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        if originalMethod == nil || swizzledMethod == nil {
            return
        }
        let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        }else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
}
extension UIView{
  @objc dynamic class func prepareUIViewForCDD(){
        self.swizzledMethod(originalName: "didAddSubview:", swizzledName: "newDidAddSubview:")
    }
  //方法名注意 参数前不加 _ 会找不到方法
  @objc dynamic func newDidAddSubview(_ view:UIView){
        self.newDidAddSubview(view)
        self.buildViewContextFromSuper(view: view)
    }
  @objc dynamic func buildViewContextFromSuper(view:UIView){
        if view.context == nil {
            var sprView = view.superview
//            logInfo("sprView=\(type(of: sprView))")
            while(sprView != nil){
                if sprView?.context != nil{
                    view.context = sprView?.context
                    self.buildViewContextForChildren(view: view, context: view.context!)
                    break
                }
                sprView = sprView!.superview
            }
        }
    }
  @objc dynamic func buildViewContextForChildren(view:UIView,context:ZLCDDContext){
        for subView in view.subviews {
            subView.context = context
            self.buildViewContextForChildren(view: subView, context: context)
        }
    }
}
