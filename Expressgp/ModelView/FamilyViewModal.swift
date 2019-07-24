//
//  FamilyViewModal.swift
//  Expressgp
//
//  Created by Sachin on 24/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class FamilyViewModal: NSObject {
    var apiClient = ApiClientClass();
    var reloadCollectionView: (() -> Void)?
    var familyListArry : [FamiliListData]?
    
    func getFamilyList(userObj:LoginData)  {
        var params: [String:Any] = [:]
        params = self.GetCommonParrameter()
        params["patient_id"] = userObj.patient_id
        params["user_id"] = userObj.user_id
        apiClient.fetchApiResponse(action: "family_list.php", param: params) { (dictionary,data) in
            do {
                if let status : Int = dictionary?.value(forKey: "success") as? Int{
                    if status == 1 {
                        let listObj = try JSONDecoder().decode(FamilyListModal.self, from: data as! Data)
                        self.familyListArry = listObj.data ?? [FamiliListData]()
                        self.reloadCollectionView?()
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
                print(error.description)
            }
        }
    }
    
}
