//
//  AllergiesModal.swift
//  Expressgp
//
//  Created by Sachin on 18/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit


struct AllergiesModal : Decodable  {
    var data : [AllergiesData]?
}

struct AllergiesData :  Decodable {
    var allergy_id : String?
    var allergy : String?
    var isSelected : Bool?
}
