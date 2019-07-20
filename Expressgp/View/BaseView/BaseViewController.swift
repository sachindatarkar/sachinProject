//
//  BaseViewController.swift
//  Expressgp
//
//  Created by Shital Sharma on 05/05/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit
import MapKit
class BaseViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let userDict = UserDefaults.standard.value(forKey: "UserResponse")
        print(userDict)
    }

 

}
