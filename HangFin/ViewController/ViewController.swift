//
//  ViewController.swift
//  HangFin
//
//  Created by alexdamascena on 25/03/22.
//

import UIKit
import MapKit
import CoreLocation

 
class ViewController: UIViewController {
    
    @IBOutlet weak var navbar: UIView!
    @IBOutlet weak var addView: UIView!
    
    @IBOutlet weak var lastHangouts: UICollectionView!
    @IBOutlet weak var hangoutRecommendation: UICollectionView!
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var fromAdress: UITextField!
    @IBOutlet weak var toDestiny: UITextField!
    @IBOutlet weak var foodSpent: UITextField!
    @IBOutlet weak var gasSpent: UITextField!
    
    @IBOutlet weak var lastHangoutsView: UIView!
    @IBOutlet weak var hangoutDetailsView: UIView!
    
    @IBOutlet weak var recommendationHangoutView: UIView!
    @IBOutlet weak var recommendationHangoutDetails: UIView!
    
    @IBOutlet weak var totalSpent: UILabel!
    
    @IBOutlet weak var totalHangout: UILabel!
    @IBOutlet weak var foodHangout: UILabel!
    @IBOutlet weak var gasHangout: UILabel!
    @IBOutlet weak var fromAdressHangout: UILabel!
    @IBOutlet weak var kmHangout: UILabel!
    @IBOutlet weak var destinyHangout: UILabel!
    @IBOutlet weak var dateHangout: UILabel!
    
    @IBOutlet weak var dateRecommendation: UILabel!
    @IBOutlet weak var totalRecommendation: UILabel!
    @IBOutlet weak var gasRecommendation: UILabel!
    @IBOutlet weak var foodRecommendation: UILabel!
    @IBOutlet weak var fromAdressRecommendation: MarginLabel!
    @IBOutlet weak var destinyRecommendation: MarginLabel!
    @IBOutlet weak var kmRecommendation: MarginLabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var addViewManager: AddViewManager = AddViewManager()
    var mapViewManager: MapViewManager = MapViewManager()
    var spentManager: SpentViewManager = SpentViewManager()
    var hangoutDetailsManager: HangoutDetailsViewManager = HangoutDetailsViewManager()
    var recommendationDetailsManager: HangoutDetailsViewManager = HangoutDetailsViewManager()
    let hangoutCollectionViewManager: HangoutCollectionViewManager = HangoutCollectionViewManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibAtCollectionsView()
        NavbarDrawer().draw(view: navbar)
        
        self.createManagers()
        self.setupManagers()
        self.addReferencesToManagers()

        self.mapViewManager.createAnnotations()
        self.spentManager.expenseAccount(of: hangoutCollectionViewManager.hangoutsDataSource)
    }
    
    func registerNibAtCollectionsView(){
        hangoutRecommendation.register(
            UINib(nibName: RecommendationCollectionViewCell.nib, bundle: nil),
            forCellWithReuseIdentifier: RecommendationCollectionViewCell.identifier)
        
        lastHangouts.register(
            UINib(nibName: HangoutCollectionViewCell.nib, bundle: nil),
            forCellWithReuseIdentifier: HangoutCollectionViewCell.identifier)
    }
    
    @IBAction func handleTapComeBackHangoutDetailsCard(_ sender: UIButton) {
        lastHangouts.isHidden = false
        self.hangoutDetailsManager.closeHangoutDetails()
    }
    
    @IBAction func handleTapComeBackRecommendationDetailsCard(_ sender: UIButton) {
        hangoutRecommendation.isHidden = false
        self.recommendationDetailsManager.closeHangoutDetails()
    }
    
    @IBAction func handleTapAddHangoutButton(_ sender: UIButton){
        self.loading.startAnimating()
        let hangout: Hangout? = self.addViewManager.createHangout()
        self.addViewManager.clearTextfields()
        guard let newHangout = hangout else { return }
        self.mapViewManager.map.calculateDistance(between: newHangout.fromAdress,
                                                  and: newHangout.fromDestiny,
                                                  distanceCompletionHandler: { (distance, error) in
            guard let distance = distance else { return }
            
            newHangout.km = distance
            self.hangoutCollectionViewManager.hangoutsDataSource.append(newHangout)
            self.hangoutCollectionViewManager.reloadCollectionDataSource()
            
            self.mapViewManager.addHangoutToMap(hangout: newHangout)
            self.addViewManager.closeAddView()
            self.spentManager.expenseAccount(of: self.hangoutCollectionViewManager.hangoutsDataSource)
            self.loading.stopAnimating()
        })
    }
    
    @IBAction func openAddViewAfterButtonTapped(_ sender: UIButton) {
        self.addViewManager.changeViewAfterAction()
    }
}




