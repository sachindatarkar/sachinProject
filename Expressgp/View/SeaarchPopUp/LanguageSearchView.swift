//
//  LanguageSearchView.swift
//  Expressgp
//
//  Created by Sachin on 16/07/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit
protocol LanguageSearchViewDelegate {
    func didSelectlanguage(languageObj:LanguageData)
    func didSelectillness(illnessObj:IllnessData)
    func didSelectiAllergies(AllergiesObj:AllergiesData)
}

class LanguageSearchView: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    var fromText : String?
    var languageObj = LanguageSearchViweModal()
    @IBOutlet weak var registerTV: UITableView!
    var delegate : LanguageSearchViewDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
         registerTV.register(UINib(nibName: "LanguageTableCell", bundle: nil), forCellReuseIdentifier: "LanguageTableCell")
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
    
    //MARK:- UITableView Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fromText == "Language" {
           return languageObj.languageArry?.count ?? 0
        }else if fromText == "Existing Illness" {
           return languageObj.illnessArry?.count ?? 0
        }else if fromText == "Existing Allergies" {
             return languageObj.allengiArry?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageTableCell") as! LanguageTableCell
        if fromText == "Language" {
            cell.title_lbl?.text = languageObj.languageArry?[indexPath.row].language_name
        }else if fromText == "Existing Illness" {
            cell.title_lbl?.text = languageObj.illnessArry?[indexPath.row].reason
        }else if fromText == "Existing Allergies" {
            cell.title_lbl?.text = languageObj.allengiArry?[indexPath.row].allergy
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if fromText == "Language" {
            delegate.didSelectlanguage(languageObj: languageObj.languageArry?[indexPath.row] ?? LanguageData())
            //cell.title_lbl?.text = languageObj.languageArry?[indexPath.row].language_name
        }else if fromText == "Existing Illness" {
            delegate.didSelectillness(illnessObj: languageObj.illnessArry?[indexPath.row] ?? IllnessData())
            //cell.title_lbl?.text = languageObj.illnessArry?[indexPath.row].reason
        }else if fromText == "Existing Allergies" {
            delegate.didSelectiAllergies(AllergiesObj: languageObj.allengiArry?[indexPath.row] ?? AllergiesData())
            //cell.title_lbl?.text = languageObj.allengiArry?[indexPath.row].allergy
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
