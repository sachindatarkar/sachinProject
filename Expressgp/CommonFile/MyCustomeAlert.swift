//
//  MyCustomeAlert.swift
//  Expressgp
//
//  Created by Sachin on 29/04/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import Foundation
import UIKit

class MyCustomAlert:NSObject{
    var objAlertController:UIAlertController?
    var vcController:UIViewController?
    
    
    override init() {
        super.init()
    }
    class var sharedInstance: MyCustomAlert {
        struct Singleton {
            static let instance = MyCustomAlert()
        }
        return Singleton.instance
    }
    func ShowAlert(vc:UIViewController, myTitle:String, myMessage:String){
        vcController = vc;
        objAlertController = UIAlertController(title: myTitle, message: myMessage, preferredStyle: UIAlertController.Style.alert)
        let objAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        objAlertController!.addAction(objAction)
        //vc.present(self.objAlertController!, animated: true, completion: nil)
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert;
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(objAlertController!, animated: true, completion: nil)
        
        
        
    }
    func ShowAlertDismiss(vc:UIViewController, myTitle:String, myMessage:String){
        vcController = vc;
        objAlertController = UIAlertController(title: myTitle, message: myMessage, preferredStyle: UIAlertController.Style.alert)
        let objAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        objAlertController!.addAction(objAction)
        //vc.present(self.objAlertController!, animated: true, completion: nil)
        
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert;
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(objAlertController!, animated: true, completion: nil)
    }
    
    func ShowAlert(vc:UIViewController, myTitle:String, myMessage:String, myTextField:UITextField){
        vcController = vc;
        objAlertController = UIAlertController(title: myTitle, message: myMessage, preferredStyle: UIAlertController.Style.alert)
        let objAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {Void in myTextField.becomeFirstResponder()})
        objAlertController!.addAction(objAction)
        //vc.present(self.objAlertController!, animated: true, completion: nil)
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert;
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(objAlertController!, animated: true, completion: nil)
        
    }
    
    func ShowAlert(vc:UIViewController, myTitle:String, myMessage:String, myTextView:UITextView){
        vcController = vc;
        objAlertController = UIAlertController(title: myTitle, message: myMessage, preferredStyle: UIAlertController.Style.alert)
        let objAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {Void in myTextView.becomeFirstResponder()})
        objAlertController!.addAction(objAction)
        //vc.present(self.objAlertController!, animated: true, completion: nil)
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert;
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(objAlertController!, animated: true, completion: nil)
    }
    
    
    func HideAlert(){
        objAlertController!.dismiss(
            animated: true, completion: nil)
    }
    
    // MARK:- TIMEOUT ALERT
    func ShowAlertGoBack(vc:UIViewController, myTitle:String, myMessage:String){
        let alertController = UIAlertController(title: "", message: myMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            vc.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okAction)
        vc.present(alertController, animated: true, completion: nil)
    }
}
