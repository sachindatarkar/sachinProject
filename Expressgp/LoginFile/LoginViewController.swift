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
    
    @objc func onClickGetStarted() {
        if mobileNoTF.text != "" {
            let otpView = OTPViewController()
            self.navigationController?.pushViewController(otpView, animated: true)
        }else{
            MyCustomAlert.sharedInstance.ShowAlert(vc: self, myTitle: "", myMessage: "Enter Mobile Number")
        }
    }

}
