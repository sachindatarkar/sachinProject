//
//  UserDetailCell.swift
//  Expressgp
//
//  Created by Sachin on 30/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class UserDetailCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var relation_lbl: UILabel!
    @IBOutlet weak var problem_lbl: UILabel!
    @IBOutlet weak var age_lbl: UILabel!
    @IBOutlet weak var name_lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.masksToBounds = false
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.contentView.layer.shadowOpacity = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
