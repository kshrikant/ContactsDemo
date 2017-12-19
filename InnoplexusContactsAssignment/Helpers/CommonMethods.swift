//
//  CommonMethods.swift
//  InnoplexusContactsAssignment
//
//  Created by Shrikant Kanakatti on 12/18/17.
//  Copyright © 2017 Shrikant Kanakatti. All rights reserved.
//

import UIKit
import SVProgressHUD


typealias anyDict = [String: Any]

class CommonMethods: NSObject {
    
    
    //MARK:-
    //MARK:- SVProgressHUD methods
    
    static func setLoaderStyle() {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setBackgroundColor(UIColor(white: 0, alpha: 0.8))
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.setMinimumDismissTimeInterval(0.3)
    }
    
    static func loaderShow(_ text: String = "Loading contacts...") {
        SVProgressHUD.show(withStatus: text)
    }
    
    static func loaderError(_ text: String = "") {
        CommonMethods.loaderHide()
        SVProgressHUD.showError(withStatus: text)
    }
    
    static func loaderHide() {
        SVProgressHUD.dismiss()
    }

    
}
