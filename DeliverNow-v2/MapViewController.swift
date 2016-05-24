//
//  MapViewController.swift
//  DeliverNow-v2
//
//  Created by 滕施男 on 19/05/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var alertView = UIAlertView(title: "Hello!", message: "Please wait for a while...", delegate: nil, cancelButtonTitle: "Got it")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertView.show()
        
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
    
    // Location Delegate Method
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // So we can get the latest location
        let location = locations.last
        // Make the location locates in the center at first
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        // Actually this is the circle to help zoom
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
        
        self.mapView.setRegion(region, animated: true)
        // Stop updating location
        self.locationManager.stopUpdatingLocation()
        
    }
    
    /*
     When an error appears, print the error
     */
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
    }
    @IBAction func backAction(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
