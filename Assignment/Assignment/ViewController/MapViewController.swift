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
    
    @IBOutlet weak var addressLabel: UILabel!
    
    let locationManager = CLLocationManager()
    // how big we can see on map
    let regionInMeters: Double = 10000
    
    var previousLocation: CLLocation?
    
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
            startTackingUserLocation()
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
        @unknown default:
            break
        }
        
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        //create latitude and longitude based on center
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func startTackingUserLocation() {
        // showing user location with blue dot
        mapView.showsUserLocation = true
        // user in center
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // authentication changed and it will ask permissions from user again start from line 47
        checkLocationAuthorization()
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        // get address from lat and long
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else {
            return }
        
        guard center.distance(from: previousLocation) > 50 else {
            return }
        
        self.previousLocation = center
        // error checking
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else {
                return }
            
            if let _ = error {
                //TODO: Show alert
                return
            }
            
            guard let mark = placemarks?.first else {
                //TODO: Show alert
                return
            }
            // showing street name and number
            let streetName = mark.thoroughfare ?? ""
            let streetNumber = mark.subThoroughfare ?? ""
            
            DispatchQueue.main.async {
                self.addressLabel.text = "\(streetNumber) \(streetName)"
            }
        }
    }
}
