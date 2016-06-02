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
    
    var customerLivingAddress: String?
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
        let location = customerLivingAddress!;
        let geocoder:CLGeocoder = CLGeocoder();
        geocoder.geocodeAddressString(location) { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            if placemarks?.count > 0 {
                let topResult:CLPlacemark = placemarks![0];
                let placemark: MKPlacemark = MKPlacemark(placemark: topResult);
                let region: MKCoordinateRegion = self.mapView.region;
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
