//
//  ConstantFile.swift
//  Expressgp
//
//  Created by Sachin on 15/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class ConstantClass: NSObject {
    
    let DEVICE_ID: String = (UIDevice.current.identifierForVendor?.uuidString)!
    let DEVICE_TYPE: String = "ios"
    var DEVICE_TOKEN:String = ""
    let ISGZIPPED:String = "yes"
    var LANGUAGE: String = "en"
    let APP_VERSION:String = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!
    var SITE_URL : String = "https://www.expressgp.com/eapi/"
    var apiTocken : String = ""
    var mobileNo : String = ""
    
    
    //action=login&ur=v3alpha&ps=alphav3otrams45&device="
    //http://alpha.aosconnect.com/ws/logistics_admin.php?action=checkLogin&device=25235235245234&token=
    
    override init() {
        super.init()
        
    }
    
    class var sharedInstance: ConstantClass {
        struct Singleton {
            static let instance = ConstantClass()
        }
        return Singleton.instance
    }

}
