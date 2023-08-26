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
    private let kidsData = [
        KidModel(name: "Илюша", image: "image1", location: CLLocationCoordinate2D(latitude: 37.786872, longitude:  -122.406117)),
        KidModel(name: "Гриша", image: "image2", location: CLLocationCoordinate2D(latitude: 37.786468, longitude:  -122.406719)),
        KidModel(name: "Пашок", image: "image3", location: CLLocationCoordinate2D(latitude: 37.786651, longitude:  -122.405191))
    ]
//MARK: - VC life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        kidTrackerView.hundlerDeleagte = self
        kidTrackerView.transferKidsData(kidsData: kidsData)
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
