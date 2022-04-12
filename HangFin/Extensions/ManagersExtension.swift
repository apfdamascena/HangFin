//
//  ManagersExtension.swift
//  HangFin
//
//  Created by alexdamascena on 11/04/22.
//

import Foundation


extension ViewController {
    
    func createManagers(){
        self.addViewManager = AddViewManager(observe: addView)
        self.mapViewManager = MapViewManager(observe: map)
        self.spentManager = SpentViewManager(observe: totalSpent)
        self.hangoutDetailsManager = HangoutDetailsViewManager(observe: lastHangoutsView, hangoutDetailsView)
        self.recommendationDetailsManager = HangoutDetailsViewManager(observe: recommendationHangoutView, recommendationHangoutDetails)
    }
    
    func setupManagers(){
        self.hangoutCollectionViewManager.add(view: lastHangouts)
        self.hangoutCollectionViewManager.add(view: hangoutRecommendation)
        self.hangoutCollectionViewManager.setup(context: self)
        self.mapViewManager.setup(context: self)
    }
    
    func addReferencesToManagers(){
        self.addViewManager.addReferenceToViewManager(references: fromAdress, toDestiny, foodSpent, gasSpent,
                                                      andAdd: datePicker)
        self.hangoutDetailsManager.addReferenceToViewManager(references: dateHangout, totalHangout, foodHangout,gasHangout, fromAdressHangout, destinyHangout, kmHangout)
        self.recommendationDetailsManager.addReferenceToViewManager(references: dateRecommendation, totalRecommendation, foodRecommendation, gasRecommendation, fromAdressRecommendation, destinyRecommendation, kmRecommendation)
    }
}
