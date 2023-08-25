//
//  KidTrackerView.swift
//  KidTracker
//
//  Created by Nickolay Vasilchenko on 23.08.2023.
//

import UIKit
import MapKit

//The entire logical part is stored in the ViewController.
//This delegate helps the ViewController handle button presses.
//The View and the ViewController refer to each other by a weak reference, there should be no memory leaks
//Whole buttons logic stores into ViewController
protocol ButtonHundlerDelegate: AnyObject {
    func hundleLocationButtonPress()
    func zoomInMap()
    func zoomOutMap()
    func showNextTracker()
}

class KidTrackerView: UIView {
//MARK: - Objects and UIelements
    public weak var hundlerDeleagte: ButtonHundlerDelegate?
    private var annotationPoint = MKPointAnnotation()
    private var descriptionView = DescriptionPointView()
    private var kidsPoints: [MKPointAnnotation]?

    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        return mapView
    }()
    
    

    private var locationButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "myLocationLight")
        button.setImage(image, for: .normal)
        return button
    }()

    private var zoomInButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "zoomIn")
        button.setImage(image, for: .normal)
        button.tag = 0
        return button
    }()

    private var zoomOutButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "zoomOut")
        button.setImage(image, for: .normal)
        button.tag = 1
        return button
    }()

    // The button that switch between tracking kids
    private var nextTrackerButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "nextTracker")
        button.setImage(image, for: .normal)
        return button
    }()
//MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        mapView.delegate = self
        fillHierarchy()
        addTargets()
        setLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: - View preparation
    private func fillHierarchy() {
        self.addSubview(mapView)
        [locationButton,
         zoomInButton,
         zoomOutButton,
         nextTrackerButton,
         descriptionView
        ].forEach {mapView.addSubview($0)}
    }
    
    private func setLayouts() {
        mapView.fillSuperView()
        zoomInButton.setAnchors(top: mapView.topAnchor, botton: nil , left: nil, right: mapView.trailingAnchor,
                                  padding: .init(top: 200, left: 0, bottom: 0, right: 10),
                                  size: .init(width: 50, height: 50))
        zoomOutButton.setAnchors(top: zoomInButton.topAnchor, botton: nil, left: nil, right: zoomInButton.trailingAnchor,
                                 padding: .init(top: 60, left: 0, bottom: 0, right: 0),
                                 size: .init(width: 50, height: 50))
        locationButton.setAnchors(top: zoomOutButton.topAnchor, botton: nil, left: nil, right: zoomOutButton.trailingAnchor,
                                  padding: .init(top: 60, left: 0, bottom: 0, right: 0),
                                  size: .init(width: 50, height: 50))
        nextTrackerButton.setAnchors(top: locationButton.topAnchor, botton: nil, left: nil, right: locationButton.trailingAnchor,
                                     padding: .init(top: 60, left: 0, bottom: 0, right: 0),
                                     size: .init(width: 50, height: 50))
        descriptionView.setAnchors(top: nil, botton: mapView.bottomAnchor, left: mapView.leadingAnchor, right: mapView.trailingAnchor,
                                   padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                                   size: .init(width: mapView.frame.width, height: 250))
    }

    private func addTargets() {
        locationButton.addTarget(self, action: #selector(hundleLocationButton), for: .touchUpInside)
        zoomInButton.addTarget(self, action: #selector(hundleZoomButtons), for: .touchUpInside)
        zoomOutButton.addTarget(self, action: #selector(hundleZoomButtons), for: .touchUpInside)
    }
    
    private func configureAnnotationsPoints(kidsData: [KidModel]) {
        for kidData in kidsData {
            var kidPoint = MKPointAnnotation()
            kidPoint.coordinate = kidData.location
            kidPoint.title = kidData.name
        }
    }
//MARK: - Public interface
    public func setCurrentCoordinatesForMap(centerCoordinates: CLLocationCoordinate2D?) {
        guard let coordinates = centerCoordinates else { return }
        let region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
    public func putThePointKidCurrentLocation(centerCoordinates: CLLocationCoordinate2D?) {
        guard let centerCoordinates = centerCoordinates else { return }
        annotationPoint.coordinate = centerCoordinates
        mapView.addAnnotation(annotationPoint)
    }

    public func transferKidsData(kidsData: [KidModel]) {
        
    }
//MARK: - ButtonHundlers
    @objc func hundleLocationButton(_ sender: UIButton) {
        hundlerDeleagte?.hundleLocationButtonPress()
    }

    @objc func hundleZoomButtons(_ sender: UIButton) {
        if sender.tag == 0 {
            hundlerDeleagte?.zoomInMap()
        } else {
            hundlerDeleagte?.zoomOutMap()
        }
    }

    @objc func hundleNextTrackerButton(_ sender: UIButton) {
        hundlerDeleagte?.showNextTracker()
    }
}
//MARK: - Extension MKMapViewDelegate
extension KidTrackerView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
        } else {
            annotationView?.annotation = annotation
        }
        let pinImage = UIImage(named: "pointer")
        let size = CGSize(width: 50, height: 50)
        UIGraphicsBeginImageContext(size)
        pinImage?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        annotationView?.image = resizedImage
        annotationView?.centerOffset = CGPoint(x: 0, y: -size.height / 2) // Adjust according to your needs
        
        return annotationView
    }
}
