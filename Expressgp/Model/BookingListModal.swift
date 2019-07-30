//
//  BookingListModal.swift
//  Expressgp
//
//  Created by Sachin on 28/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit



struct BookingListModal : Decodable {
    var data : [BookingListData]?
}

struct BookingListData : Decodable {
    var patient_name : String?
    var relation : String?
    var p_profile_pic : String?
    var d_profile_pic : String?
    var booking_id : String?
    var booking_no : String?
    var otp : String?
    var arrival_time : String?
    var latitude : String?
    var longitude : String?
    var booking_address : String?
    var p_address : String?
    var booking_status : String?
    var do_payment : String?
    var patient_id : String?
    var appointment_date : String?
    var appointment_time : String?
    var start_time : String?
    var end_time : String?
    var paid : String?
    var doctor_id : String?
    var distance : String?
    var rating : String?
    var amount : String?
    var doctor_name : String?
    var doctor_latitude : String?
    var doctor_longitude : String?
    var specialty_name : String?
    var reason : String?
    var payment_type : String?
    var age : String?
    var completed_on : String?
    var type : String?
}
