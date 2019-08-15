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
    
    var pulseArray = [CAShapeLayer]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imgvAvatar.layer.cornerRadius = imgvAvatar.frame.size.width/2.0
//        imgvAvatar.backgroundColor = UIColor.red
        createPulse()
    }
    
    
    func createPulse() {
//
        for i in 0...2 {
//            let width = (i + 1) * 50
            var radius: CGFloat = self.imgvAvatar.frame.size.width/2.0
//            radius = radius + CGFloat(width)
            let circularPath = UIBezierPath(arcCenter: .zero, radius: 300, startAngle: 0, endAngle: 2 * .pi , clockwise: true)
            let pulsatingLayer = CAShapeLayer()
            pulsatingLayer.path = circularPath.cgPath
//            pulsatingLayer.frame = self.view.bounds

            pulsatingLayer.lineWidth = 100
            pulsatingLayer.fillColor = UIColor.gray.cgColor
            pulsatingLayer.backgroundColor = UIColor.gray.cgColor
            pulsatingLayer.lineCap = CAShapeLayerLineCap.round
            pulsatingLayer.position = CGPoint(x: self.pulseVIew.frame.size.width/2, y: self.pulseVIew.frame.size.height/2)
            self.pulseVIew.layer.insertSublayer(pulsatingLayer, below:  self.imgvAvatar.layer)
            pulseArray.append(pulsatingLayer)
        }
////          for i in 0...5 {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
//                self.animatePulsatingLayerAt(index: i)
//            })
//        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.animatePulsatingLayerAt(index: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                self.animatePulsatingLayerAt(index: 1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.animatePulsatingLayerAt(index: 2)
                })
            })
        })
//
    }
    
    
    func animatePulsatingLayerAt(index:Int) {
        
        //Giving color to the layer
//        pulseArray[index].strokeColor = UIColor.darkGray.cgColor
//        pulseArray[index].backgroundColor = UIColor.purple.cgColor

        //Creating scale animation for the layer, from and to value should be in range of 0.0 to 1.0
        // 0.0 = minimum
        //1.0 = maximum
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = 0.0
        scaleAnimation.toValue = 0.9
        
        //Creating opacity animation for the layer, from and to value should be in range of 0.0 to 1.0
        // 0.0 = minimum
        //1.0 = maximum
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
        pulseArray[index].add(groupAnimation, forKey: "groupanimation")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
