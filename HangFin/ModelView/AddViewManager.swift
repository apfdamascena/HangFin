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
    
    var fromAdress: UITextField = UITextField()
    var toDestiny: UITextField = UITextField()
    var foodSpent: UITextField = UITextField()
    var gasSpent: UITextField = UITextField()
    var datePicker: UIDatePicker = UIDatePicker()
    
    init(observe view: UIView){
        self.view = view
    }
    
    init(){
        self.view = UIView()
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
    
    func addReferenceToViewManager(references fields: UITextField..., andAdd date: UIDatePicker){
        fromAdress = fields[AddViewManagerConstants.ADRESS]
        toDestiny = fields[AddViewManagerConstants.DESTINY]
        foodSpent = fields[AddViewManagerConstants.FOOD_SPENT]
        gasSpent = fields[AddViewManagerConstants.GAS_SPENT]
        datePicker = date
    }
    
    func createHangout() -> Hangout?  {
        guard let adress = fromAdress.text,
              let destiny = toDestiny.text,
              let food = foodSpent.text,
              let gas = gasSpent.text else { return nil }
        
        let parseFoodToNumber = Double(food) ?? 0
        let parseGasToNumber = Double(gas) ?? 0
        let sumGasAndFood = parseFoodToNumber + parseGasToNumber
        
        let date: String = transformDateToString()
            
        return Hangout(date: date,
                       fromAdress: adress,
                       fromDestiny: destiny,
                       spent: sumGasAndFood,
                       food: parseFoodToNumber,
                       gas: parseGasToNumber)
    }
    
    private func transformDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        let parseDateString = dateFormatter.string(from: self.datePicker.date)
        return parseDateString
    }
    
    func clearTextfields(){
        fromAdress.text = ""
        toDestiny.text = ""
        foodSpent.text = ""
        gasSpent.text = ""
        datePicker.setDate(Date.now, animated: false)
    }
}
