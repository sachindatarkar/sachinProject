//
//  OtpViewModal.swift
//  Expressgp
//
//  Created by Sachin on 15/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class OtpViewModal: NSObject {
    var apiClient = ApiClientClass();
    var pushToHomeView : (() -> Void)?
    var pushToRegistartion : (() -> Void)?

    //MARK:- Check Login Api
    func checkOtp(otpText:Int)  {
        var params: [String:Any] = [:]
        params = self.GetCommonParrameter()
        params["mobile"] = ConstantClass.sharedInstance.mobileNo
        params["otp"] = otpText
        apiClient.fetchApiResponse(action: "otp_verify.php", param: params) { (dictionary,data) in
            do {
                if let status : Int = dictionary?.value(forKey: "success") as? Int{
                    if status == 1 {
                        UserDefaults.standard.setValue(data, forKey: "UserResponse")
                        self.pushToHomeView?()
                    }else if status == 2 {
                        self.pushToRegistartion?()
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
                print(error.description)
            }
        }
    }
    
   /* func checkLogin(mobileNo:String)  {
        var params: [String:Any] = [:]
        params = self.GetCommonParrameter()
        params["mobile"] = ConstantClass.sharedInstance.mobileNo
        apiClient.fetchApiResponse(action: "login.php", param: params) { (dictionary,data) in
            do {
                if let otp : Int = dictionary?.value(forKey: "otp") as? Int{
                    if otp != 0 {
                        ConstantClass.sharedInstance.mobileNo = mobileNo
                      
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
                print(error.description)
            }
        }
    }*/

}
