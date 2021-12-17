//
//  UITextField+Extension.swift
//  MyProject
//
//  Created by Sergio Chocobar on 16/12/2021.
//

import Foundation


public extension UITextField {

    func textFieldErrorShakeAnimation(){
        UIView.animate(withDuration: 0.3, animations: {
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.red.cgColor
        })
        
        
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = 4
        animation.duration = 0.4/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [10, -10]
        self.layer.add(animation, forKey: "shake")
    }
    
    func textFieldRemoveRedBorderAnimation(){
        UIView.animate(withDuration: 0.3, animations: {
            self.layer.borderWidth = 0
        })
    }
}
