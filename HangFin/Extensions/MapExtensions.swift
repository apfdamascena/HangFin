//
//  MapExtensions.swift
//  HangFin
//
//  Created by alexdamascena on 11/04/22.
//

import Foundation
import MapKit
import UIKit

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
