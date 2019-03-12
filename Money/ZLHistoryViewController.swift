//
//  ZLHistoryViewController.swift
//  Money
//
//  Created by 李占理 on 2019/2/17.
//  Copyright © 2019 Marsli. All rights reserved.
//

import UIKit

class ZLHistoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {


    var collectionView: UICollectionView!
    
    var historyArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        historyArray = ["关","iOS","牛奶","今天是周五","我们要一起努力了不努力就要完蛋了","2","好好学习才是王道","哈哈"]
        
        let layout = UICollectionViewLeftAlignedLayout()
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: ZLScreenWidth, height: 300), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        //竖向cell之间的距离
        layout.minimumLineSpacing = 15
        //横向cell之间的距离，没有设置0.0
        layout.minimumInteritemSpacing = 10
        //section的header的大小
        layout.headerReferenceSize = CGSize(width: ZLScreenWidth, height: 44)
        //section的偏移量
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        //collectionView的偏移量
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 5, 0)
        //SearchCell:xib中item的identifier
        collectionView.register(UINib.init(nibName: "SearchCell", bundle: nil), forCellWithReuseIdentifier: "SearchCell")
        //SearchHeaderView中sender的header的identifier
//        collectionView.register(UINib.init(nibName: "SearchHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SearchHeaderView")
        collectionView.collectionViewLayout = layout
        
    }
    //MARK: - UICollectionViewDataSource
    /** Section数 */
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        if historyArray.count > 0 {
            return 1
        }
        return 0
    }
    
    /** Items数 */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return historyArray.count
    }
    
    /** Items创建 */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath as IndexPath) as? SearchCell
        cell?.name.text = historyArray[indexPath.item]
        return cell!
    }
    
    /** collection的header创建 */
//    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        let view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "SearchHeaderView", forIndexPath: indexPath) as? SearchHeaderView
//        return view!
//    }
    
    //MARK: - UICollectionViewDelegate
    
    /** 历史记录关键词点击 */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    /** 设置关键词大小 */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let name = historyArray[indexPath.item]
        let size = name.boundingRect(with: CGSize(width: ZLScreenWidth - 20, height: 30), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)], context: nil).size
        let with = size.width
        return CGSize(width: with + 40, height: 30)

    }
}

extension UICollectionViewLayoutAttributes {
    
    /** 每行第一个item左对齐 **/
    func leftAlignFrame(sectionInset:UIEdgeInsets) {
        var frame = self.frame
        frame.origin.x = sectionInset.left
        self.frame = frame
    }
}

class UICollectionViewLeftAlignedLayout: UICollectionViewFlowLayout {
    
    //MARK: - 重新UICollectionViewFlowLayout的方法
    override func prepare() {
        super.prepare()
    }
    /** Collection所有的UICollectionViewLayoutAttributes */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //换了一个数组的初始化方法完美的解决了问题
        let newArray: [UICollectionViewLayoutAttributes] = NSArray(array: super.layoutAttributesForElements(in: rect)!, copyItems: true) as! [UICollectionViewLayoutAttributes]
        for attributes in newArray {
            if nil == attributes.representedElementKind {
                let indexPath = attributes.indexPath
                attributes.frame = self.layoutAttributesForItem(at: indexPath)!.frame
            }
        }
        return newArray
    }
    
    /** 每个item的UICollectionViewLayoutAttributes */
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        //现在item的UICollectionViewLayoutAttributes
        let currentItemAttributes = super.layoutAttributesForItem(at: indexPath as IndexPath)!.copy() as! UICollectionViewLayoutAttributes
        //现在section的sectionInset
        let sectionInset = self.evaluatedSectionInset(itemAtIndex: indexPath.section)
        //是否是section的第一个item
        let isFirstItemInSection = indexPath.item == 0
        //出去section偏移量的宽度
        let layoutWidth: CGFloat = self.collectionView!.frame.size.width - sectionInset.left - sectionInset.right
        //是section的第一个item
        if isFirstItemInSection {
            currentItemAttributes.leftAlignFrame(sectionInset: sectionInset)
            return currentItemAttributes
        }
        
        //前一个item的NSIndexPath
        let previousIndexPath = NSIndexPath(item: indexPath.item - 1, section: indexPath.section)
        //前一个item的frame
        let previousFrame = self.layoutAttributesForItem(at: previousIndexPath as IndexPath)!.frame
        //为现在item计算新的left
        let previousFrameRightPoint: CGFloat = previousFrame.origin.x + previousFrame.size.width
        //现在item的frame
        let currentFrame = currentItemAttributes.frame
        //现在item所在一行的frame
        let strecthedCurrentFrame = CGRect(x: sectionInset.left, y: currentFrame.origin.y, width: layoutWidth, height: currentFrame.size.height)
        //previousFrame和strecthedCurrentFrame是否有交集，没有，说明这个item和前一个item在同一行，item是这行的第一个item
        let isFirstItemInRow = !previousFrame.intersects(strecthedCurrentFrame)
        //item是这行的第一个item
        if isFirstItemInRow {
            //每行第一个item左对齐
            currentItemAttributes.leftAlignFrame(sectionInset: sectionInset)
            return currentItemAttributes
        }
        //不是每行的第一个item
        var frame = currentItemAttributes.frame
        //为item计算新的left = previousFrameRightPoint + item之间的间距
        frame.origin.x = previousFrameRightPoint + self.evaluatedMinimumInteritemSpacing(ItemAtIndex: indexPath.item)
        //为item的frame赋新值
        currentItemAttributes.frame = frame
        return currentItemAttributes
    }
    
    //MARK: - System
    
    /** item行间距 **/
    private func evaluatedMinimumInteritemSpacing(ItemAtIndex:Int) -> CGFloat     {
        if let delete = self.collectionView?.delegate {
            weak var delegate = (delete as! UICollectionViewDelegateFlowLayout)
            if delegate!.responds(to: #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:minimumInteritemSpacingForSectionAt:))) {
                let mini = delegate?.collectionView!(self.collectionView!, layout: self, minimumLineSpacingForSectionAt: ItemAtIndex)
                if mini != nil {
                    return mini!
                }
            }
        }
        return self.minimumInteritemSpacing
    }
    
    /** section的偏移量 **/
    private func evaluatedSectionInset(itemAtIndex:Int) -> UIEdgeInsets {
        if let delete = self.collectionView?.delegate {
            weak var delegate = (delete as! UICollectionViewDelegateFlowLayout)
            if delegate!.responds(to: #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:insetForSectionAt:))) {
                let sectionInset = delegate?.collectionView!(self.collectionView!, layout: self, insetForSectionAt: itemAtIndex)
                if sectionInset != nil {
                    return sectionInset!
                }
            }
        }
        return self.sectionInset
    }
}

extension Array where Element:NSCopying{
    ///返回元素支持拷贝数组的深拷贝
    public var copy:[Element]{
        return self.map {$0.copy(with: nil) as! Element}
    }
}
