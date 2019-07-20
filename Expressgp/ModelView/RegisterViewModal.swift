//
//  RegisterViewModal.swift
//  Expressgp
//
//  Created by Sachin on 16/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class RegisterViewModal: NSObject {
    var apiClient = ApiClientClass();
    var pushToHomeView : (() -> Void)?
    func registerUser(userObj:CompanyProfileModal)  {
        var params: [String:Any] = [:]
        params = self.GetCommonParrameter()
        params["mobile"] = ConstantClass.sharedInstance.mobileNo
        params["firstname"] = userObj.firstName
        params["lastname"] = userObj.lastName
        params["email"] = userObj.emailId
        params["gender"] = userObj.gender
        params["dob"] = userObj.dateOfBirth
        params["illness"] = userObj.existingIllness
        params["illness_id"] = userObj.Illness_id
        params["allergy"] = userObj.existingAllergies
        params["allergy_id"] = userObj.allergies_id
        params["insurance"] = ""
        
        apiClient.fetchApiResponse(action: "signup.php", param: params) { (dictionary) in
            do {
                if let status : Int = dictionary?.value(forKey: "success") as? Int{
                    if status == 1 {
                        UserDefaults.standard.setValue(dictionary, forKey: "UserResponse")
                        self.pushToHomeView?()
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
                print(error.description)
            }
        }
    }
    
    
}
