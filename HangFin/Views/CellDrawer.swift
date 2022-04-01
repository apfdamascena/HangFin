//
//  CellDrawer.swift
//  HangFin
//
//  Created by alexdamascena on 31/03/22.
//

import Foundation

class CellDrawer {
    
    func draw(_ cell: ICell, with collections: [Hangout], atIndex indexPath: IndexPath) -> ICell {
        let index = indexPath.row
        let hangout = collections[index]
        cell.draw(hangout)
        return cell
    }
}
