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
        
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = UIColor(red:0.26, green:0.79, blue:0.66, alpha:1.0)
        }
        let img = UIImage()
        navigationController?.navigationBar.shadowImage = img
        navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        navigationController?.navigationBar.backgroundColor =  UIColor(red:0.26, green:0.79, blue:0.66, alpha:1.0)
        navigationController?.navigationBar.barTintColor = UIColor(red:0.26, green:0.79, blue:0.66, alpha:1.0)
        self.navigationItem.hidesBackButton = true
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
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
