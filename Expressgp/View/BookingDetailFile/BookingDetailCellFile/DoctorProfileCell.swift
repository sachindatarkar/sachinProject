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
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        call_btn.tintColor = UIColor.white
        call_btn.applyGradient(colours: [UIColor.white])
        call_btn.layer.cornerRadius = 18
        call_btn.layer.masksToBounds = true
        call_btn.frame = call_btn.bounds
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.bgView.layer.masksToBounds = false
        self.bgView.layer.cornerRadius = 5.0
        self.bgView.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.bgView.layer.shadowOpacity = 0.3
//        bgView.layer.borderWidth = 2
//        bgView.layer.borderColor = UIColor.lightGray.cgColor
//        bgView.layer.cornerRadius = 5.0
//        bgView.layer.borderWidth = 0.7
//        bgView.layer.borderColor = UIColor.lightGray.cgColor
//        bgView.layer.masksToBounds = true
        otp_lbl.layer.cornerRadius = 10
        otp_lbl.layer.masksToBounds = true
        cancel_btn.layer.cornerRadius = 18
        
        
        
        
        drProfileImage.layer.cornerRadius = drProfileImage.frame.size.width/2
        drProfileImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
