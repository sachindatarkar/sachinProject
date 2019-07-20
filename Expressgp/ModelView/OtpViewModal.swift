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
        apiClient.fetchApiResponse(action: "otp_verify.php", param: params) { (dictionary) in
            do {
                if let status : Int = dictionary?.value(forKey: "success") as? Int{
                    if status == 1 {
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

}
