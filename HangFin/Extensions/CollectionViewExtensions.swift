//
//  CollectionViewExtensions.swift
//  HangFin
//
//  Created by alexdamascena on 11/04/22.
//

import Foundation
import UIKit

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == lastHangouts ?
                hangoutCollectionViewManager.hangoutsDataSource.count :
                hangoutCollectionViewManager.recommendationDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = collectionView == lastHangouts ?
            HangoutCollectionViewCell.identifier : RecommendationCollectionViewCell.identifier
        let dataSource = collectionView == lastHangouts ?
            hangoutCollectionViewManager.hangoutsDataSource : hangoutCollectionViewManager.recommendationDataSource
        
        let cell: ICell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ICell
        let hangout = dataSource[indexPath.row]
        cell.draw(hangout)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dataSource = collectionView == lastHangouts ?
            hangoutCollectionViewManager.hangoutsDataSource : hangoutCollectionViewManager.recommendationDataSource
        let index = indexPath.row
        let hangout = dataSource[index]
        
        if collectionView == lastHangouts {
            lastHangouts.isHidden = true
            self.hangoutDetailsManager.draw(hangout)
        } else {
            hangoutRecommendation.isHidden = true
            self.recommendationDetailsManager.draw(hangout)
        }
    }
}
