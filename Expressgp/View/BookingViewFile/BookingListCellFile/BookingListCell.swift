//
//  BookingListCell.swift
//  Expressgp
//
//  Created by Sachin on 08/05/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class BookingListCell: UITableViewCell {

    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var date_lbl: UILabel!
    @IBOutlet weak var drProfileImage: UIImageView!
    @IBOutlet weak var distance_lbl: UILabel!
    @IBOutlet weak var rating_lbl: UILabel!
    @IBOutlet weak var specialty_lbl: UILabel!
    @IBOutlet weak var drName_lbl: UILabel!
    @IBOutlet weak var status_lbl: UIButton!
    @IBOutlet weak var address_lbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //bgView.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        self.contentView.layer.masksToBounds = false
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.contentView.layer.shadowOpacity = 0.3
        bgView.layer.cornerRadius = 5.0
        bgView.layer.masksToBounds = true
        drProfileImage.layer.cornerRadius = drProfileImage.frame.size.width / 2
        drProfileImage.layer.masksToBounds = true
        status_lbl.layer.cornerRadius = 12
        status_lbl.layer.masksToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
