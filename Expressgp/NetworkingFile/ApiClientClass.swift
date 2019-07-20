//
//  ApiClientClass.swift
//  Expressgp
//
//  Created by Sachin on 15/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit
import Alamofire

class ApiClientClass: NSObject {
    func fetchApiResponse(action : String,param : [String:Any], completion: @escaping (NSDictionary?) -> ()) {
        //requestParameter(params: param)
        let completeURL = "\(ConstantClass.sharedInstance.SITE_URL)\(action)"
        print("URL\(completeURL)")
        print("Param\(param)")
        let headers = [
            "Content-Type":"application/json",
            "Pass" : "ff0984b8372fc580745bb5e725894b9e=",
            "Id" : "expressapp"
        ]
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        Alamofire.request(completeURL, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if let JSON = response.result.value as? NSDictionary {
                let responseString = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)
                print("responseString = \(String(describing: responseString))\n***************")
                completion(response.result.value as? NSDictionary)
                print("JSON: \(JSON)") // your JSONResponse result
            }
            else {
                print(response.result.error!)
            }
        }
    }
    
    func fetchApiForGet(action : String, completion: @escaping (NSDictionary?,Data) -> ()) {
        let completeURL = "\(ConstantClass.sharedInstance.SITE_URL)\(action)"
        print("URL\(completeURL)")
        let headers = [
            "Content-Type":"application/json",
            "Pass" : "ff0984b8372fc580745bb5e725894b9e=",
            "Id" : "expressapp"
        ]
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        Alamofire.request(completeURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if let JSON = response.result.value as? NSDictionary {
                let responseString = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)
                print("responseString = \(String(describing: responseString))\n***************")
                completion(response.result.value as? NSDictionary,response.data ?? Data())
                print("JSON: \(JSON)") // your JSONResponse result
            }
            else {
                print(response.result.error!)
            }
        }
    }
}
