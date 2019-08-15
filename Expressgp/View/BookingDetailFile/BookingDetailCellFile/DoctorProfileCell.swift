//
//  DoctorProfileCell.swift
//  Expressgp
//
//  Created by Sachin on 28/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class DoctorProfileCell: UITableViewCell {

    @IBOutlet weak var cancel_btn: UIButton!
    @IBOutlet weak var call_btn: UIButton!
    @IBOutlet weak var starRating_lbl: UILabel!
    @IBOutlet weak var speciality_lbl: UILabel!
    @IBOutlet weak var drName: UILabel!
    @IBOutlet weak var drProfileImage: UIImageView!
    @IBOutlet weak var otp_lbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.bgView.layer.masksToBounds = false
        self.bgView.layer.cornerRadius = 5.0
        self.bgView.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.bgView.layer.shadowOpacity = 0.5
//        bgView.layer.borderWidth = 2
//        bgView.layer.borderColor = UIColor.lightGray.cgColor
       
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
