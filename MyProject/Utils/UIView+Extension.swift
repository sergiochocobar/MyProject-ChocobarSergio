//
//  UIView+Extension.swift
//  MyProject
//
//  Created by Sergio Chocobar on 02/12/2021.
//

import UIKit

public extension UIView {
    func setGradientBackground() {
        let colorTop =  UIColor(red: 182.0/255.0, green: 87.0/255.0, blue: 148.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 86.0/255.0, green: 96.0/255.0, blue: 225.0/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}

    
