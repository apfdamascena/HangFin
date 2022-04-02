//
//  Hangout.swift
//  HangFin
//
//  Created by alexdamascena on 26/03/22.
//

import Foundation


class Hangout {
    
    public let date: String
    public let fromAdress: String
    public let fromDestiny: String
    
    public let food: Double
    public let gas: Double
    public let spent: Double
    
    public var isDetailsOpen: Bool = false
    
    init(date: String,
         fromAdress: String,
         fromDestiny: String,
         spent: Double,
         food: Double,
         gas: Double){
        
        self.date = date
        self.fromAdress = fromAdress
        self.fromDestiny = fromDestiny
        self.food = food
        self.spent = spent
        self.gas = gas
    }
}
