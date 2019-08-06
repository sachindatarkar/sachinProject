//
//  BookingDetailViewController.swift
//  Expressgp
//
//  Created by Sachin on 08/05/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit
import GoogleMaps


class BookingDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var bookingDetailTV: UITableView!
    var bookingId:String?
    
    var bookingDetailViewObj = BookingDetailViewModal()
    var loginModalObj : LoginData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookingDetailTV.estimatedRowHeight = 88.0
        self.bookingDetailTV.rowHeight = UITableView.automaticDimension
        bookingDetailTV.register(UINib(nibName: "BookingDetailDrInfoCell", bundle: nil), forCellReuseIdentifier: "BookingDetailDrInfoCell")
        bookingDetailTV.register(UINib(nibName: "StarRatingCell", bundle: nil), forCellReuseIdentifier: "StarRatingCell")
        bookingDetailTV.register(UINib(nibName: "MaptableCell", bundle: nil), forCellReuseIdentifier: "MaptableCell")
        bookingDetailTV.register(UINib(nibName: "AppoinmentDetailCell", bundle: nil), forCellReuseIdentifier: "AppoinmentDetailCell")
        bookingDetailTV.register(UINib(nibName: "DoctorProfileCell", bundle: nil), forCellReuseIdentifier: "DoctorProfileCell")
        bookingDetailTV.register(UINib(nibName: "ConsulationFeeCell", bundle: nil), forCellReuseIdentifier: "ConsulationFeeCell")
         bookingDetailTV.register(UINib(nibName: "UserDetailCell", bundle: nil), forCellReuseIdentifier: "UserDetailCell")
        
        if let loginData = UserDefaults.standard.value(forKey: "UserResponse") {
            do {
                let loginObj = try JSONDecoder().decode(LoginModal.self, from: loginData as! Data)
                self.loginModalObj = loginObj.data?[0]
                self.bookingDetailViewObj.getBookingList(userObj: self.loginModalObj ?? LoginData(), bookingId: bookingId ?? "")
            } catch let error as NSError {
                print(error.localizedDescription)
                print(error.description)
            }
        }
        
        bookingDetailViewObj.reloadTableView = {
            self.bookingDetailTV.reloadData()
        }
        
    }
    
    //MARK:- UITAbleView Delegate And DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.bookingDetailViewObj.bookingDetailObj != nil {
            return 5
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "MaptableCell") as? MaptableCell
            let latitude : Double = Double(self.bookingDetailViewObj.bookingDetailObj?.p_latitude ?? "0.0") ?? 0.0
            let longitude : Double = Double(self.bookingDetailViewObj.bookingDetailObj?.p_longitude ?? "0.0") ?? 0.0
            let sydney = GMSCameraPosition.camera(withLatitude: latitude,
                                                  longitude: longitude,
                                                  zoom: 6)
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            cell?.mapView.camera = sydney
            marker.map = cell?.mapView
            cell?.selectionStyle = .none
            return cell!
        }else if indexPath.row == 1 {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "DoctorProfileCell") as? DoctorProfileCell
            cell?.drName.text = self.bookingDetailViewObj.bookingDetailObj?.doctor_name
            cell?.speciality_lbl.text = self.bookingDetailViewObj.bookingDetailObj?.specialty_name
            cell?.otp_lbl.text = "Otp : \(self.bookingDetailViewObj.bookingDetailObj?.otp ?? "")"
            cell?.selectionStyle = .none
            return cell!
        }else if indexPath.row == 2 {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "AppoinmentDetailCell") as? AppoinmentDetailCell
            cell?.bookingId.text = self.bookingDetailViewObj.bookingDetailObj?.booking_no
            cell?.address_lbl.text = self.bookingDetailViewObj.bookingDetailObj?.booking_address
            cell?.distance_lbl.text = "\(self.bookingDetailViewObj.bookingDetailObj?.distance ?? "") Km"
            cell?.expectedTime_lbl.text = self.bookingDetailViewObj.bookingDetailObj?.appointment_time
            cell?.selectionStyle = .none
            return cell!
        }else if indexPath.row == 3 {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "ConsulationFeeCell") as? ConsulationFeeCell
            cell?.consulation_lbl.text = self.bookingDetailViewObj.bookingDetailObj?.amount
            cell?.paymentType_lbl.text = self.bookingDetailViewObj.bookingDetailObj?.payment_type
            cell?.selectionStyle = .none
            return cell!
        }else{
            let cell =  tableView.dequeueReusableCell(withIdentifier: "UserDetailCell") as? UserDetailCell
            cell?.name_lbl.text = self.bookingDetailViewObj.bookingDetailObj?.patient_name
            cell?.age_lbl.text = "\(self.bookingDetailViewObj.bookingDetailObj?.age ?? "") Yrs"
            cell?.problem_lbl.text = self.bookingDetailViewObj.bookingDetailObj?.reason
            cell?.relation_lbl.text = self.bookingDetailViewObj.bookingDetailObj?.relation
            cell?.selectionStyle = .none
            return cell!
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0  {
            return 250
        }else if indexPath.row == 1{
            return 167
        }else if indexPath.row == 2  {
            return UITableView.automaticDimension
        }else if indexPath.row == 3 {
            return 80
        }else if indexPath.row == 4 {
            return UITableView.automaticDimension
        }
        return 50
    }
}
