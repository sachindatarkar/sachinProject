//
//  LanguageModal.swift
//  Expressgp
//
//  Created by Sachin on 18/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

struct LanguageModal : Decodable  {
    var data : [LanguageData]?
}

struct LanguageData :  Decodable {
    var language_id :  String?
    var language_name : String?
    var isSelected : Bool?
}
