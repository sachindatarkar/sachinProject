//
//  CompanyProfileModal.swift
//  Expressgp
//
//  Created by Sachin on 05/05/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import Foundation

struct CompanyProfileModal : Decodable {
    var firstName:String?
    var lastName : String?
    var mobileNo : String?
    var emailId : String?
    var gender : String?
    var dateOfBirth : String?
    var language : String?
    var existingIllness : String?
    var existingAllergies : String?
    var acceptCondition : Bool = false
}
