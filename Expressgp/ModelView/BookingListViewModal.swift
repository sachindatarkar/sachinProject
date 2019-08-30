//
//  BookingListViewModal.swift
//  Expressgp
//
//  Created by Sachin on 27/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class BookingListViewModal: NSObject {
    var apiClient = ApiClientClass();
    var reloadTableView: (() -> Void)?
    var bookingListArry : [BookingListData]?
    var historyListArry : [BookingListData]?
    var showErrorMsg : ((String) -> Void)?
    
    func getBookingList(userObj:LoginData,status:String) {
        var params: [String:Any] = [:]
        params = self.GetCommonParrameter()
        params["patient_id"] = userObj.patient_id
        params["user_id"] = userObj.user_id
        params["status"] = status
        apiClient.fetchApiResponse(action: "booking_list.php", param: params) { (dictionary,data) in
            do {
                if let rstatus : Int = dictionary?.value(forKey: "success") as? Int{
                    if rstatus == 1 {
                        let listObj = try JSONDecoder().decode(BookingListModal.self, from: data as! Data)
                        if status == "active" {
                            self.bookingListArry = listObj.data ?? [BookingListData]()
                        }else{
                           self.historyListArry = listObj.data ?? [BookingListData]()
                        }
                        self.reloadTableView?()
                    }else{
                        
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
                print(error.description)
            }
        }
    }
}
