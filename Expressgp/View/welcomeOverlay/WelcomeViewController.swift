//
//  ViewController.swift
//  Expressgp
//
//  Created by Shital Sharma on 25/05/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onSkipClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
