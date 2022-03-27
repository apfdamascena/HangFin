//
//  CollectionViewFactory.swift
//  HangFin
//
//  Created by alexdamascena on 26/03/22.
//
import UIKit
import Foundation

class CollectionViewFactory {
    
    static func select(_ collectionView: UICollectionView, isAt viewCells: [UICollectionView]) -> UICollectionView {
        
        let view: [UICollectionView] = viewCells.filter { viewCell in
            return viewCell == collectionView
        }
        
        return view[0]
    }
}
