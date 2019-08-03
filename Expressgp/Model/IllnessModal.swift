//
//  IllnessModal.swift
//  Expressgp
//
//  Created by Sachin on 18/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

struct IllnessModal : Decodable  {
    var data : [IllnessData]?
}

struct IllnessData :  Decodable {
    var visit_id : String?
    var specialty_id : String?
    var reason : String?
    var isSelected : Bool?
}
