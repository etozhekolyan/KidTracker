//
//  KidPointAnnotationView.swift
//  KidTracker
//
//  Created by Nickolay Vasilchenko on 24.08.2023.
//

import UIKit
import MapKit

class KidPointAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
