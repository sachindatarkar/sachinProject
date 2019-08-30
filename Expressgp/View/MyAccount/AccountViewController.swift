//
//  AccountViewController.swift
//  Expressgp
//
//  Created by Sachin on 03/08/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var logoOut_btn: UIButton!
    @IBOutlet weak var help_btn: UIButton!
    @IBOutlet weak var document_btn: UIButton!
    @IBOutlet weak var address_btn: UIButton!
    @IBOutlet weak var setting_btn: UIButton!
    @IBOutlet weak var update_btn: UIButton!
    @IBOutlet weak var mobileNo_lbl: UILabel!
    @IBOutlet weak var userName_lbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var loginModalObj : LoginData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.layer.masksToBounds = true
        self.navigationItem.setHidesBackButton(true, animated:true);
        logoOut_btn.addTarget(self, action: #selector(onClickLogOut), for: .touchUpInside)

        if let loginData = UserDefaults.standard.value(forKey: "UserResponse") {
            do {
                let loginObj = try JSONDecoder().decode(LoginModal.self, from: loginData as! Data)
                self.loginModalObj = loginObj.data?[0]
                self.userName_lbl.text = "\(self.loginModalObj?.firstname ?? "") \(self.loginModalObj?.lastname ?? "")"
                self.mobileNo_lbl.text = self.loginModalObj?.phone
            } catch let error as NSError {
                print(error.localizedDescription)
                print(error.description)
            }
        }
        
        update_btn.addTarget(self, action: #selector(onClickUpdate), for: .touchUpInside)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        UIApplication.shared.statusBarView?.backgroundColor = Style.Color.Background.primaryColor
        self.setupNavigationBarData()
		setupNavigationBarColor()

    }
    
    override func viewDidLayoutSubviews() {
        self.update_btn?.tintColor = UIColor.white
        self.update_btn?.applyGradient(colours: [UIColor.white])
        update_btn.layer.cornerRadius = 21
        update_btn.layer.masksToBounds = true
        
        self.logoOut_btn?.tintColor = UIColor.white
        self.logoOut_btn?.applyGradient(colours: [UIColor.white])
        logoOut_btn.layer.cornerRadius = 21
        logoOut_btn.layer.masksToBounds = true
 
    }
    
    @objc func onClickUpdate() {
        let vc = RegisterViewController()
         vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onClickLogOut() {
        let vc = LoginViewController()
        let navView = UINavigationController(rootViewController: vc)
        self.appDelegate.window?.rootViewController = navView
        self.appDelegate.window?.makeKeyAndVisible()
    }
    
}
