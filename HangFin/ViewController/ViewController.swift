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
    
    @IBOutlet weak var totalSpent: UILabel!
    @IBOutlet weak var totalHangout: UILabel!
    @IBOutlet weak var foodHangout: UILabel!
    @IBOutlet weak var gasHangout: UILabel!
    @IBOutlet weak var fromAdressHangout: UILabel!
    @IBOutlet weak var kmHangout: UILabel!
    @IBOutlet weak var destinyHangout: UILabel!
    @IBOutlet weak var dateHangout: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var collectionsView: [UICollectionView] = []

    var addViewManager: AddViewManager = AddViewManager()
    var mapViewManager: MapViewManager = MapViewManager()
    var spentManager: SpentViewManager = SpentViewManager()
    var hangoutDetailsManager: HangoutDetailsViewManager = HangoutDetailsViewManager()
    let hangoutCollectionViewManager: HangoutCollectionViewManager = HangoutCollectionViewManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibAtCollectionsView()
        
        NavbarDrawer().draw(view: navbar)
        self.addViewManager = AddViewManager(observe: addView)
        self.mapViewManager = MapViewManager(observe: map)
        self.spentManager = SpentViewManager(observe: totalSpent)
        self.hangoutDetailsManager = HangoutDetailsViewManager(observe: lastHangoutsView, hangoutDetailsView)
        
        self.hangoutCollectionViewManager.add(view: lastHangouts)
        self.hangoutCollectionViewManager.add(view: hangoutRecommendation)
        
        self.hangoutCollectionViewManager.setup(context: self)
        self.mapViewManager.setup(context: self)
        
        self.mapViewManager.createAnnotations()
        self.spentManager.expenseAccount(of: hangoutCollectionViewManager.hangoutsDataSource)
        
        self.addViewManager
            .addReferenceToViewManager(references: fromAdress,
                                       toDestiny, foodSpent, gasSpent,
                                       andAdd: datePicker)
        self.hangoutDetailsManager
            .addReferenceToViewManager(references: dateHangout, totalHangout, foodHangout,
                                                   gasHangout, fromAdressHangout, destinyHangout,
                                                   kmHangout)
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

extension ViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: MapConstants.IDENTIFIER)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation,
                                              reuseIdentifier: MapConstants.IDENTIFIER)
        } else {
            annotationView?.annotation = annotation
            annotationView?.canShowCallout = true
        }

        annotationView?.image = UIImage(named: MapConstants.PIN_IMAGE)
        return annotationView
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == lastHangouts ?
                hangoutCollectionViewManager.hangoutsDataSource.count :
                hangoutCollectionViewManager.recommendationDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = collectionView == lastHangouts ?
            HangoutCollectionViewCell.identifier : RecommendationCollectionViewCell.identifier
        let dataSource = collectionView == lastHangouts ?
            hangoutCollectionViewManager.hangoutsDataSource : hangoutCollectionViewManager.recommendationDataSource
        
        let cell: ICell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ICell
        let hangout = dataSource[indexPath.row]
        cell.draw(hangout)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {        
        lastHangouts.isHidden = true
        let index = indexPath.row
        let hangout: Hangout = hangoutCollectionViewManager.hangoutsDataSource[index]
        self.hangoutDetailsManager.draw(hangout)
    }
    
}




