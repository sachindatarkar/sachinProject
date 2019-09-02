//
//  BookingDetailViewModal.swift
//  Expressgp
//
//  Created by Sachin on 01/08/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class BookingDetailViewModal: NSObject {
    var apiClient = ApiClientClass();
    var reloadTableView: (() -> Void)?
    var bookingDetailObj : BookingDetailData?
    var showErrorMsg : ((String) -> Void)?
    
    func getBookingList(userObj:LoginData,bookingId:String) {
        var params: [String:Any] = [:]
        params = self.GetCommonParrameter()
        params["booking_id"] = bookingId
        params["user_id"] = userObj.user_id
        apiClient.fetchApiResponse(action: "booking_details.php", param: params) { (dictionary,data) in
            do {
                if let rstatus : Int = dictionary?.value(forKey: "success") as? Int{
                    if rstatus == 1 {
                        let listObj = try JSONDecoder().decode(BookingDetailModal.self, from: data as! Data)
                        self.bookingDetailObj = listObj.data?[0]
                        self.reloadTableView?()
                    }else{
                        let str = dictionary?.value(forKey: "message")
                        if str != nil {
                            self.showErrorMsg?(str as! String)
                        }else{
                            self.showErrorMsg?("Something wrong!!!!")
                        }
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
                print(error.description)
            }
        }
    }
    
    func getBookingCancel(userObj:LoginData,bookingId:String) {
        var params: [String:Any] = [:]
        params = self.GetCommonParrameter()
        params["booking_request_id"] = bookingId
        params["user_id"] = userObj.user_id
        apiClient.fetchApiResponse(action: "booking_cancel.php", param: params) { (dictionary,data) in
            do {
                if let rstatus : Int = dictionary?.value(forKey: "success") as? Int{
                    if rstatus == 1 {
                        let listObj = try JSONDecoder().decode(BookingDetailModal.self, from: data as! Data)
                        self.bookingDetailObj = listObj.data?[0]
                        self.reloadTableView?()
                    }else{
                        let str = dictionary?.value(forKey: "message")
                        if str != nil {
                            self.showErrorMsg?(str as! String)
                        }else{
                            self.showErrorMsg?("Something wrong!!!!")
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
