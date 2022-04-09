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
    
    var collectionsView: [UICollectionView] = []

    var addViewManager: AddViewManager = AddViewManager(observe: UIView())
    var mapViewManager: MapViewManager = MapViewManager(observe: MKMapView())
    let hangoutCollectionViewManager: HangoutCollectionViewManager = HangoutCollectionViewManager()
    let cellDrawer: CellDrawer = CellDrawer()

    override func viewDidLoad() {
        super.viewDidLoad()
        NavbarDrawer().draw(view: navbar)
        self.addViewManager = AddViewManager(observe: addView)
        self.mapViewManager = MapViewManager(observe: map)
        
        self.hangoutCollectionViewManager.add(view: lastHangouts)
        self.hangoutCollectionViewManager.add(view: hangoutRecommendation)
        
        self.hangoutCollectionViewManager.setup(context: self)
        self.mapViewManager.setup(context: self)
        
        self.mapViewManager.createAnnotations()
        self.addViewManager.addReferenceToViewManager(references: [
            fromAdress, toDestiny, foodSpent, gasSpent])
    }
        
    @IBAction func handleTapAddHangoutButton(_ sender: UIButton){
        let hangout: Hangout? = self.addViewManager.createHangout()
        guard let newHangout = hangout else { return }
        self.mapViewManager.map.calculateDistance(between: newHangout.fromAdress,
                                                  and: newHangout.fromDestiny,
                                                  distanceCompletionHandler: { (distance, error) in
            guard let distance = distance else { return }
            newHangout.km = distance
            self.hangoutCollectionViewManager.hangoutsDataSource.append(newHangout)
            self.addViewManager.closeAddView()
            self.hangoutCollectionViewManager.reloadCollectionDataSource()
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
        let identifier = collectionView == lastHangouts ? HangoutCell.identifier : RecommendationCell.identifier
        let dataSource = collectionView == lastHangouts ?
            hangoutCollectionViewManager.hangoutsDataSource: hangoutCollectionViewManager.recommendationDataSource
        
        let cell: ICell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ICell
        let hangout = dataSource[indexPath.row]
        cell.draw(hangout)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}




