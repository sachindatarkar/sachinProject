//
//  GenderCell.swift
//  Expressgp
//
//  Created by Sachin on 05/05/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit


class GenderCell: UITableViewCell {

    @IBOutlet weak var womenImageView: UIImageView!
    @IBOutlet weak var menImageView: UIImageView!
    @IBOutlet weak var btn_women: UIButton!
    @IBOutlet weak var btn_men: UIButton!
    var registerVc : RegisterViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // btn_women.addTarget(self, action: #selector(OnClickWomen), for: .touchUpInside)
       // btn_women.addTarget(self, action: #selector(OnClickMen), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    @objc func OnClickWomen() {
//        var genderStr : String = ""
//        if womenImageView.image?.isEqual(UIImage(named: "optionSelect.png")) ?? false {
//            womenImageView.image = UIImage(named: "optionUnselect.png")
//            menImageView.image = UIImage(named: "optionSelect.png")
//            genderStr = "Men"
//        }else{
//            womenImageView.image = UIImage(named: "optionSelect.png")
//            menImageView.image = UIImage(named: "optionUnselect.png")
//            genderStr = "Women"
//        }
//        registerVc?.tableReloadWithgender(gender:genderStr)
//    }
//
//    @objc func OnClickMen() {
//         var genderStr : String = ""
//        if womenImageView.image?.isEqual(UIImage(named: "optionSelect.png")) ?? false {
//            womenImageView.image = UIImage(named: "optionUnselect.png")
//            menImageView.image = UIImage(named: "optionSelect.png")
//            genderStr = "Men"
//        }else{
//            womenImageView.image = UIImage(named: "optionSelect.png")
//            menImageView.image = UIImage(named: "optionUnselect.png")
//            genderStr = "Women"
//        }
//        registerVc?.tableReloadWithgender(gender:genderStr)
//    }
}
