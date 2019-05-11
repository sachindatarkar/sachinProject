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
    }
    
    //MARK:- UITAbleView Delegate And DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "BookingDetailDrInfoCell") as? BookingDetailDrInfoCell
            return cell!
        }else{
            let cell =  tableView.dequeueReusableCell(withIdentifier: "StarRatingCell") as? StarRatingCell
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0  {
            return 325
        }else{
            return 115
        }
    }
}
