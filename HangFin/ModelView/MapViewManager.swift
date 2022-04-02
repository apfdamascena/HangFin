//
//  MapViewManager.swift
//  HangFin
//
//  Created by alexdamascena on 31/03/22.
//

import Foundation
import MapKit

class MapViewManager {
    
    let map: MKMapView
    
    var coordinates : [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: -8.0499390, longitude: -34.9327235),
        CLLocationCoordinate2D(latitude: -8.0491845, longitude: -34.9313920)]
    
    init(observe map: MKMapView){
        self.map = map
    }
    
    func setup(context: ViewController){
        map.delegate = context
        let coordinateZoom = MKCoordinateSpan(latitudeDelta: MapConstants.ZOOM, longitudeDelta: MapConstants.ZOOM)
        map.setRegion(MKCoordinateRegion(center: coordinates[0],
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
    
    func createPin(_ coordinate: CLLocationCoordinate2D){
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = "Por onde você esteve"
        map.addAnnotation(pin)
    }
}
