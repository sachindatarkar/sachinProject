//
//  FirstNameLastNameCell.swift
//  Expressgp
//
//  Created by Sachin on 05/05/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class FirstNameLastNameCell: UITableViewCell {

    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
