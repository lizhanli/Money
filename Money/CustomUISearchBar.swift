
import UIKit

class CustomUISearchBar: UISearchBar, UITextFieldDelegate {

    // icon与textField间距
    fileprivate let iconSpacing: CGFloat = 5
    // icon宽度
    fileprivate let searchIconW: CGFloat = 20
    // 默认系统占位文字的字体大小 用于设置间距
    fileprivate let placeHolderFont: CGFloat = 15

    //可以通过微调 40 宽度，来判断是否居中（可能存在适配的问题）
    var placeholderWidth: CGFloat {
        if let str = self.placeholder {
            let size = CGSize(width: CGFloat.greatestFiniteMagnitude,height: self.frame.size.height)
            let placeHolderW = (str as NSString).boundingRect(with: size, options: NSStringDrawingOptions.usesFontLeading, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: placeHolderFont)], context: nil).size.width
            return placeHolderW + iconSpacing + searchIconW + 40
        }
        return 0
    }
    var textField: UITextField {
        return self.value(forKey: "_searchField") as! UITextField
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //在此处获取不到 UITextField
        clearBackgroundColor()
        self.backgroundColor = UIColor(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1)
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.searchBarStyle = .default
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textField.backgroundColor = UIColor.clear
        textField.borderStyle = .none
        textField.layer.cornerRadius = 5
        textField.clipsToBounds = true

        setPositionAdjustment()
        
    }
    
    //MARK: -设置在iOS11.0上placeholder居中显示
    fileprivate func setPositionAdjustment() {
        if #available(iOS 11.0, *) {
            //设置Icon 与 textField 的间距
            self.searchTextPositionAdjustment = UIOffsetMake(iconSpacing, 0)
        self.setPositionAdjustment(UIOffsetMake((textField.frame.size.width - self.placeholderWidth) / 2, 0), for: UISearchBarIcon.search)
        }
    }
    
    //MARK: -清空textField背景色
    fileprivate func clearBackgroundColor() {
        self.subviews.forEach { (view) in
            if view.isKind(of: UIView.self) {
                view.subviews.first?.removeFromSuperview()
            }
        }
    }
    
    //MARK: -UITextFieldDelegate
    //开始编辑的时候重置为靠左
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if self.delegate?.responds(to: #selector(self.delegate?.searchBarShouldBeginEditing(_:))) != nil {
            _ = self.delegate?.searchBarShouldBeginEditing!(self)
        }
        if #available(iOS 11.0, *) {
            self.setPositionAdjustment(UIOffset.zero, for: UISearchBarIcon.search)
        }
        return true
    }
    
    // 结束编辑的时候设置为居中
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if self.delegate?.responds(to: #selector(self.delegate?.searchBarShouldEndEditing(_:))) != nil {
            _ = self.delegate?.searchBarShouldEndEditing!(self)
        }
        // 没输入文字时占位符居中
        if textField.text?.count == 0 {
            setPositionAdjustment()
        }
        return true
    }
}
