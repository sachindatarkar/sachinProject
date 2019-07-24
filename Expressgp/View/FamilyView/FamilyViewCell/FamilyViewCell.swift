//
//  FamilyViewCell.swift
//  Expressgp
//
//  Created by Sachin on 24/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class FamilyViewCell: UICollectionViewCell {

    @IBOutlet weak var relation_lbl: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var name_lbl: UILabel!
    @IBOutlet weak var delete_btn: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // corner radius
        contentView.layer.cornerRadius = 10
        
        // border
        contentView.layer.borderWidth = 2.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        // shadow
        
    }

}
