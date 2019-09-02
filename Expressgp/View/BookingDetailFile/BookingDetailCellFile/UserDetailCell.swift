//
//  UserDetailCell.swift
//  Expressgp
//
//  Created by Sachin on 30/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class UserDetailCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var relation_lbl: UILabel!
    @IBOutlet weak var problem_lbl: UILabel!
    @IBOutlet weak var age_lbl: UILabel!
    @IBOutlet weak var name_lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.bgView.layer.masksToBounds = false
        self.bgView.layer.cornerRadius = 5.0
        self.bgView.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.bgView.layer.shadowOpacity = 0.3
        
//        bgView.layer.cornerRadius = 5.0
//        bgView.layer.borderWidth = 0.7
//        bgView.layer.borderColor = UIColor.lightGray.cgColor
//        bgView.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        //profileImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
