//
//  LocationManager.swift
//  KidTracker
//
//  Created by Nickolay Vasilchenko on 23.08.2023.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {
//MARK: - Objects
    private let locationManager: CLLocationManager
    //coordinates returns from CLLocationManager
    private var currentLocation: CLLocationCoordinate2D?
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
//MARK: - public interface
    public func startUpdating() {
        locationManager.startUpdatingLocation()
    }
    
    public func stopUpdating() {
        locationManager.stopUpdatingLocation()
    }
    
    public func getCurrentCoordinates() -> CLLocationCoordinate2D? {
        return currentLocation
    }
}
//MARK: - Extension CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        currentLocation = center
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Access")
            // If authorized, update the location.
            locationManager.startUpdatingLocation()
        case .denied:
            print("Denied Access")
            // If denied, stop all location updates.
            locationManager.stopUpdatingLocation()
        case .notDetermined:
            print("Not Determined")
            // If the user has not yet made a choice regarding the app's use of location services, then request authorization.
            locationManager.requestWhenInUseAuthorization()
        default:
            print("Unknown")
            // If the status is anything else, stop all location updates.
            locationManager.stopUpdatingLocation()
        }
    }
    
    
}
