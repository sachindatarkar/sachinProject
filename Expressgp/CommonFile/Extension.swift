//
//  UIViewExtension.swift
//  Expressgp
//
//  Created by Sachin on 29/04/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
extension UIImageView{
	func setImage(url: URL) {
		self.sd_setImage(with:url) { (image, error, type,_) in
			if (error != nil) {
				// Failed to load image
				//self.image = //Placeholder
                self.image = UIImage(named: "profileIcon")
			} else {
				// Successful in loading image
				self.image = image
			}
		}
	}
}
extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        //gradient.colors = colours.map { $0.cgColor }
       // gradient.locations = locations
        let startColour = UIColor(red:0.26, green:0.79, blue:0.66, alpha:1.0).cgColor
        let midalColour = UIColor(red:0.27, green:0.64, blue:0.64, alpha:1.0).cgColor
        let endColour = UIColor(red:0.27, green:0.55, blue:0.65, alpha:1.0).cgColor
        gradient.colors = [startColour, midalColour,endColour]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIButton {
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        
        self.setAttributedTitle(attributedString, for: .normal)
    }
}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

extension NSObject {
    func GetCommonParrameter() -> [String:Any] {
        var params: [String:Any] = [:]
        params["imei_no"] = ConstantClass.sharedInstance.DEVICE_ID
        params["fcm_id"] = "87499"
        return params
    }
}

extension UIButton{
	func setTitle(_ title: String?){
		self.setTitle(title, for: .normal)
	}
	
	func setTitleAndAttributes(_ title: String?, fontColor: UIColor = UIColor.white){
		self.setTitle(title, for: .normal)
	}
}

extension UIViewController {
	func showAlert(title: String?, message: String?) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
		alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
	
	func setupNavigationBarColor(){
		UIApplication.shared.statusBarView?.backgroundColor = Style.Color.Background.primaryColor
		self.tabBarController?.navigationItem.hidesBackButton = true
		let img = UIImage()
		navigationController?.navigationBar.shadowImage = img
		navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
		navigationController?.navigationBar.backgroundColor = Style.Color.Background.primaryColor
		navigationController?.navigationBar.barTintColor = Style.Color.Background.primaryColor
	}
	
	func setupNavigationBarData(){
		let notifiButton = UIButton(type: .custom)
		notifiButton.setImage(UIImage(named: "notification-icon"), for: .normal)
		let rightButton = UIButton(type: .custom)
		rightButton.setTitleAndAttributes("Personal")
		self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: notifiButton)]
		let leftButton = UIButton(type: .custom)
		leftButton.setTitleAndAttributes("ExpressGP")
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
	}
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
	
}
