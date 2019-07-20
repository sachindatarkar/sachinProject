//
//  LanguageSearchModal.swift
//  Expressgp
//
//  Created by Sachin on 18/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class LanguageSearchViweModal: NSObject {
    var apiClient = ApiClientClass();
    var tableReload : (() -> Void)?
    var languageArry : [LanguageData]?
    var illnessArry : [IllnessData]?
    var allengiArry : [AllergiesData]?
    
    func getsearchList(type:String)  {
        apiClient.fetchApiForGet(action: type) { (dictionary,data) in
            do {
                if let status : Int = dictionary?.value(forKey: "success") as? Int{
                    if status == 1 {
                        do {
                            if type == "language_mst.php" {
                            let json = try JSONDecoder().decode(LanguageModal.self, from: data)
                             self.languageArry = json.data
                            }else if type == "health_concern_mst.php" {
                             let json = try JSONDecoder().decode(IllnessModal.self, from: data)
                                self.illnessArry = json.data
                            }else if type == "allergy_master.php" {
                                 let json = try JSONDecoder().decode(AllergiesModal.self, from: data)
                                self.allengiArry = json.data
                            }
                            self.tableReload?()
                            
                        } catch let error as NSError {
                            print(error.localizedDescription)
                            print(error.description)
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
