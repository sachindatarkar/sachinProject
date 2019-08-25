//
//  Extension.swift
//  Expressgp
//
//  Created by Administrator on 24/08/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import Foundation
import UIKit


public func getUserData(completionHandler:(_ result:LoginData?, _ error: Error?) -> Void){
	if let loginData = UserDefaults.standard.value(forKey: "UserResponse") {
		do {
			 let loginObj = try JSONDecoder().decode(LoginModal.self, from: loginData as! Data)
			if let data = loginObj.data?.first {
				completionHandler(data, nil)

			}
		
		} catch let error as NSError {
			completionHandler(nil, error)

		}
	}
}
