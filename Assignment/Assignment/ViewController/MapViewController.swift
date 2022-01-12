//
//  MapViewController.swift
//  Assignment
//
//  Created by Banana on 12/1/2022.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    // how big we can see on map
    let regionInMeters: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        // check service eg. permission
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {

        }
        
    }
    
    func centerViewOnUserLocation() {
        // showing user's location with blue dot
        if let location = locationManager.location?.coordinate {
            let area = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(area, animated: true)
        }
    }
    
    func checkLocationAuthorization() {
        // check authorization status
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            //showing user location with blue dot
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // turn on permissions instruction
            break
        case .notDetermined:
            //not determind, ask permissions
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
            //get your location when app is in background
        case .authorizedAlways:
            break
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return }
        let area = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(area, animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // authentication changed and get permission from user again start from line 47
        checkLocationAuthorization()
    }
}
