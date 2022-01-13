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
    
    @IBOutlet weak var goButton: UIButton!
    
    @IBAction func backMapButton(_ sender: Any) {
        //back to home
        let mapViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        self.view.window?.rootViewController = mapViewController
        self.view.window?.makeKeyAndVisible()
    }
    let locationManager = CLLocationManager()
    // how big we can see on map
    let regionInMeters: Double = 10000
    
    var previousLocation: CLLocation?
    var directionsArray: [MKDirections] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goButton.layer.cornerRadius = goButton.frame.size.height/2
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
    
    func getDirections() {
        // make sure we have user's location
        guard let location = locationManager.location?.coordinate else {
            //TODO: tell user we don't have current location
            return
        }
        
        let request = createDirectionsRequest(from: location)
        // provide walking directions
        let directions = MKDirections(request: request)
        // recreate new polyline
        resetMapView(withNew: directions)
        
        directions.calculate { [unowned self] (response, error) in
            //TODO: Handle error if needed
            guard let response = response else {
                return }
            //TODO: Show response in an alert
            
            for route in response.routes {
                // the line on map taht you're going to add
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
        // landscape mode
//        super.viewWillAppear(animated)
//        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
//    }
//    override open var shouldAutorotate: Bool {
//        return false
//    }
//    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .landscapeLeft
//    }
    
//    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//        return .landscapeLeft
//    }
    
//    extension MapViewController {
//        override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//           return topViewController?.supportedInterfaceOrientations ?? .allButUpsideDown
//        }
//    }
    
    func createDirectionsRequest(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        // center of map
        let destinationCoordinate       = getCenterLocation(for: mapView).coordinate
        let startingLocation            = MKPlacemark(coordinate: coordinate)
        let destination                 = MKPlacemark(coordinate: destinationCoordinate)
        
        let request                     = MKDirections.Request()
        request.source                  = MKMapItem(placemark: startingLocation)
        request.destination             = MKMapItem(placemark: destination)
        request.transportType           = .automobile
        request.requestsAlternateRoutes = true
        
        return request
    }
    
    func resetMapView(withNew directions: MKDirections) {
        mapView.removeOverlays(mapView.overlays)
        directionsArray.append(directions)
        let _ = directionsArray.map { $0.cancel()
        }
        
    }
    
    @IBAction func goButtonTapped(_ sender: Any) {
        getDirections()
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
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .red
        
        return renderer
    }
    
}
