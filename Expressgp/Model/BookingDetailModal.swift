//
//  BookingDetailModal.swift
//  Expressgp
//
//  Created by Sachin on 01/08/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

struct BookingDetailModal : Decodable {
    var data :[BookingDetailData]?
}

struct BookingDetailData:Decodable {
    var age : String?
    var amount : String?
    var appointment_date : String?
    var appointment_time : String?
    var arrival_time : String?
    var b_status : String?
    var booking_address : String?
    var booking_id : String?
    var booking_no : String?
    var booking_status : String?
    var completed_on : String?
    var d_latitude : String?
    var d_longitude : String?
    var d_profile_pic : String?
    var distance : String?
    var do_payment : String?
    var doc_contact : String?
    var doc_gender : String?
    var doctor_id : String?
    var doctor_latitude : String?
    var doctor_longitude : String?
    var doctor_name : String?
    var end_time : String?
    var otp : String?
    var p_address : String?
    var p_gender : String?
    var p_latitude : String?
    var p_longitude : String?
    var p_profile_pic : String?
    var paid : String?
    var patient_id : String?
    var patient_name : String?
    var payment_type : String?
    var rating : String?
    var reason : String?
    var relation : String?
    var specialty_name : String?
    var start_time : String?
    var type : String?
}
