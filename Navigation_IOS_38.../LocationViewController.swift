//
//  LocationViewController.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 08.02.2024.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        manager.requestWhenInUseAuthorization()
        
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    func checkLocationPermission() {
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
        
        if manager.authorizationStatus == .denied {
            
        }
    }
    
    @IBAction func pushSPBAction(_ sender: Any) {
        let coordinate = CLLocationCoordinate2D(latitude: 55.7522, longitude: 37.6156)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
}




extension LocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
    }
}
    
    
    
    
    
    
    
    

