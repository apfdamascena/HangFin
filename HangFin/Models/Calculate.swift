//
//  Calculate.swift
//  HangFin
//
//  Created by alexdamascena on 31/03/22.
//

import Foundation

class Calculate {
    
    
    static func avarage(of hangouts: [Hangout] ) -> Double {
        var sum: Double = 0.0
        
        hangouts.forEach{ hangout in
            let spent: Double = Double(hangout.spent) ?? 0.0
            sum += spent;
        }
        
        let hangoutQuantity = Double(hangouts.count)
        let avarage: Double = sum / hangoutQuantity
        return avarage
    }
}
