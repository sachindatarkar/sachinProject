//
//  BookingDetailViewController.swift
//  Expressgp
//
//  Created by Sachin on 08/05/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class BookingDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var bookingDetailTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        bookingDetailTV.register(UINib(nibName: "BookingDetailDrInfoCell", bundle: nil), forCellReuseIdentifier: "BookingDetailDrInfoCell")
        bookingDetailTV.register(UINib(nibName: "StarRatingCell", bundle: nil), forCellReuseIdentifier: "StarRatingCell")
        bookingDetailTV.register(UINib(nibName: "MaptableCell", bundle: nil), forCellReuseIdentifier: "MaptableCell")
        bookingDetailTV.register(UINib(nibName: "AppoinmentDetailCell", bundle: nil), forCellReuseIdentifier: "AppoinmentDetailCell")
        bookingDetailTV.register(UINib(nibName: "DoctorProfileCell", bundle: nil), forCellReuseIdentifier: "DoctorProfileCell")
        bookingDetailTV.register(UINib(nibName: "ConsulationFeeCell", bundle: nil), forCellReuseIdentifier: "ConsulationFeeCell")
         bookingDetailTV.register(UINib(nibName: "UserDetailCell", bundle: nil), forCellReuseIdentifier: "UserDetailCell")
        
    }
    
    //MARK:- UITAbleView Delegate And DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "MaptableCell") as? MaptableCell
            return cell!
        }else if indexPath.row == 1 {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "DoctorProfileCell") as? DoctorProfileCell
            return cell!
        }else if indexPath.row == 2 {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "AppoinmentDetailCell") as? AppoinmentDetailCell
            return cell!
        }else if indexPath.row == 3 {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "ConsulationFeeCell") as? ConsulationFeeCell
            return cell!
        }else{
            let cell =  tableView.dequeueReusableCell(withIdentifier: "UserDetailCell") as? UserDetailCell
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
            return 171
        }else if indexPath.row == 3 {
            return 80
        }else if indexPath.row == 4 {
            return 100
        }
        return 50
    }
}
