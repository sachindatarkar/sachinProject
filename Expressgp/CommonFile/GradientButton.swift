//
//  GradientButton.swift
//  Expressgp
//
//  Created by Shital Sharma on 30/05/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class GradientButton: UIButton {
    let gradientLayer = CAGradientLayer()
    
    @IBInspectable
    var topGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    @IBInspectable
    var bottomGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    private func setGradient(topGradientColor: UIColor?, bottomGradientColor: UIColor?) {
        if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor {
            gradientLayer.frame = bounds
            gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayer.borderColor = layer.borderColor
            gradientLayer.borderWidth = layer.borderWidth
            gradientLayer.cornerRadius = layer.cornerRadius
            gradientLayer.startPoint = CGPoint(x: 0.75, y: 0.75)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.locations = [0.0,0.5, 1.0]
            layer.insertSublayer(gradientLayer, at: 0)
        } else {
            gradientLayer.removeFromSuperlayer()
        }
    }
}
