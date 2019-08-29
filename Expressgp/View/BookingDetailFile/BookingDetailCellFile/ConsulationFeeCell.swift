//
//  ConsulationFeeCell.swift
//  Expressgp
//
//  Created by Sachin on 30/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class ConsulationFeeCell: UITableViewCell {

    @IBOutlet weak var paymentType_lbl: UILabel!
    @IBOutlet weak var consulation_lbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.bgView.layer.masksToBounds = false
//        self.bgView.layer.cornerRadius = 5.0
//        self.bgView.layer.shadowOffset = CGSize(width: -1, height: 1)
//        self.bgView.layer.shadowOpacity = 0.5
        
        bgView.layer.cornerRadius = 5.0
        bgView.layer.borderWidth = 0.7
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.layer.masksToBounds = true
//        bgView.layer.borderWidth = 1.5
//        bgView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
