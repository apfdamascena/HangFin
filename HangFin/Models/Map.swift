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
        let fromAdressWithState = fromAdress + " Recife - PE"
        let destinyWithState = destiny + " Recife - PE"
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(fromAdressWithState){ (placemarks: [CLPlacemark]?, error: Error?) in
            guard let placemarks = placemarks else {
                distanceCompletionHandler(nil, CalculateDistanceError.placemarksIsEmpty)
                return
            }
            
            let fromAdressStartPoint = placemarks[0]
            geocoder.geocodeAddressString(destinyWithState, completionHandler: { (placemarks: [CLPlacemark]?, error: Error? ) in
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
