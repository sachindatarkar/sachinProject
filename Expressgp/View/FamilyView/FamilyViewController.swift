//
//  FamilyViewController.swift
//  Expressgp
//
//  Created by Sachin on 24/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

protocol FamilyViewProtocol {
    func didselectFamilyMember(familyObj : FamiliListData)
}

class FamilyViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addMemberBtn: UIButton!
    var loginModalObj : LoginData?
    var familaViewObj = FamilyViewModal()
    var fromView : String?
    var delegate : FamilyViewProtocol!
   // private let sectionInsets = UIEdgeInsets(top: 10.0,left: 10.0,bottom: 10.0,right: 10.0)
    private let spacing:CGFloat = 5.0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addMemberBtn.addTarget(self, action: #selector(onClickAddMember), for: .touchUpInside)
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionView?.collectionViewLayout = layout
       
        familaViewObj.reloadCollectionView = {
            LoadingOverlay.shared.hideLoaderView()
            self.collectionView.reloadData()
        }
        
        familaViewObj.showErrorMsg = { (msg) in
            LoadingOverlay.shared.hideLoaderView()
            MyCustomAlert.sharedInstance.ShowAlert(vc: self, myTitle: "", myMessage: msg)
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        if let loginData = UserDefaults.standard.value(forKey: "UserResponse") {
//            do {
//                let loginObj = try JSONDecoder().decode(LoginModal.self, from: loginData as! Data)
//                self.loginModalObj = loginObj.data?[0]
//                LoadingOverlay.shared.showLoaderView(view: self.view)
//                self.familaViewObj.getFamilyList(userObj: loginModalObj ?? LoginData())
//            } catch let error as NSError {
//                print(error.localizedDescription)
//                print(error.description)
//            }
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
		setupNavigationBarColor()
		if fromView != nil {
			self.navigationItem.hidesBackButton = false
			let backButton = UIBarButtonItem()
			backButton.title = "Choose Patient"
			self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
		} else {
			setupNavigationBarData()
		}
        if let loginData = UserDefaults.standard.value(forKey: "UserResponse") {
            do {
                let loginObj = try JSONDecoder().decode(LoginModal.self, from: loginData as! Data)
                self.loginModalObj = loginObj.data?[0]
                LoadingOverlay.shared.showLoaderView(view: self.view)
                self.familaViewObj.getFamilyList(userObj: loginModalObj ?? LoginData())
            } catch let error as NSError {
                print(error.localizedDescription)
                print(error.description)
            }
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        self.addMemberBtn?.tintColor = UIColor.white
        self.addMemberBtn?.applyGradient(colours: [UIColor.white])
        addMemberBtn.layer.cornerRadius = 24
        addMemberBtn.layer.masksToBounds = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MAR:- Button Action
    
    @objc func onClickAddMember() {
        let addVC = AddMemberViewController()
        addVC.loginModalObj = self.loginModalObj
        addVC.isEditProfile = false
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    //MARK:- UICollectionView Delegate Datasource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = familaViewObj.familyListArry?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FamilyViewCell", for: indexPath) as? FamilyViewCell
        cell?.name_lbl.text = "\(familaViewObj.familyListArry?[indexPath.row].firstname ?? "") \(familaViewObj.familyListArry?[indexPath.row].lastname ?? "")"
        cell?.subTitle.text = "\(familaViewObj.familyListArry?[indexPath.row].age ?? "") Yrs,\(familaViewObj.familyListArry?[indexPath.row].gender ?? "")"
        cell?.relation_lbl.text = "\(familaViewObj.familyListArry?[indexPath.row].relation ?? "")"
        cell?.delete_btn.tag = indexPath.row
        cell?.delete_btn.addTarget(self, action: #selector(onClickDelete), for: .touchUpInside)
        let url = NSURL(string: familaViewObj.familyListArry?[indexPath.row].profile_pic ?? "")
        cell?.profileImg.setImage(url: url! as URL)
        return cell ?? FamilyViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if fromView == "Home" {
            delegate.didselectFamilyMember(familyObj: (familaViewObj.familyListArry?[indexPath.row])!)
            self.navigationController?.popViewController(animated: true)
        }else {
            let addVC = AddMemberViewController()
            addVC.loginModalObj = self.loginModalObj
            addVC.singleFamilyObj = familaViewObj.familyListArry?[indexPath.row]
            addVC.isEditProfile = true
            addVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(addVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let paddingSpace = sectionInsets.left * (2 + 2)
//        let availableWidth = view.frame.width - paddingSpace
//        let widthPerItem = availableWidth / 2
//
//        return CGSize(width: widthPerItem, height: widthPerItem)
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 5
        
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        if let collection = self.collectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        return sectionInsets
//    }
//
//     func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return sectionInsets.left
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//         return sectionInsets.right
//    }
    
    //MARK:- Delete Member
    
    @objc func onClickDelete(sender:UIButton) {
        
        let refreshAlert = UIAlertController(title: "Delete!", message: "Do you really want to delete.", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            self.familaViewObj.deleteFamilyMember(userObj: self.loginModalObj ?? LoginData(), memberData: self.familaViewObj.familyListArry?[sender.tag] ?? FamiliListData())
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
}
