//
//  AddMemberViewModal.swift
//  Expressgp
//
//  Created by Sachin on 27/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class AddMemberViewModal: NSObject {
    var apiClient = ApiClientClass();
    var addFamilySuccess: (() -> Void)?
    var showErrorMsg : ((String) -> Void)?
    
    func addFamilyMember(userObj:CompanyProfileModal,userData:LoginData,singleFamilyObj : FamiliListData,isedit:Bool)  {
        var params: [String:Any] = [:]
        params = self.GetCommonParrameter()
        var action = ""
        if isedit {
          action = "edit_family.php"
          params["family_id"] = singleFamilyObj.family_id
        }else{
          action = "add_family.php"
          params["user_id"] = userData.user_id
        }
        params["patient_id"] = userData.patient_id
        params["firstname"] = userObj.firstName
        params["lastname"] = userObj.lastName
        params["gender"] = userObj.gender
        params["dob"] = userObj.dateOfBirth
        params["illness"] = userObj.existingIllness
        params["allergy"] = userObj.existingAllergies
        params["language"] = userObj.language_id
        params["relation"] = userObj.relation
        params["profile_img"] = ""
        apiClient.fetchApiResponse(action: action, param: params) { (dictionary,data) in
            do {
                if let status : Int = dictionary?.value(forKey: "success") as? Int{
                    if status == 1 {
                        self.addFamilySuccess?()
                    }else{
                        let str = dictionary?.value(forKey: "message")
                        if str != nil {
                            self.showErrorMsg?(str as! String)
                        }else{
                            self.showErrorMsg?("Something wrong!!!!")
                        }
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
                print(error.description)
            }
        }
    }
}
