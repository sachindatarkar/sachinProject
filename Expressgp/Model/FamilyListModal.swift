//
//  FamilyListModal.swift
//  Expressgp
//
//  Created by Sachin on 24/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

struct FamilyListModal : Decodable {
    var data : [FamiliListData]?
}

struct FamiliListData : Decodable {
   var  firstname : String?
   var  lastname : String?
   var  email : String?
   var  family_id : String?
   var  profile_pic : String?
   var  phone : String?
   var  illness : String?
   var  allergy : String?
   var  dob : String?
   var  gender : String?
   var  languages : String?
   var  corporate : String?
   var  relation : String?
   var  age : String?
}
