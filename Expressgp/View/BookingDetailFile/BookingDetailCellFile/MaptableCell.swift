//
//  MaptableCell.swift
//  Expressgp
//
//  Created by Sachin on 28/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit
import GoogleMaps

class MaptableCell: UITableViewCell {
    @IBOutlet weak var mapView: GMSMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
