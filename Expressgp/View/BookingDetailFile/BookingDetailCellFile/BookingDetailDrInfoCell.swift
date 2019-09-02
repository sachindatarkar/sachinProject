//
//  BookingDetailDrInfoCell.swift
//  Expressgp
//
//  Created by Sachin on 10/05/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class BookingDetailDrInfoCell: UITableViewCell {

    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var location_lbl: UILabel!
    @IBOutlet weak var paymentType_lbl: UILabel!
    @IBOutlet weak var grandTotal_lbl: UILabel!
    @IBOutlet weak var bookingId_lbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.masksToBounds = false
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.contentView.layer.shadowOpacity = 0.3
//        bgView.layer.cornerRadius = 5.0
//        bgView.layer.borderWidth = 0.7
//        bgView.layer.borderColor = UIColor.lightGray.cgColor
//        bgView.layer.masksToBounds = true
        
        dotView.layer.cornerRadius = dotView.frame.size.width / 2
        dotView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
