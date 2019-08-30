//
//  AddMemberViewController.swift
//  Expressgp
//
//  Created by Sachin on 23/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class AddMemberViewController: UIViewController,UITextFieldDelegate,LanguageSearchViewDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var womenSelectionImg: UIImageView!
    @IBOutlet weak var menSelectionImg: UIImageView!
    @IBOutlet weak var btn_save: UIButton!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNamTF: UITextField!
    @IBOutlet weak var mentBtn: UIButton!
    @IBOutlet weak var womenBtn: UIButton!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var relationTF: UITextField!
    @IBOutlet weak var relativeemailTF: UITextField!
    @IBOutlet weak var relativeMobileNoTF: UITextField!
    @IBOutlet weak var checkBox_btn: UIButton!
    @IBOutlet weak var existingAllergiTF: UITextField!
    @IBOutlet weak var existingillnessTF: UITextField!
    @IBOutlet weak var languageTF: UITextField!
    
    var companyProfileObj = CompanyProfileModal()
    let datePicker = UIDatePicker()
    var addMemberViewObj = AddMemberViewModal()
    var loginModalObj : LoginData?
    var singleFamilyObj : FamiliListData?
    var isEditProfile : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.layer.masksToBounds = true
        
        self.btn_save.addTarget(self, action: #selector(onClickSubmit), for: .touchUpInside)
        womenBtn.addTarget(self, action: #selector(OnClickWomen), for: .touchUpInside)
        mentBtn.addTarget(self, action: #selector(OnClickMen), for: .touchUpInside)
        setInfoToView()
        addMemberViewObj.addFamilySuccess = {
            self.navigationController?.popViewController(animated: true)
        }
        
        addMemberViewObj.showErrorMsg = { (msg) in
            LoadingOverlay.shared.hideLoaderView()
            MyCustomAlert.sharedInstance.ShowAlert(vc: self, myTitle: "", myMessage: msg)
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.btn_save?.tintColor = UIColor.white
        self.btn_save?.applyGradient(colours: [UIColor.white])
        btn_save.layer.cornerRadius = 24
        btn_save.layer.masksToBounds = true
    }
    
    func setInfoToView() {
        if singleFamilyObj?.gender == "M" {
            menSelectionImg.image = UIImage(named: "optionSelect")
            companyProfileObj.gender = "Male"
        }else if singleFamilyObj?.gender == "W" {
           companyProfileObj.gender = "Women"
           womenSelectionImg.image = UIImage(named: "optionSelect")
        }
        companyProfileObj.firstName = singleFamilyObj?.firstname
        companyProfileObj.lastName = singleFamilyObj?.lastname
        companyProfileObj.gender = singleFamilyObj?.gender
        companyProfileObj.dateOfBirth = singleFamilyObj?.dob
        companyProfileObj.relation = singleFamilyObj?.relation
        companyProfileObj.emailId = singleFamilyObj?.email
        companyProfileObj.mobileNo = singleFamilyObj?.phone
        companyProfileObj.language = singleFamilyObj?.languages
        companyProfileObj.existingIllness = singleFamilyObj?.illness
        companyProfileObj.existingAllergies = singleFamilyObj?.allergy
        firstNameTF.text = singleFamilyObj?.firstname
        lastNamTF.text = singleFamilyObj?.lastname
        dobTF.text = singleFamilyObj?.dob
        relationTF.text = singleFamilyObj?.relation
        relativeemailTF.text = singleFamilyObj?.email
        relativeMobileNoTF.text = singleFamilyObj?.phone
        existingAllergiTF.text = singleFamilyObj?.allergy
        existingillnessTF.text = singleFamilyObj?.illness
        languageTF.text = singleFamilyObj?.languages
        let url = NSURL(string: singleFamilyObj?.profile_pic ?? "")
        profileImage.setImage(url: url! as URL)
    }
    
    //MARK:- TextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.placeholder == "Date of Birth" {
            //textField.resignFirstResponder()
            showDateOfBirthPicker()
        }else if textField.placeholder == "Launguage" {
            self.view.endEditing(true)
            let vc = LanguageSearchView()
            vc.fromText = "Language"
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }else if textField.placeholder == "Existing illness" {
            self.view.endEditing(true)
            let vc = LanguageSearchView()
            vc.delegate = self
            vc.fromText = "Existing Illness"
            self.present(vc, animated: true, completion: nil)
        }else if textField.placeholder == "Existing Allergies" {
            self.view.endEditing(true)
            let vc = LanguageSearchView()
            vc.delegate = self
            vc.fromText = "Existing Allergies"
            self.present(vc, animated: true, completion: nil)
        }else if textField.placeholder == "Relation" {
            self.view.endEditing(true)
            self.showActionSheet()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            if textField.placeholder == "Enter First Name Of family member" {
                companyProfileObj.firstName = textField.text ?? ""
            }else if textField.placeholder == "Enter Last Name Of Family Member" {
                companyProfileObj.lastName = textField.text
            }else if textField.placeholder == "Enter relative mobile number (optional)" {
                companyProfileObj.mobileNo = ConstantClass.sharedInstance.mobileNo
            }else if textField.placeholder == "Enter relative email id (optional)" {
                companyProfileObj.emailId = textField.text
            }
    }
    
    func showDateOfBirthPicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dobTF?.inputAccessoryView = toolbar
        dobTF?.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-dd-MM"
        dobTF?.text = formatter.string(from: datePicker.date)
        companyProfileObj.dateOfBirth = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    //MARK:- LanguageDelegate
    
    func didSelectlanguage(languageObj:[LanguageData]) {
        languageTF.text = languageObj[0].language_name
        companyProfileObj.language = languageObj[0].language_name
        companyProfileObj.language_id = languageObj[0].language_id
    }
    func didSelectillness(illnessObj:[IllnessData]) {
        companyProfileObj.Illness_id = illnessObj[0].specialty_id
        companyProfileObj.existingIllness = illnessObj[0].reason
        existingillnessTF.text = illnessObj[0].reason
    }
    func didSelectiAllergies(AllergiesObj:[AllergiesData]) {
        companyProfileObj.allergies_id = AllergiesObj[0].allergy_id
        companyProfileObj.existingAllergies = AllergiesObj[0].allergy
        existingAllergiTF.text = AllergiesObj[0].allergy
    }
    
    //MARK:- Button Action
    
    @objc func OnClickWomen() {
        companyProfileObj.gender = "Women"
        womenSelectionImg.image = UIImage(named: "optionSelect")
        menSelectionImg.image = UIImage(named: "optionUnselect")
    }
    
    @objc func OnClickMen() {
        companyProfileObj.gender = "Men"
        womenSelectionImg.image = UIImage(named: "optionUnselect")
        menSelectionImg.image = UIImage(named: "optionSelect")
    }
    
    func showActionSheet()  {
        let alertController = UIAlertController(title: "Relation", message: "", preferredStyle: .actionSheet)
        let brother = UIAlertAction(title: "Brother", style: .default) { (action:UIAlertAction) in
             self.relationTF.text = "Brother"
            self.companyProfileObj.relation = "Brother"
        }
        
        let sister = UIAlertAction(title: "Sister", style: .default) { (action:UIAlertAction) in
            self.relationTF.text = "Sister"
             self.companyProfileObj.relation = "Sister"
        }
        
        let father = UIAlertAction(title: "Father", style: .default) { (action:UIAlertAction) in
            self.relationTF.text = "Father"
             self.companyProfileObj.relation = "Father"
        }
        
        let mother = UIAlertAction(title: "Mother", style: .default) { (action:UIAlertAction) in
            self.relationTF.text = "Mother"
            self.companyProfileObj.relation = "Mother"
        }
        let myself = UIAlertAction(title: "MySelf", style: .default) { (action:UIAlertAction) in
            self.relationTF.text = "MySelf"
            self.companyProfileObj.relation = "MySelf"
        }
        
        let other = UIAlertAction(title: "Other", style: .default) { (action:UIAlertAction) in
            self.relationTF.text = "Other"
            self.companyProfileObj.relation =  "Other"
        }
        
        alertController.addAction(brother)
        alertController.addAction(sister)
        alertController.addAction(father)
        alertController.addAction(mother)
        alertController.addAction(myself)
        alertController.addAction(other)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func onClickSubmit() {
        if companyProfileObj.firstName == "" || companyProfileObj.firstName == nil  {
            self.showAlert(title: "", message: "Enter first name")
            return
        }else if companyProfileObj.lastName == "" || companyProfileObj.lastName == nil {
            self.showAlert(title: "", message: "Enter last name")
            return
        }else if companyProfileObj.gender == "" || companyProfileObj.gender == nil {
            self.showAlert(title: "", message: "Please select gender")
            return
        }else if companyProfileObj.dateOfBirth == "" || companyProfileObj.dateOfBirth == nil {
            self.showAlert(title: "", message: "Please select date of birth")
            return
        }else if companyProfileObj.relation == "" || companyProfileObj.relation == nil {
            self.showAlert(title: "", message: "Please select relation")
            return
        }
        addMemberViewObj.addFamilyMember(userObj: companyProfileObj, userData: loginModalObj ?? LoginData(), singleFamilyObj: singleFamilyObj ?? FamiliListData(), isedit: isEditProfile ?? false)
    }
    
}
