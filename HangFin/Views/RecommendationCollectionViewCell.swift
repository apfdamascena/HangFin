//
//  RecommendationCollectionViewCell.swift
//  HangFin
//
//  Created by alexdamascena on 09/04/22.
//

import UIKit

class RecommendationCollectionViewCell: UICollectionViewCell, ICell {

    static let nib = "RecommendationCollectionViewCell"
    static let identifier = "RecommendationCell"

    @IBOutlet weak var dateRecommendation: UILabel!
    @IBOutlet weak var spentRecommendation: UILabel!
    @IBOutlet weak var kmRecommendation: UILabel!
    @IBOutlet weak var showDetailsRecommendation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func draw(_ hangout: Hangout) {
        dateRecommendation.text =  hangout.date
        spentRecommendation.text = "R$ \(hangout.spent)"
        showDetailsRecommendation.text = hangout.isDetailsOpen ? "Voltar" : "Ver detalhes"
        kmRecommendation.text = String(format: "%.1f km", hangout.km)
    }

}
