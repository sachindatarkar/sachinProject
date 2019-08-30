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
    var showErrorMsg : ((String) -> Void)?
    var updateTimer : (() -> Void)?

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
                    }else{
                        let msg = dictionary?["message"] as? String
                        self.showErrorMsg?(msg!)
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
                print(error.description)
            }
        }
    }
    
    func resendOtp()  {
        var params: [String:Any] = [:]
        params = self.GetCommonParrameter()
        params["mobile"] = ConstantClass.sharedInstance.mobileNo
        apiClient.fetchApiResponse(action: "resend_otp.php", param: params) { (dictionary,data) in
            do {
                if let otp : Int = dictionary?.value(forKey: "otp") as? Int{
                    if otp != 0 {
                      self.updateTimer?()
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
                print(error.description)
            }
        }
    }

}
