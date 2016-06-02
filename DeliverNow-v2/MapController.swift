//
//  MapController.swift
//  DeliverNow-v2
//
//  Created by 滕施男 on 1/06/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        
        
        // To get the most correct location.
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        
        // Don't want to updata location when the app is in the background, so did like this.
        self.locationManager.requestWhenInUseAuthorization()
        
        
        
        // Start updating the location now.
        self.locationManager.startUpdatingLocation()
        
        
        // The blue dot (user current location)
        self.mapView.showsUserLocation = true
    }
    
    /*
     Location Delegate Method
     */
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        // So we can get the latest location
//        let location = locations.last
//        // Make the location locates in the center at first
//        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
//        // Actually this is the circle to help zoom
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
//        self.mapView.setRegion(region, animated: true)
//        // Stop updating location
//        self.locationManager.stopUpdatingLocation()
        
        
        
        
        
        let location = "900 Dandenong Rd, Caulfield East VIC 3145";
        let geocoder:CLGeocoder = CLGeocoder();
        geocoder.geocodeAddressString(location) { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            if placemarks?.count > 0 {
                let topResult:CLPlacemark = placemarks![0];
                let placemark: MKPlacemark = MKPlacemark(placemark: topResult);
                
                var region: MKCoordinateRegion = self.mapView.region;
                region.center = (placemark.location?.coordinate)!;
                region.span.longitudeDelta /= 5.0;
                region.span.latitudeDelta /= 5.0;
                self.mapView.setRegion(region, animated: true);
                self.mapView.addAnnotation(placemark);
            }
        }
        
        
        
        
    }
    
    /*
     When an error appears, print the error
     */
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
    }
    
    /*
     Back to previous view.
     */
    @IBAction func backAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
