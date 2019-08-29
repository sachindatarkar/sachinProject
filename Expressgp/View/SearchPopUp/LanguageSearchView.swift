//
//  LanguageSearchView.swift
//  Expressgp
//
//  Created by Sachin on 16/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit
protocol LanguageSearchViewDelegate {
    func didSelectlanguage(languageObj:[LanguageData])
    func didSelectillness(illnessObj:[IllnessData])
    func didSelectiAllergies(AllergiesObj:[AllergiesData])
}

class LanguageSearchView: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    var fromText : String?
    var languageObj = LanguageSearchViweModal()
    @IBOutlet weak var registerTV: UITableView!
    var delegate : LanguageSearchViewDelegate!
    var languagefilterData : [LanguageData]?
    var illnessfilterData : [IllnessData]?
    var allengifilterData : [AllergiesData]?
    var isFilter : Bool = false
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var cancel_btn: UIButton!
    @IBOutlet weak var done_btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         registerTV.register(UINib(nibName: "LanguageTableCell", bundle: nil), forCellReuseIdentifier: "LanguageTableCell")
        cancel_btn.addTarget(self, action: #selector(onClickCancel), for: .touchUpInside)
        done_btn.addTarget(self, action: #selector(onClickDone), for: .touchUpInside)
        cancel_btn.layer.cornerRadius = 12
        done_btn.layer.cornerRadius = 12
        titleLbl.text = "Select \(fromText ?? "")"
        
        if fromText == "Language" {
            languageObj.getsearchList(type:"language_mst.php")
        }else if fromText == "Existing Illness" {
             languageObj.getsearchList(type:"health_concern_mst.php")
        }else if fromText == "Existing Allergies" {
             languageObj.getsearchList(type:"allergy_master.php")
        }
        
        languageObj.tableReload = {
            self.registerTV.reloadData()
        }
    }

    @IBAction func onClickClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onClickCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onClickDone() {
        if fromText == "Language" {
            let selectedArry = languageObj.languageArry?.filter {name in
                return   name.isSelected == true
            }
            if selectedArry?.count ?? 0 > 0 {
               delegate.didSelectlanguage(languageObj: selectedArry ?? [LanguageData]())
            }else{
                MyCustomAlert.sharedInstance.ShowAlert(vc: self, myTitle: "", myMessage: "Please select launguage")
                return
            }
        }else if fromText == "Existing Illness" {
            let selectedArry = languageObj.illnessArry?.filter {name in
                return   name.isSelected == true
            }
            if selectedArry?.count ?? 0 > 0 {
                delegate.didSelectillness(illnessObj: selectedArry ?? [IllnessData]())
            }else{
                MyCustomAlert.sharedInstance.ShowAlert(vc: self, myTitle: "", myMessage: "Please select launguage")
                return
            }
        }else if fromText == "Existing Allergies" {
            let selectedArry = languageObj.allengiArry?.filter {name in
                return   name.isSelected == true
            }
            if selectedArry?.count ?? 0 > 0 {
                delegate.didSelectiAllergies(AllergiesObj: selectedArry ?? [AllergiesData]())
            }else{
                MyCustomAlert.sharedInstance.ShowAlert(vc: self, myTitle: "", myMessage: "Please select launguage")
                return
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
   
    
    //MARK:- UITableView Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fromText == "Language" {
            if isFilter {
                return languagefilterData?.count ?? 0
            }
           return languageObj.languageArry?.count ?? 0
        }else if fromText == "Existing Illness" {
            if isFilter {
                return illnessfilterData?.count ?? 0
            }
           return languageObj.illnessArry?.count ?? 0
        }else if fromText == "Existing Allergies" {
            if isFilter {
                return allengifilterData?.count ?? 0
            }
             return languageObj.allengiArry?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageTableCell") as! LanguageTableCell
        if fromText == "Language" {
            if isFilter {
                cell.title_lbl?.text = languagefilterData?[indexPath.row].language_name
                cell.selectedBtn.tag = indexPath.row
                if languagefilterData?[indexPath.row].isSelected ?? false {
                    cell.selectedBtn.setImage(UIImage(named: "checked-checkbox-50"), for: .normal)
                }else{
                    cell.selectedBtn.setImage(UIImage(named: "unchecked-checkbox-50"), for: .normal)
                }
            }else{
                cell.title_lbl?.text = languageObj.languageArry?[indexPath.row].language_name
                cell.selectedBtn.tag = indexPath.row
                if languageObj.languageArry?[indexPath.row].isSelected ?? false {
                    cell.selectedBtn.setImage(UIImage(named: "checked-checkbox-50"), for: .normal)
                }else{
                    cell.selectedBtn.setImage(UIImage(named: "unchecked-checkbox-50"), for: .normal)
                }
            }
            cell.selectedBtn.addTarget(self, action: #selector(onClickSelected), for: .touchUpInside)
        }else if fromText == "Existing Illness" {
            if isFilter {
                cell.title_lbl?.text = illnessfilterData?[indexPath.row].reason
                cell.selectedBtn.tag = indexPath.row
                if illnessfilterData?[indexPath.row].isSelected ?? false {
                    cell.selectedBtn.setImage(UIImage(named: "checked-checkbox-50"), for: .normal)
                }else{
                    cell.selectedBtn.setImage(UIImage(named: "unchecked-checkbox-50"), for: .normal)
                }
            }else{
                cell.title_lbl?.text = languageObj.illnessArry?[indexPath.row].reason
                cell.selectedBtn.tag = indexPath.row
                if languageObj.illnessArry?[indexPath.row].isSelected ?? false {
                    cell.selectedBtn.setImage(UIImage(named: "checked-checkbox-50"), for: .normal)
                }else{
                    cell.selectedBtn.setImage(UIImage(named: "unchecked-checkbox-50"), for: .normal)
                }
            }
            cell.selectedBtn.addTarget(self, action: #selector(onClickSelected), for: .touchUpInside)
            
        }else if fromText == "Existing Allergies" {
            if isFilter {
                cell.title_lbl?.text = allengifilterData?[indexPath.row].allergy
                cell.selectedBtn.tag = indexPath.row
                if allengifilterData?[indexPath.row].isSelected ?? false {
                    cell.selectedBtn.setImage(UIImage(named: "checked-checkbox-50"), for: .normal)
                }else{
                    cell.selectedBtn.setImage(UIImage(named: "unchecked-checkbox-50"), for: .normal)
                }
            }else{
               cell.title_lbl?.text = languageObj.allengiArry?[indexPath.row].allergy
                cell.selectedBtn.tag = indexPath.row
                if languageObj.allengiArry?[indexPath.row].isSelected ?? false {
                    cell.selectedBtn.setImage(UIImage(named: "checked-checkbox-50"), for: .normal)
                }else{
                    cell.selectedBtn.setImage(UIImage(named: "unchecked-checkbox-50"), for: .normal)
                }
            }
            cell.selectedBtn.addTarget(self, action: #selector(onClickSelected), for: .touchUpInside)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex(indexPath: indexPath.row)
    }
    
    @objc func onClickSelected(sender:UIButton) {
        self.selectedIndex(indexPath: sender.tag)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
         filterContentForSearchText(searchText: searchText)
    }
    
//    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//        print("searchText \(searchBar.text)")
//    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        if searchText != "" {
            if fromText == "Language" {
                languagefilterData = languageObj.languageArry?.filter {name in
                    return   name.language_name?.lowercased().contains(searchText.lowercased()) ?? false
                }
                 isFilter = true
            }else if fromText == "Existing Illness" {
                illnessfilterData = languageObj.illnessArry?.filter {name in
                    return   name.reason?.lowercased().contains(searchText.lowercased()) ?? false
                }
                 isFilter = true
            }else if fromText == "Existing Allergies" {
                allengifilterData = languageObj.allengiArry?.filter {name in
                    return   name.allergy?.lowercased().contains(searchText.lowercased()) ?? false
                }
                 isFilter = true
            }

        }else {
            if fromText == "Language" {
                languagefilterData = languageObj.languageArry
                isFilter = false
            }else if fromText == "Existing Illness" {
                illnessfilterData = languageObj.illnessArry
                isFilter = false
            }else if fromText == "Existing Allergies" {
                allengifilterData = languageObj.allengiArry
                isFilter = false
            }
        }

        registerTV.reloadData()
    }
    
    func selectedIndex(indexPath:Int) {
        if fromText == "Language" {
            if isFilter {
                let index = languageObj.languageArry?.index(where: { (item) -> Bool in
                    item.language_id == languagefilterData?[indexPath].language_id
                })
                if languagefilterData?[indexPath].isSelected ?? false {
                    languagefilterData?[indexPath].isSelected = false
                    languageObj.languageArry?[index ?? 0].isSelected = false
                    
                }else{
                    languagefilterData?[indexPath].isSelected = true
                    languageObj.languageArry?[index ?? 0].isSelected = true
                }
            }else{
                if languageObj.languageArry?[indexPath].isSelected ?? false {
                    languageObj.languageArry?[indexPath].isSelected = false
                }else{
                    languageObj.languageArry?[indexPath].isSelected = true
                }
            }
        }else if fromText == "Existing Illness" {
            if isFilter {
                let index = languageObj.illnessArry?.index(where: { (item) -> Bool in
                    item.visit_id == illnessfilterData?[indexPath].visit_id
                })
                if illnessfilterData?[indexPath].isSelected ?? false {
                    illnessfilterData?[indexPath].isSelected = false
                    languageObj.illnessArry?[index ?? 0].isSelected = false
                    
                }else{
                    illnessfilterData?[indexPath].isSelected = true
                    languageObj.illnessArry?[index ?? 0].isSelected = true
                }
            }else{
                if languageObj.languageArry?[indexPath].isSelected ?? false {
                    languageObj.illnessArry?[indexPath].isSelected = false
                }else{
                    languageObj.illnessArry?[indexPath].isSelected = true
                }
            }
            
        }else if fromText == "Existing Allergies" {
            if isFilter {
                let index = languageObj.allengiArry?.index(where: { (item) -> Bool in
                    item.allergy_id == allengifilterData?[indexPath].allergy_id
                })
                if allengifilterData?[indexPath].isSelected ?? false {
                    allengifilterData?[indexPath].isSelected = false
                    languageObj.allengiArry?[index ?? 0].isSelected = false
                    
                }else{
                    allengifilterData?[indexPath].isSelected = true
                    languageObj.allengiArry?[index ?? 0].isSelected = true
                }
            }else{
                if languageObj.allengiArry?[indexPath].isSelected ?? false {
                    languageObj.allengiArry?[indexPath].isSelected = false
                }else{
                    languageObj.allengiArry?[indexPath].isSelected = true
                }
            }
        }
        registerTV.reloadData()
    }
}
