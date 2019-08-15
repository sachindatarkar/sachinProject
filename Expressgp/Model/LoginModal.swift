//
//  LoginModal.swift
//  Expressgp
//
//  Created by Sachin on 24/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

struct LoginModal : Decodable {
   var message : String?
   var success : Int?
   var user_exist : Int?
    var data : [LoginData]?
}

struct LoginData : Decodable {
   var firstname : String?
   var  lastname : String?
   var  user_id : String?
   var  email : String?
   var  patient_id : String?
   var  profile_pic : String?
   var  phone : String?
   var  dob : String?
   var  gender : String?
   var  languages : String?
   var  illness_id : String?
   var  allergy_id : String?
   var  illness : String?
   var  allergy : String?
   var  corporate : String?
   var  insurance_file : String?
   var  age : String?
}
