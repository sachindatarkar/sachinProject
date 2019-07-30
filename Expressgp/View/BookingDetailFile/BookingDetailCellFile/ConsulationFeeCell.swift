//
//  ConsulationFeeCell.swift
//  Expressgp
//
//  Created by Sachin on 30/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class ConsulationFeeCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.contentView.layer.masksToBounds = false
//        self.contentView.layer.cornerRadius = 5.0
//        self.contentView.layer.shadowOffset = CGSize(width: -1, height: 1)
//        self.contentView.layer.shadowOpacity = 0.5
        bgView.layer.borderWidth = 1.5
        bgView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
