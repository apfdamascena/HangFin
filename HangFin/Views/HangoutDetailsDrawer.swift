//
//  HangoutDetailsDrawer.swift
//  HangFin
//
//  Created by alexdamascena on 10/04/22.
//

import Foundation
import UIKit


class HangoutDetailsDrawer {
    
    let constraintsIdentifier: String = "lastHangoutViewHeight"
    
    
    func giveCornerRadiusToLabels(inside labels: UILabel...){
        labels.forEach { label in
            label.layer.cornerRadius = 4
            label.layer.masksToBounds = true
        }
    }
    
    func changeViewsAfterUserInteraction(views: UIView..., isOpen: Bool) {
        let lastHangoutsView: UIView = views[0]
        let hangoutDetailsView: UIView = views[1]
        
        guard let constraintHeight = lastHangoutsView.constraints.first (
            where: { $0.identifier == constraintsIdentifier })
        else { return }
        
        constraintHeight.constant = isOpen ? 470 : 266
        hangoutDetailsView.isHidden = !isOpen
    }
}
