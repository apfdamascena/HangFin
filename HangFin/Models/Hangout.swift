//
//  Hangout.swift
//  HangFin
//
//  Created by alexdamascena on 26/03/22.
//

import Foundation


class Hangout {
    
    public let date: String
    public let spent: String
    public var isDetailsOpen: Bool = false

    init(date: String, spent: String){
        self.date = date
        self.spent = spent
    }
}
