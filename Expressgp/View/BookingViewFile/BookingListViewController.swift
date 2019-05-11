//
//  BookingListViewController.swift
//  Expressgp
//
//  Created by Sachin on 07/05/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class BookingListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var bookingListTV: UITableView!
    @IBOutlet weak var historyBorder: UIView!
    @IBOutlet weak var btn_history: UIButton!
    @IBOutlet weak var active_border: UIView!
    @IBOutlet weak var btn_active: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        bookingListTV.register(UINib(nibName: "BookingListCell", bundle: nil), forCellReuseIdentifier: "BookingListCell")
        btn_active.addTarget(self, action: #selector(onClickActive), for: .touchUpInside)
        btn_history.addTarget(self, action: #selector(onClickHistory), for: .touchUpInside)
        btn_active.setTitleColor(UIColor(red:0.27, green:0.55, blue:0.65, alpha:1.0), for: .normal)
        active_border.backgroundColor = UIColor(red:0.27, green:0.55, blue:0.65, alpha:1.0)
        btn_history.setTitleColor(UIColor.lightGray, for: .normal)
        historyBorder.backgroundColor = UIColor.lightGray
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
    }

    @objc func onClickActive() {
        btn_active.setTitleColor(UIColor(red:0.27, green:0.55, blue:0.65, alpha:1.0), for: .normal)
        active_border.backgroundColor = UIColor(red:0.27, green:0.55, blue:0.65, alpha:1.0)
        btn_history.setTitleColor(UIColor.lightGray, for: .normal)
        historyBorder.backgroundColor = UIColor.lightGray
    }
    @objc func onClickHistory() {
        btn_history.setTitleColor(UIColor(red:0.27, green:0.55, blue:0.65, alpha:1.0), for: .normal)
        historyBorder.backgroundColor = UIColor(red:0.27, green:0.55, blue:0.65, alpha:1.0)
        btn_active.setTitleColor(UIColor.lightGray, for: .normal)
        active_border.backgroundColor = UIColor.lightGray
    }
    
    //MARK:- UITableView Delegate And Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingListCell") as! BookingListCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BookingDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
