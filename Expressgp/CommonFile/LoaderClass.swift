//
//  LoaderClass.swift
//  Expressgp
//
//  Created by Sachin on 04/08/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//


import UIKit

import Foundation
import UIKit

public class LoadingOverlay{
    
    var transperantView = UIView()
    var overlayView = UIView()
    var  activityIndicator = UIActivityIndicatorView()
    
    var loaderImage = UIImageView()
    
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    
    
    public func showLoaderView(view: UIView) {
        if  let appDelegate =  UIApplication.shared.delegate as? AppDelegate,
            let window = appDelegate.window {
            
            transperantView.frame = CGRect(x: 0, y: 0, width: window.bounds.width, height:  window.bounds.height)
            transperantView.backgroundColor = UIColor(red:0.09, green:0.157, blue:0.2, alpha:0.75)
            window.addSubview(transperantView)
            
            overlayView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            overlayView.center = CGPoint(x:  window.frame.width / 2.0, y: window.frame.height / 2.0)
            overlayView.backgroundColor = UIColor.white
            overlayView.clipsToBounds = true
            overlayView.layer.cornerRadius = 10
            
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            activityIndicator.style = .gray
            activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
            
            overlayView.addSubview(activityIndicator)
            transperantView.addSubview(overlayView)
            
            activityIndicator.startAnimating()
        }
    }
    
    public func hideLoaderView() {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.transperantView.removeFromSuperview()
                self.loaderImage.removeFromSuperview()
                self.activityIndicator.stopAnimating()
                self.overlayView.removeFromSuperview()
            }
        }
        
    }
}

//struct ScreenSize
//{
//    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
//    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
//    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
//    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
//}
//
//struct DeviceType
//{
//    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
//    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
//    static let IS_IPHONE_6_7          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
//    static let IS_IPHONE_6P_7P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
//    static let IS_IPHONE_X       = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
//    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
//    static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
//}

//MARK:- UIColor
extension UIColor {
    public static func colorFromCode(_ code: Int) -> UIColor {
        let red = CGFloat(((code & 0xFF0000) >> 16)) / 255
        let green = CGFloat(((code & 0xFF00) >> 8)) / 255
        let blue = CGFloat((code & 0xFF)) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
