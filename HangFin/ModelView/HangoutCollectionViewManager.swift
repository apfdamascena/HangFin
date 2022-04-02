//
//  HangoutCollectionViewManager.swift
//  HangFin
//
//  Created by alexdamascena on 31/03/22.
//

import Foundation
import UIKit

class HangoutCollectionViewManager {
    
    var collections: [UICollectionView] = []
    
    var  hangoutsDataSource : [Hangout] = [
        Hangout(date: "23/03/2024", fromAdress: "Rua Rio", fromDestiny: "Rua Rio", spent: 1250.50, food: 300.0, gas: 250.75),
        
        Hangout(date: "23/03/2024", fromAdress: "Rua Rio", fromDestiny: "Rua Rio", spent: 1250.50, food: 300.0, gas: 250.75),
        
        Hangout(date: "23/03/2024", fromAdress: "Rua Rio", fromDestiny: "Rua Rio", spent: 1250.50, food: 300.0, gas: 250.75),
        
        Hangout(date: "23/03/2024", fromAdress: "Rua Rio", fromDestiny: "Rua Rio", spent: 1250.50, food: 300.0, gas: 250.75),
        
        Hangout(date: "23/03/2024", fromAdress: "Rua Rio", fromDestiny: "Rua Rio", spent: 1250.50, food: 300.0, gas: 250.75)
    ]
    
    var recommendationDataSource: [Hangout] = []
        
    func add(view: UICollectionView) {
        collections.append(view)
    }
        
    func setup(context: ViewController){
        collections.forEach { collection in
            collection.delegate = context
            collection.dataSource = context
            collection.backgroundColor = UIColor.clear
            collection.backgroundView = UIView(frame: CGRect.zero)
            collection.showsHorizontalScrollIndicator = false
        }
    }
    

    func possibleRecommendation(){
        let hangoutAvarage: Double = Calculate.avarage(of: hangoutsDataSource) * 0.5
        print(hangoutAvarage)
        var newRecommendation: [Hangout] = []
        hangoutsDataSource.forEach{ hangout in
            let spent: Double = hangout.spent
            if spent < hangoutAvarage {
                newRecommendation.append(hangout)
            }
        }
        self.recommendationDataSource = newRecommendation
    }
    
    func reloadCollectionDataSource(){
        possibleRecommendation()
        collections.forEach { collection in
            collection.reloadData()
        }
    }
}
