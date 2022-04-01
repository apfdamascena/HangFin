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
        Hangout(date: "22/03/2913", spent: "1250.70"),
        Hangout(date: "22/03/2914", spent: "1250.70"),
        Hangout(date: "22/03/2915", spent: "1250.70"),
        Hangout(date: "22/03/2916", spent: "1250.70")]
    
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
    
    func construct(with collectionConstructer: UICollectionView, atIndex: IndexPath) -> ICell? {
        var cell: ICell? = nil
        collections.forEach{ collection in
            if collection == collectionConstructer {
                cell = (collection.dequeueReusableCell(withReuseIdentifier:
                                                        getIdentifierOf(collection)
                                                       , for: atIndex) as! ICell)
            }
        }
        return cell;
    }
    
    func getIdentifierOf(_ collection: UICollectionView) -> String {
        let identifier = collection.restorationIdentifier
        if identifier == "RecommendationsViewCell" {
            return RecommendationCell.identifier
        }
        return HangoutCell.identifier
            
    }
    
    func possibleRecommendation() -> [Hangout] {
        let hangoutAvarage: Double = Calculate.avarage(of: hangoutsDataSource)
        var newRecommendation: [Hangout] = []
        hangoutsDataSource.forEach{ hangout in
            let spent: Double = Double(hangout.spent) ?? 0.0
            if spent < hangoutAvarage {
                newRecommendation.append(hangout)
            }
        }
        self.recommendationDataSource = newRecommendation
        return newRecommendation
    }
    
    func countCell(in collectionView: UICollectionView) -> Int {
        if collectionView.restorationIdentifier == "RecommendationsViewCell" {
            return possibleRecommendation().count
        }
        return hangoutsDataSource.count
    }
}
