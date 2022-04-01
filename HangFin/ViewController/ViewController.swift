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
    
    @IBOutlet weak var footer: UIView!
    @IBOutlet weak var addView: UIView!
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var lastHangouts: UICollectionView!
    @IBOutlet weak var hangoutRecommendation: UICollectionView!
        
    var collectionsView: [UICollectionView] = []
    let coordinates : [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 40.728, longitude: -74),
        CLLocationCoordinate2D(latitude: 41.728, longitude: -72)]
    
    var addViewManager: AddViewManager = AddViewManager(observe: UIView())
    var mapViewManager: MapViewManager = MapViewManager(observe: MKMapView())
    
    let hangoutCollectionViewManager: HangoutCollectionViewManager = HangoutCollectionViewManager()
    let cellDrawer: CellDrawer = CellDrawer()


    override func viewDidLoad() {
        super.viewDidLoad()
        FooterDrawer().draw(view: footer)
        self.addViewManager = AddViewManager(observe: addView)
        self.hangoutCollectionViewManager.add(view: lastHangouts)
        self.hangoutCollectionViewManager.add(view: hangoutRecommendation)
        self.hangoutCollectionViewManager.setup(context: self)
//        self.mapViewManager.setup(context: self)
        
    }
    
    @IBAction func addHangout(_ sender: UIButton) {
        self.addViewManager.changeViewAfterAction()
    }
                    
//    func setupMap(){
//        map.delegate = self
//        map.setRegion(MKCoordinateRegion(center: coordinates[0], span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: false)
//
//        coordinates.forEach { coordinate in
//            let pin = MKPointAnnotation()
//            pin.coordinate = coordinate
//            pin.title = "Por onde você esteve"
//            map.addAnnotation(pin)
//        }
//    }
}


//extension ViewController: MKMapViewDelegate {
//
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard !(annotation is MKUserLocation) else { return nil }
//        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: "CustomMap")
//
//        if annotationView == nil {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "CustomMap")
//        } else {
//            annotationView?.annotation = annotation
//            annotationView?.canShowCallout = true
//        }
//
//        annotationView?.image = UIImage(named: "GreenCard")
//        return annotationView
//    }
//
//}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hangoutCollectionViewManager.hangoutsDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ICell? = hangoutCollectionViewManager.construct(with: collectionView, atIndex: indexPath);
        guard let cellToConstruct = cell else { return  UICollectionViewCell() }
        let newCell = cellDrawer.draw(cellToConstruct, with: hangoutCollectionViewManager.hangoutsDataSource
                                        , atIndex: indexPath)
        return newCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}




