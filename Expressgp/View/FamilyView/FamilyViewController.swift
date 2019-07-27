//
//  FamilyViewController.swift
//  Expressgp
//
//  Created by Sachin on 24/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class FamilyViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addMemberBtn: UIButton!
    var loginModalObj : LoginData?
    var familaViewObj = FamilyViewModal()
    private let sectionInsets = UIEdgeInsets(top: 10.0,left: 10.0,bottom: 10.0,right: 10.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addMemberBtn.addTarget(self, action: #selector(onClickAddMember), for: .touchUpInside)
       
        familaViewObj.reloadCollectionView = {
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let loginData = UserDefaults.standard.value(forKey: "UserResponse") {
            do {
                let loginObj = try JSONDecoder().decode(LoginModal.self, from: loginData as! Data)
                self.loginModalObj = loginObj.data?[0]
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
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
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
        let addVC = AddMemberViewController()
        addVC.loginModalObj = self.loginModalObj
        addVC.singleFamilyObj = familaViewObj.familyListArry?[indexPath.row]
        addVC.isEditProfile = true
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (2 + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / 2
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    //MARK:- Delete Member
    
    @objc func onClickDelete(sender:UIButton) {
        familaViewObj.deleteFamilyMember(userObj: self.loginModalObj ?? LoginData(), memberData: familaViewObj.familyListArry?[sender.tag] ?? FamiliListData())
    }
    
}
