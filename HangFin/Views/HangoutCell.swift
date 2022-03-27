//
//  HangoutCell.swift
//  HangFin
//
//  Created by alexdamascena on 25/03/22.
//

import Foundation
import UIKit

class HangoutCell: UICollectionViewCell, ICell {
    
    static let identifier = "HangoutViewCell";
    
    @IBOutlet weak var dateHangout: UILabel!
    @IBOutlet weak var spentHangout: UILabel!
    @IBOutlet weak var detailsHangout: UILabel!
    
    
    func draw(_ hangout: Hangout) {
        dateHangout.text = hangout.date
        spentHangout.text = "R$ \(hangout.spent)"
        detailsHangout.text = hangout.isDetailsOpen ? "Voltar" : "Ver detalhes"
    }
}




