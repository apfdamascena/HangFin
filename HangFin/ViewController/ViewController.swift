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
    
    var  hangouts: [Hangout] = [
        Hangout(date: "22/03/2913", spent: "1250,70"),
        Hangout(date: "22/03/2914", spent: "1250,70"),
        Hangout(date: "22/03/2915", spent: "1250,70"),
        Hangout(date: "22/03/2916", spent: "1250,70")
    ]
    private var collectionsView: [UICollectionView] = []
    let coordinate = CLLocationCoordinate2D(latitude: 40.728, longitude: -74)
    
    @IBOutlet weak var lastHangoutCollection: UICollectionView!
    @IBOutlet weak var recommendationHangoutCollection: UICollectionView!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var addView: UIView!
    
    @IBAction func addHangout(_ sender: UIButton) {
        self.addView.isHidden = false
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(downGestureFired(_:)))
        gestureRecognizer.direction = .down
        gestureRecognizer.numberOfTouchesRequired = 1
        self.addView.addGestureRecognizer(gestureRecognizer)
        self.addView.isUserInteractionEnabled = true
    }
    
    @objc func downGestureFired(_ gesture: UISwipeGestureRecognizer){
        self.addView.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionsView = [
            lastHangoutCollection,
            recommendationHangoutCollection
        ]
        setupCollectionsView()
        map.delegate = self
        setupMap()
    }
    
    func setupCollectionsView() -> Void {
        collectionsView.forEach { collection in
            collection.delegate = self
            collection.dataSource = self
            collection.backgroundColor = UIColor.clear
            collection.backgroundView = UIView(frame: CGRect.zero)
            collection.showsHorizontalScrollIndicator = false
        }

    }
        
    func setupMap(){
        map.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: false)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = "Opa"
        pin.subtitle = "tou aqui"
        map.addAnnotation(pin)
    }
    
}


extension ViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: "CustomMap")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "CustomMap")
            
        } else {
            annotationView?.annotation = annotation
            annotationView?.canShowCallout = true
        }
        
        annotationView?.image = UIImage(named: "GreenCard")
        
        return annotationView
    }
    
}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return hangouts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let collection: UICollectionView = CollectionViewFactory.select(collectionView, isAt: self.collectionsView)
        
        let cell: ICell = collection.dequeueReusableCell(withReuseIdentifier:
                                        collectionView == lastHangoutCollection ?
                                        HangoutCell.identifier : RecommendationCell.identifier
                                        , for: indexPath) as! ICell
        
        let index = indexPath.row
        cell.draw(hangouts[index])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}




