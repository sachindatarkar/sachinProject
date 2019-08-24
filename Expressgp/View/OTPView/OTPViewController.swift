//
//  OTPViewController.swift
//  Expressgp
//
//  Created by Sachin on 29/04/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var submit_btn: UIButton!
    @IBOutlet weak var resendOtp_btn: UIButton!
    @IBOutlet weak var fourthTF: UITextField!
    @IBOutlet weak var thirdTF: UITextField!
    @IBOutlet weak var secondTF: UITextField!
    @IBOutlet weak var firstTF: UITextField!
    @IBOutlet weak var waitingText_lbl: UILabel!
    var count : Int = 45
    var otpStr : Int?
    var otpViewModalObj = OtpViewModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.submit_btn?.applyGradient(colours: [UIColor.white])
        submit_btn.layer.cornerRadius = 24
        submit_btn.layer.masksToBounds = true
        self.submit_btn.addTarget(self, action: #selector(onClickSubmit), for: .touchUpInside)
        self.resendOtp_btn.addTarget(self, action: #selector(onClickResend), for: .touchUpInside)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)

        firstTF.delegate = self
        secondTF.delegate = self
        thirdTF.delegate = self
        fourthTF.delegate = self
        firstTF.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        secondTF.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        thirdTF.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        fourthTF.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        resendOtp_btn.underline()
        firstTF.setBottomBorder()
        secondTF.setBottomBorder()
        thirdTF.setBottomBorder()
        fourthTF.setBottomBorder()
        
        otpViewModalObj.pushToHomeView = {
            LoadingOverlay.shared.hideLoaderView()
            let vc = UIStoryboard.init(name: "BaseViewController", bundle: nil).instantiateViewController(withIdentifier: "BaseViewController")
           self.navigationController?.pushViewController(vc, animated: true)
        }
        
        otpViewModalObj.pushToRegistartion = {
            LoadingOverlay.shared.hideLoaderView()
            let vc = RegisterViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = UIColor(red:0.26, green:0.79, blue:0.66, alpha:1.0)
        }
        let img = UIImage()
        navigationController?.navigationBar.shadowImage = img
        navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        navigationController?.navigationBar.backgroundColor =  UIColor(red:0.26, green:0.79, blue:0.66, alpha:1.0)
        navigationController?.navigationBar.barTintColor = UIColor(red:0.26, green:0.79, blue:0.66, alpha:1.0)
    }
    
    @objc func onClickSubmit() {
        let otpStrings = "\(firstTF.text ?? "")\(secondTF.text ?? "")\(thirdTF.text ?? "")\(fourthTF.text ?? "")"
        print(otpStrings)
        if !otpStrings.contains("") && otpStrings.count == 4 {
            LoadingOverlay.shared.showLoaderView(view: self.view)
            otpViewModalObj.checkOtp(otpText: otpStr ?? 0)
//            let vc = RegisterViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @objc func onClickResend() {
        
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if text?.utf16.count ?? 0 >= 1{
            switch textField{
            case firstTF:
                secondTF.becomeFirstResponder()
            case secondTF:
                thirdTF.becomeFirstResponder()
            case thirdTF:
                fourthTF.becomeFirstResponder()
            case fourthTF:
                fourthTF.resignFirstResponder()
            default:
                break
            }
        }else{
            
        }
    }
    
    @objc func updateTime(){
        if(count > 0) {
             count -= 1
            waitingText_lbl.text = "Wating for the OTP \(timeFormatted(count))"
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        return String(format: "0:%02ds", seconds)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationItem.hidesBackButton = true
    }
}
