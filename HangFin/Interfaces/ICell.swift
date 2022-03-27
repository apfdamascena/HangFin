//
//  ICell.swift
//  HangFin
//
//  Created by alexdamascena on 26/03/22.
//

import Foundation
import UIKit



protocol ICell: UICollectionViewCell {
    
    func draw(_ hangout: Hangout);
}
