//
//  RegisterViewController.swift
//  Expressgp
//
//  Created by Sachin on 03/05/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

struct CompleteProfile {
    var firstPlaceHolder : String?
    var secondPlaceHolder : String?
    var firstText : String?
    var secondText : String?
    var iconImg :String?
}

class RegisterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    @IBOutlet weak var registerTV: UITableView!
    @IBOutlet weak var logo_img: UIImageView!
    var completeProfileArry = [CompleteProfile]()
    var companyProfileObj = CompanyProfileModal()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        logo_img.layer.cornerRadius = logo_img.frame.size.width/2
        logo_img.layer.masksToBounds = true
        logo_img.layer.borderWidth = 1
        logo_img.layer.borderColor = UIColor(red:0.26, green:0.79, blue:0.66, alpha:1.0).cgColor
        registerTV.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        completeProfileArry.append(CompleteProfile(firstPlaceHolder: "First Name", secondPlaceHolder: "Last Name", firstText: "", secondText: "",iconImg :""))
        completeProfileArry.append(CompleteProfile(firstPlaceHolder: "Mobile Number", secondPlaceHolder: "", firstText: "", secondText: "",iconImg :""))
        completeProfileArry.append(CompleteProfile(firstPlaceHolder: "Email Id", secondPlaceHolder: "", firstText: "", secondText: "",iconImg :""))
        completeProfileArry.append(CompleteProfile(firstPlaceHolder: "Men", secondPlaceHolder: "Women", firstText: "", secondText: "",iconImg :""))
        completeProfileArry.append(CompleteProfile(firstPlaceHolder: "Date Of Birth", secondPlaceHolder: "", firstText: "", secondText: "",iconImg :""))
        completeProfileArry.append(CompleteProfile(firstPlaceHolder: "Language", secondPlaceHolder: "", firstText: "", secondText: "",iconImg :""))
        completeProfileArry.append(CompleteProfile(firstPlaceHolder: "Existing Illness", secondPlaceHolder: "", firstText: "", secondText: "",iconImg :""))
        completeProfileArry.append(CompleteProfile(firstPlaceHolder: "Existing Allergies", secondPlaceHolder: "", firstText: "", secondText: "",iconImg :""))
        completeProfileArry.append(CompleteProfile(firstPlaceHolder: "Upload Insurance", secondPlaceHolder: "", firstText: "", secondText: "",iconImg :""))
        completeProfileArry.append(CompleteProfile(firstPlaceHolder: "I Accept Term & Condition", secondPlaceHolder: "", firstText: "", secondText: "",iconImg :""))
        
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
    
    func registerCell()  {
        registerTV.register(UINib(nibName: "FirstNameLastNameCell", bundle: nil), forCellReuseIdentifier: "FirstNameLastNameCell")
        registerTV.register(UINib(nibName: "GenderCell", bundle: nil), forCellReuseIdentifier: "GenderCell")
        registerTV.register(UINib(nibName: "GeneralRegisterCell", bundle: nil), forCellReuseIdentifier: "GeneralRegisterCell")
         registerTV.register(UINib(nibName: "TermAndConditionCell", bundle: nil), forCellReuseIdentifier: "TermAndConditionCell")
    }
    
    //MARK:- UITableView Delegate and DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completeProfileArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstNameLastNameCell") as? FirstNameLastNameCell
            cell?.firstNameTF.delegate = self
            cell?.lastNameTF.delegate = self
            cell?.firstNameTF.placeholder = completeProfileArry[indexPath.row].firstPlaceHolder
            cell?.lastNameTF.placeholder = completeProfileArry[indexPath.row].secondPlaceHolder
            cell?.firstNameTF.text = companyProfileObj.firstName
            cell?.lastNameTF.text = companyProfileObj.lastName
            return cell!
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralRegisterCell") as? GeneralRegisterCell
            cell?.titleTF.delegate = self
            cell?.titleTF.placeholder = completeProfileArry[indexPath.row].firstPlaceHolder
            cell?.titleTF.text = companyProfileObj.mobileNo
            return cell!
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralRegisterCell") as? GeneralRegisterCell
            cell?.titleTF.delegate = self
             cell?.titleTF.placeholder = completeProfileArry[indexPath.row].firstPlaceHolder
            cell?.titleTF.text = companyProfileObj.emailId
            return cell!
        }else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GenderCell") as? GenderCell
            return cell!
        }else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralRegisterCell") as? GeneralRegisterCell
            cell?.titleTF.delegate = self
             cell?.titleTF.placeholder = completeProfileArry[indexPath.row].firstPlaceHolder
            return cell!
        }else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralRegisterCell") as? GeneralRegisterCell
            cell?.titleTF.delegate = self
             cell?.titleTF.placeholder = completeProfileArry[indexPath.row].firstPlaceHolder
            return cell!
        }else if indexPath.row == 6 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralRegisterCell") as? GeneralRegisterCell
            cell?.titleTF.delegate = self
             cell?.titleTF.placeholder = completeProfileArry[indexPath.row].firstPlaceHolder
            return cell!
        }else if indexPath.row == 7 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralRegisterCell") as? GeneralRegisterCell
            cell?.titleTF.delegate = self
             cell?.titleTF.placeholder = completeProfileArry[indexPath.row].firstPlaceHolder
            return cell!
        }else if indexPath.row == 8 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralRegisterCell") as? GeneralRegisterCell
            cell?.titleTF.delegate = self
             cell?.titleTF.placeholder = completeProfileArry[indexPath.row].firstPlaceHolder
            return cell!
        }else if indexPath.row == 9 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TermAndConditionCell") as? TermAndConditionCell
            return cell!
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.white
        let submit_btn = UIButton(type: .custom)
        submit_btn.frame = CGRect(x: 50, y: 25, width: registerTV.frame.width - 100, height: 50)
        submit_btn.setTitle("Submit", for: .normal)
        submit_btn.applyGradient(colours: [UIColor.white])
        submit_btn.layer.cornerRadius = 24
        submit_btn.layer.masksToBounds = true
        submit_btn.addTarget(self, action: #selector(onClickSubmit), for: .touchUpInside)
        view.addSubview(submit_btn)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    @objc func onClickSubmit() {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let position: CGPoint = textField.convert(CGPoint.zero, to: self.registerTV)
        if let indexPath = self.registerTV.indexPathForRow(at: position) {
            let section = indexPath.section
            let row = indexPath.row
            print("\(section) - \(row)")
            if textField.placeholder == "First Name" {
                companyProfileObj.firstName = textField.text ?? ""
            }else if textField.placeholder == "Last Name" {
               companyProfileObj.lastName = textField.text
            }else if textField.placeholder == "Mobile Number" {
               companyProfileObj.mobileNo = textField.text
            }else if textField.placeholder == "Email Id" {
               companyProfileObj.emailId = textField.text
            }else if textField.placeholder == "Language" {
               companyProfileObj.language = textField.text
            }else if textField.placeholder == "Language" {
                companyProfileObj.language = textField.text
            }else if textField.placeholder == "Existing Illness" {
                companyProfileObj.existingIllness = textField.text
            }else if textField.placeholder == "Existing Allergies" {
                companyProfileObj.existingAllergies = textField.text
            }
        }
        registerTV.reloadData()
    }
    @objc func didChangeFirstText(textField:UITextField) {
        if(textField.text == " "){
            textField.text = ""
        }
    }
}
