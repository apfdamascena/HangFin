//
//  Map.swift
//  HangFin
//
//  Created by alexdamascena on 07/04/22.
//

import Foundation
import MapKit
import CoreLocation

class Map {

    func calculateDistance(between fromAdress: String, and destiny: String, distanceCompletionHandler: @escaping (Double?, Error?) -> Void){
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(fromAdress){ (placemarks: [CLPlacemark]?, error: Error?) in
            guard let placemarks = placemarks else {
                distanceCompletionHandler(nil, CalculateDistanceError.placemarksIsEmpty)
                return
            }
            
            let fromAdressStartPoint = placemarks[0]
            geocoder.geocodeAddressString(destiny, completionHandler: { (placemarks: [CLPlacemark]?, error: Error? ) in
                guard let placemarks = placemarks else {
                    distanceCompletionHandler(nil, CalculateDistanceError.placemarksIsEmpty)
                    return
                }
                let destinyAdressPoint = placemarks[0]
                self.distanceRoute(fromAdressStartPoint,
                                   to: destinyAdressPoint,
                                   distanceCompletionHandler)
            })
        }
    }
    
    func distanceRoute(_ fromAdressStartPoint: CLPlacemark ,
                       to destinyAdressPoint: CLPlacemark,
                       _ distanceRouteCompletionHandler: @escaping  (Double?, Error?) -> Void){
        
        guard let startCoordinate = fromAdressStartPoint.location,
              let endCoordinate = destinyAdressPoint.location else {
                  distanceRouteCompletionHandler(nil, RouteDistanceError.destinyAdressPointIsNull )
                  return
              }
        
        let startMapPlacemark = MKPlacemark(coordinate: startCoordinate.coordinate)
        let endMapPlacemark = MKPlacemark(coordinate: endCoordinate.coordinate)
        
        let start = MKMapItem(placemark: startMapPlacemark)
        let end = MKMapItem(placemark: endMapPlacemark)
        
        let requestDistance: MKDirections.Request = MKDirections.Request()
        requestDistance.source = start
        requestDistance.destination = end
        requestDistance.transportType = MKDirectionsTransportType.automobile
        let directions = MKDirections(request: requestDistance)
        directions.calculate(completionHandler: { (response: MKDirections.Response?, error: Error? ) in
            guard let routes = response?.routes else {
                distanceRouteCompletionHandler(nil, RouteDistanceError.routesResponseIsEmpty)
                return
            }
            
            let distance: Double = routes[0].distance
            let distanceInKM: Double = distance / 1000.0
            distanceRouteCompletionHandler(distanceInKM, nil)
        })
    }
    
}


// [ cards ] -> time = 2
//              time = 3

// check ou unchecked

// calcular

// let sum = 0
// passar por todos os cards e ver que quem ta check e se estiver checked -> sum += card.time

// valor de todos que foram checked
