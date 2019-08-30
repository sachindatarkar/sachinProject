//
//  FindDoctorViewModel.swift
//  Expressgp
//
//  Created by Administrator on 25/08/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import Foundation

final class FindDoctorViewModel: NSObject {
//{"patient_id":"7","user_id":"5","appointment_date":"","appointment_time":"","ill_reason_id":"2","speciality_id":"3","lat":"19.218330","long":"72.978088"}
	var apiClient = ApiClientClass();
    var showErrorMsg : ((String) -> Void)?

	func getDoctorList(bookingObj:BookingListData,userObj:LoginData) {
		var params: [String:Any] = [:]
		params = self.GetCommonParrameter()
		params["patient_id"] = bookingObj.patient_id
		params["user_id"] = userObj.user_id
		params["appointment_date"] = bookingObj.appointment_date
		params["speciality_id"] = userObj.allergy_id
		params["lat"] = bookingObj.latitude
		params["long"] = bookingObj.longitude
		params["appointment_time"] = bookingObj.appointment_time
		params["ill_reason_id"] = userObj.illness_id

		apiClient.fetchApiResponse(action: "booking_request.php", param: params) { (dictionary,data) in
			do {
				if let rstatus : Int = dictionary?.value(forKey: "success") as? Int{
					if rstatus == 1 {
						let listObj = try JSONDecoder().decode(BookingListModal.self, from: data as! Data)
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
