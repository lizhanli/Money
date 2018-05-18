//
//  ExtensionUIDevice.swift
//  YHFUNDS
//
//  Created by 李占理 on 2018/4/4.
//  Copyright © 2018年 YHFund. All rights reserved.
//

import UIKit

extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    public func isIphoneX() -> Bool {
        if modelName == "iPhone10,3" || modelName == "iPhone10,6"{
            return true
        }
        return false
    }
}
