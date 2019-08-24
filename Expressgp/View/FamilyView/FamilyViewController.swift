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
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true);
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = UIColor(red:0.26, green:0.79, blue:0.66, alpha:1.0)
        }
        let img = UIImage()
        navigationController?.navigationBar.shadowImage = img
        navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        navigationController?.navigationBar.backgroundColor =  UIColor(red:0.26, green:0.79, blue:0.66, alpha:1.0)
        navigationController?.navigationBar.barTintColor = UIColor(red:0.26, green:0.79, blue:0.66, alpha:1.0)
        
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
        return cell ?? FamilyViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if fromView == "Home" {
            delegate.didselectFamilyMember(familyObj: (familaViewObj.familyListArry?[indexPath.row])!)
            self.navigationController?.popViewController(animated: true)
        }else{
            let addVC = AddMemberViewController()
            addVC.loginModalObj = self.loginModalObj
            addVC.singleFamilyObj = familaViewObj.familyListArry?[indexPath.row]
            addVC.isEditProfile = true
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
        familaViewObj.deleteFamilyMember(userObj: self.loginModalObj ?? LoginData(), memberData: familaViewObj.familyListArry?[sender.tag] ?? FamiliListData())
    }
    
}
