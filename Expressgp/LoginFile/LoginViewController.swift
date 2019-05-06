//
//  LoginViewController.swift
//  Expressgp
//
//  Created by Sachin on 29/04/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var mobileNoTF: UITextField!
    @IBOutlet weak var btn_getStarted: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btn_getStarted?.tintColor = UIColor.white
        self.btn_getStarted?.applyGradient(colours: [UIColor.white])
        btn_getStarted.layer.cornerRadius = 24
        btn_getStarted.layer.masksToBounds = true
        self.btn_getStarted.addTarget(self, action: #selector(onClickGetStarted), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = UIColor.white
        }
        let img = UIImage()
        navigationController?.navigationBar.shadowImage = img
        navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        navigationController?.navigationBar.backgroundColor =  UIColor(red:0.26, green:0.79, blue:0.66, alpha:1.0)
        navigationController?.navigationBar.barTintColor = UIColor(red:0.26, green:0.79, blue:0.66, alpha:1.0)
    }
    
    @objc func onClickGetStarted() {
        if mobileNoTF.text != "" {
            let otpView = OTPViewController()
            self.navigationController?.pushViewController(otpView, animated: true)
        }else{
            MyCustomAlert.sharedInstance.ShowAlert(vc: self, myTitle: "", myMessage: "Enter Mobile Number")
        }
    }

}
