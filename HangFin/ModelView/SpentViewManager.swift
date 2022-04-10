//
//  SpentManager.swift
//  HangFin
//
//  Created by alexdamascena on 08/04/22.
//

import Foundation
import UIKit

class SpentViewManager {
    
    let spent: UILabel
    
    init(observe spentTextField: UILabel ){
        self.spent = spentTextField
    }
    
    func expenseAccount(of hangouts: [Hangout]) {
        var sum: Double = 0.0
        hangouts.forEach{ hangout in
            sum += hangout.spent
        }
        self.spent.text = String(format: "R$ %.2f", sum)
    }
    
    
}
