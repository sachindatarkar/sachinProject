//
//  LoginViewModal.swift
//  Expressgp
//
//  Created by Sachin on 15/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class LoginViewModal: NSObject {
    var apiClient = ApiClientClass();
    var pushToHomeView : ((Int) -> Void)?
    
    //MARK:- Check Login Api
    func checkLogin(mobileNo:String)  {
        var params: [String:Any] = [:]
        params = self.GetCommonParrameter()
        params["mobile"] = mobileNo
        
        apiClient.fetchApiResponse(action: "login.php", param: params) { (dictionary,data) in
            do {
                if let otp : Int = dictionary?.value(forKey: "otp") as? Int{
                    if otp != 0 {
                        ConstantClass.sharedInstance.mobileNo = mobileNo
                        let otpStr = dictionary?.value(forKey: "otp")
                        self.pushToHomeView?(otpStr as! Int )
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
                print(error.description)
            }
        }
    }

}
