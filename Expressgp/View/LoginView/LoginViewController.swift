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
    var loginViewModalObj = LoginViewModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileNoTF.text = "8976159522"
        self.btn_getStarted.addTarget(self, action: #selector(onClickGetStarted), for: .touchUpInside)
        loginViewModalObj.pushToHomeView = { (otpStr) in
            //LoadingOverlay.shared.hideLoaderView()
            let otpView = OTPViewController()
            otpView.otpStr = otpStr
            self.navigationController?.pushViewController(otpView, animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.btn_getStarted?.tintColor = UIColor.white
        self.btn_getStarted?.applyGradient(colours: [UIColor.white])
        btn_getStarted.layer.cornerRadius = 24
        btn_getStarted.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
		UIApplication.shared.statusBarView?.backgroundColor = .white
        let img = UIImage()
        navigationController?.navigationBar.shadowImage = img
        navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        navigationController?.navigationBar.backgroundColor =  UIColor(red:0.26, green:0.79, blue:0.66, alpha:1.0)
        navigationController?.navigationBar.barTintColor = UIColor(red:0.26, green:0.79, blue:0.66, alpha:1.0)
    }
    
    @objc func onClickGetStarted() {
        if mobileNoTF.text != "" {
            loginViewModalObj.checkLogin(mobileNo: mobileNoTF.text ?? "")
        }else{
            MyCustomAlert.sharedInstance.ShowAlert(vc: self, myTitle: "", myMessage: "Enter Mobile Number")
        }
//        let vc = UIStoryboard.init(name: "BaseViewController", bundle: nil).instantiateViewController(withIdentifier: "BaseViewController")
//        self.navigationController?.pushViewController(vc, animated: true)
		
    }

}
