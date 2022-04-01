//
//  FooterView.swift
//  HangFin
//
//  Created by alexdamascena on 29/03/22.
//

import UIKit

class FooterDrawer: ViewDesignable {
        
    func draw(view: UIView){
        view.backgroundColor = UIColor.clear
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .axial
        gradientLayer.colors = [ UIColor.clear.cgColor,
                                UIColor(red: 0.36, green: 0.41, blue: 0.60, alpha: 0.95).cgColor]
        gradientLayer.locations = [0, 0.5]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

}
