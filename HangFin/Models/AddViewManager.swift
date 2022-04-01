//
//  ViewManager.swift
//  HangFin
//
//  Created by alexdamascena on 29/03/22.
//

import Foundation
import UIKit


class AddViewManager {
    
    let view: UIView
    
    init(observe view: UIView){
        self.view = view
    }
    
    func changeViewAfterAction(){
        self.view.isHidden = false
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(downGestureFired(_:)))
        gestureRecognizer.direction = .down
        gestureRecognizer.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(gestureRecognizer)
        self.view.isUserInteractionEnabled = true
    }
    
    @objc func downGestureFired(_ gesture: UISwipeGestureRecognizer){
        self.view.isHidden = true
    }
}
