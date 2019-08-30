//
//  FindingDoctorViewController.swift
//  Expressgp
//
//  Created by Shital Sharma on 29/05/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit

class FindingDoctorViewController: UIViewController {
    @IBOutlet weak var pulseVIew: UIView!
    @IBOutlet weak var imgvAvatar: UIImageView!
	@IBOutlet weak var crossButton: UIButton!
	var viewModel: FindDoctorViewModel = FindDoctorViewModel()
	var pulseArray = [CAShapeLayer]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imgvAvatar.layer.cornerRadius = imgvAvatar.frame.size.width/2.0
        createPulse()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        pulseVIew.addGestureRecognizer(tap)
        
        viewModel.showErrorMsg = { (msg) in
            MyCustomAlert.sharedInstance.ShowAlert(vc: self, myTitle: "", myMessage: msg)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        print("Tap on click")
        self.dismiss(animated: true, completion: nil)
    }
    
	func getDoctorList(){
		var loginData: LoginData?
		getUserData(completionHandler: { (data, _) in
			loginData = data
		})
		
//		self.viewModel.getDoctorList(bookingObj: BookingListData, userObj: LoginData)
	}
    func createPulse() {
		for _ in 0...2 {
            let circularPath = UIBezierPath(arcCenter: .zero, radius: 300, startAngle: 0, endAngle: 2 * .pi , clockwise: true)
            let pulsatingLayer = CAShapeLayer()
            pulsatingLayer.path = circularPath.cgPath
            pulsatingLayer.lineWidth = 100
            pulsatingLayer.lineCap = CAShapeLayerLineCap.round
			pulsatingLayer.fillColor = UIColor.clear.cgColor
			pulsatingLayer.backgroundColor = UIColor.clear.cgColor
            pulsatingLayer.position = CGPoint(x: self.pulseVIew.frame.size.width/2, y: self.pulseVIew.frame.size.height/2)
            self.pulseVIew.layer.insertSublayer(pulsatingLayer, below:  self.imgvAvatar.layer)
            pulseArray.append(pulsatingLayer)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.animatePulsatingLayerAt(index: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                self.animatePulsatingLayerAt(index: 1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                    self.animatePulsatingLayerAt(index: 2)
                })
            })
        })
//
    }
    
    
    func animatePulsatingLayerAt(index:Int) {
		
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = 0.0
        scaleAnimation.toValue = 0.9
        let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimation.fromValue = 0.9
        opacityAnimation.toValue = 0.0
        
        // Grouping both animations and giving animation duration, animation repat count
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [scaleAnimation, opacityAnimation]
        groupAnimation.duration = 2.3
        groupAnimation.repeatCount = .greatestFiniteMagnitude
        groupAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        //adding groupanimation to the layer
		pulseArray[index].fillColor = UIColor.lightGray.cgColor
		pulseArray[index].backgroundColor = UIColor.lightGray.cgColor
        pulseArray[index].add(groupAnimation, forKey: "groupanimation")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func dismissView(_ sender: Any) {
		self.dismiss(animated: true)
	}
	
}
