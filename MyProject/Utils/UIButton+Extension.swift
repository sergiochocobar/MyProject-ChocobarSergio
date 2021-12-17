//
//  UIButton+Extension.swift
//  MyProject
//
//  Created by Sergio Chocobar on 02/12/2021.
//

import UIKit


public extension UIButton {
    func buttonPink() {

        layer.cornerRadius = self.frame.size.height / 2
        layer.backgroundColor = UIColor(red: 235.0/255.0, green: 69.0/255.0, blue: 90.0/255.0, alpha: 1.0).cgColor
        tintColor = UIColor.white
        titleLabel?.textColor = UIColor.white
        clipsToBounds = true
    }
    
    func buttonWhite() {

        layer.cornerRadius = self.frame.size.height / 2
        backgroundColor = UIColor.white.withAlphaComponent(0)
        tintColor = UIColor.white
        titleLabel?.textColor = UIColor.white
        clipsToBounds = true
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }
}

