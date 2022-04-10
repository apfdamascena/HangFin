//
//  HangoutDetailsViewManager.swift
//  HangFin
//
//  Created by alexdamascena on 10/04/22.
//

import Foundation
import UIKit


class HangoutDetailsViewManager {
    
    let lastHangoutsView: UIView
    let hangoutDetailsView: UIView
    
    var totalHangout: UILabel = UILabel()
    var foodHangout: UILabel = UILabel()
    var gasHangout: UILabel = UILabel()
    var fromAdressHangout: UILabel = UILabel()
    var  kmHangout: UILabel = UILabel()
    var  destinyHangout: UILabel = UILabel()
    var  dateHangout: UILabel = UILabel()
    
    init(observe references: UIView...){
        self.lastHangoutsView = references[0]
        self.hangoutDetailsView = references[1]
    }
    
    init(){
        self.lastHangoutsView = UIView()
        self.hangoutDetailsView = UIView()
    }
    
    func addReferenceToViewManager(references fields: UILabel...){
        self.dateHangout = fields[0]
        self.totalHangout = fields[1]
        self.foodHangout = fields[2]
        self.gasHangout = fields[3]
        self.fromAdressHangout = fields[4]
        self.destinyHangout = fields[5]
        self.kmHangout = fields[6]
    }
    
    func draw(_ hangout: Hangout){
        changeViewAfterOpen()
        giveCornerRadiusToLabels()
        
        totalHangout.text = "R$ \(hangout.spent)"
        foodHangout.text = "R$ \(hangout.food)"
        gasHangout.text = "R$ \(hangout.gas)"
        fromAdressHangout.text = hangout.fromAdress
        destinyHangout.text = hangout.fromDestiny
        dateHangout.text = hangout.date
        kmHangout.text = String(format: "%.1f", hangout.km)
    }

    private func giveCornerRadiusToLabels(){
        [fromAdressHangout, kmHangout, destinyHangout].forEach { label in
            label.layer.cornerRadius = 8
            label.layer.masksToBounds = true
        }
    }
    
    func changeViewAfterClose() {
        guard let constraintHeight = self.lastHangoutsView.constraints.first (
            where: { $0.identifier == "lastHangoutViewHeight" })
        else { return }
        constraintHeight.constant = 266
        hangoutDetailsView.isHidden = true
    }
    
    private func changeViewAfterOpen(){
        guard let constraintHeight = self.lastHangoutsView.constraints.first (
            where: { $0.identifier == "lastHangoutViewHeight" })
        else { return }
        constraintHeight.constant = 470
        hangoutDetailsView.isHidden = false
    }
}
