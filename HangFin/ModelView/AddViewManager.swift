//
//  ViewManager.swift
//  HangFin
//
//  Created by alexdamascena on 29/03/22.
//

import Foundation
import UIKit


class AddViewManager{
    
    let view: UIView
    
    var fromAdress: UITextField!
    var toDestiny: UITextField!
    var foodSpent: UITextField!
    var gasSpent: UITextField!
    
    init(observe view: UIView){
        self.view = view
    }
    
    func changeViewAfterAction(){
        self.view.isHidden = false
        self.view.center.y += self.view.bounds.maxY
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseIn,
            animations: { self.view.center.y -= self.view.bounds.maxY })
        
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(downGestureFired(_:)))
        gestureRecognizer.direction = .down
        gestureRecognizer.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(gestureRecognizer)
        self.view.isUserInteractionEnabled = true
    }
    
    @objc func downGestureFired(_ gesture: UISwipeGestureRecognizer){
        closeAddView()
    }
    
    func closeAddView(){
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: { self.view.center.y += (self.view.bounds.maxY + 100)},
            completion: {_ in
            self.view.center.y -= (self.view.bounds.maxY + 100)
            self.view.isHidden = true
        })
    }
    
    
    func addReferenceToViewManager(references fields: UITextField...){
        fromAdress = fields[AddViewManagerConstants.ADRESS]
        toDestiny = fields[AddViewManagerConstants.DESTINY]
        foodSpent = fields[AddViewManagerConstants.FOOD_SPENT]
        gasSpent = fields[AddViewManagerConstants.GAS_SPENT]
    }
    
    func createHangout() -> Hangout?  {
        guard let adress = fromAdress.text,
              let destiny = toDestiny.text,
              let food = foodSpent.text,
              let gas = gasSpent.text else { return nil }
        
        let parseFoodToNumber = Double(food) ?? 0
        let parseGasToNumber = Double(gas) ?? 0
        let sumGasAndFood = parseFoodToNumber + parseGasToNumber
        return Hangout(date: "13/13/2013",
                       fromAdress: adress,
                       fromDestiny: destiny,
                       spent: sumGasAndFood,
                       food: parseFoodToNumber,
                       gas: parseGasToNumber)
        
    }
}
