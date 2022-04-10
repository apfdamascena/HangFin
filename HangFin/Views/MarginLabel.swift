//
//  MarginLabel.swift
//  HangFin
//
//  Created by alexdamascena on 10/04/22.
//

import Foundation
import UIKit

@IBDesignable class MarginLabel: UILabel {
    
    @IBInspectable var top: CGFloat = 0.0
    @IBInspectable var left: CGFloat = 0.0
    @IBInspectable var right: CGFloat = 0.0
    @IBInspectable var bottom: CGFloat = 0.0
    
    convenience init(margin: UIEdgeInsets){
        self.init()
        self.top = margin.top
        self.left = margin.left
        self.right = margin.right
        self.bottom = margin.bottom
    }
    
    override func drawText(in rect: CGRect) {
        let margin = UIEdgeInsets.init(top: self.top, left: self.left, bottom: self.bottom, right: self.right)
        super.drawText(in: rect.inset(by: margin))
    }
    
}
