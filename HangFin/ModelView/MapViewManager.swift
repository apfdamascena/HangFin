//
//  MapViewManager.swift
//  HangFin
//
//  Created by alexdamascena on 31/03/22.
//

import Foundation
import MapKit
import CoreLocation

class MapViewManager {
    
    let mapView: MKMapView
    let map: Map = Map()
    
    var coordinates : [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: -8.0491845, longitude: -34.9313920)
    ]
    
    init(observe map: MKMapView){
        self.mapView = map
    }
    
    func setup(context: ViewController){
        mapView.delegate = context
        let coordinateZoom = MKCoordinateSpan(latitudeDelta: MapConstants.ZOOM, longitudeDelta: MapConstants.ZOOM)
        mapView.setRegion(MKCoordinateRegion(center: coordinates[0],
                                         
                                         span: coordinateZoom),
                                         animated: false)
    }
    
    
    func add(coordinate: CLLocationCoordinate2D){
        coordinates.append(coordinate)
    }
    
    func createAnnotations(){
        coordinates.forEach { coordinate in
            createPin(coordinate)
        }
    }
    
    func addHangoutToMap(hangout: Hangout){
        
        let adress: String = hangout.fromAdress
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(adress) { (placemarks, error) in
            
            guard let placemarks = placemarks, let location = placemarks.first?.location else { return }
            let location2D: CLLocationCoordinate2D  = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            self.createPin(location2D)
            self.mapView.reloadInputViews()
        }
    }
    
    func createPin(_ coordinate: CLLocationCoordinate2D){
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = "Por onde você esteve"
        mapView.addAnnotation(pin)
    }
}
