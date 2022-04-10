//
//  HangoutCollectionViewCell.swift
//  HangFin
//
//  Created by alexdamascena on 09/04/22.
//

import UIKit

class HangoutCollectionViewCell: UICollectionViewCell, ICell {
        
    static let nib = "HangoutCollectionViewCell"
    static let identifier = "HangoutCell"
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var spent: UILabel!
    @IBOutlet weak var showDetails: UILabel!
    
    @IBOutlet weak var width: NSLayoutConstraint!
    @IBOutlet weak var height: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func draw(_ hangout: Hangout) {
        date.text =  hangout.date
        spent.text = "R$ \(hangout.spent)"
        showDetails.text = hangout.isDetailsOpen ? "Voltar" : "Ver detalhes"

    }
}
