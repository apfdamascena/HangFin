//
//  RecommendationCell.swift
//  HangFin
//
//  Created by alexdamascena on 26/03/22.
//

import Foundation


import Foundation
import UIKit

class RecommendationCell: UICollectionViewCell, ICell {
    
    static let identifier = "RecommendationsViewCell"
    
    @IBOutlet weak var dateRecommendation: UILabel!
    @IBOutlet weak var spentRecommendation: UILabel!
    @IBOutlet weak var detailsRecommendation: UILabel!
    
    
    func draw(_ hangout: Hangout) {
        dateRecommendation.text = hangout.date
        spentRecommendation.text = "R$ \(hangout.spent)"
        detailsRecommendation.text = hangout.isDetailsOpen ? "Voltar" : "Ver detalhes"
    }
}
