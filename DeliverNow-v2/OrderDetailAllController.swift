//
//  OrderDetailAllController.swift
//  DeliverNow-v2
//
//  Created by 滕施男 on 1/06/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class OrderDetailAllController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var eatWhatLabel: UILabel!
    @IBOutlet var rAddLabel: UILabel!
    @IBOutlet var cAddLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var contactLabel: UILabel!
    @IBOutlet var tipLabel: UILabel!
    
    @IBOutlet var mapView: MKMapView!
    
    var order: UserOrders?
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
     Set labels.
     */
    func setLabels() -> Void {
        eatWhatLabel.text = order?.eatWhat
        rAddLabel.text = order?.restaurantAddress
        cAddLabel.text = order?.livingAddress
        nameLabel.text = order?.userName
        contactLabel.text = order?.contact
        tipLabel.text = order?.tip
    }
    
    /*
     Location Delegate Method
     */
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
    
    @IBAction func backAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
