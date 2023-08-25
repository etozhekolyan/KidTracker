//
//  ViewController.swift
//  KidTracker
//
//  Created by Nickolay Vasilchenko on 23.08.2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
//MARK: - Objects
    private let kidTrackerView = KidTrackerView()
    private let locationManager = LocationManager()
    private let kidLocation = CLLocationCoordinate2D(latitude: 37.785520, longitude:  -122.406608)
//MARK: - VC life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        kidTrackerView.hundlerDeleagte = self
    }

    override func loadView() {
        super.loadView()
        self.view = kidTrackerView
    }
}
//MARK: - ButtonHundlerDelegate
extension ViewController: ButtonHundlerDelegate {

    func hundleLocationButtonPress() {
        locationManager.startUpdating()
        guard let locationCoor = locationManager.getCurrentCoordinates() else { return }
        kidTrackerView.setCurrentCoordinatesForMap(centerCoordinates: locationCoor)
        kidTrackerView.putThePointKidCurrentLocation(centerCoordinates: kidLocation)
        locationManager.stopUpdating()
    }
    
    func zoomInMap() {
        var region = kidTrackerView.mapView.region
        region.span.latitudeDelta /= 2.0
        region.span.longitudeDelta /= 2.0
        kidTrackerView.mapView.setRegion(region, animated: true)
    }
    
    func zoomOutMap() {
        var region = kidTrackerView.mapView.region
        region.span.latitudeDelta *= 2.0
        region.span.longitudeDelta *= 2.0
        kidTrackerView.mapView.setRegion(region, animated: true)
    }
    
    func showNextTracker() {
        // later
    }
}

struct KidModel {
    var name: String
    var image: String
    var location: CLLocationCoordinate2D
}
