//
//  ViewController.swift
//  Threads
//
//  Created by cci-loaner on 9/7/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as? CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        let locValue = locationManager.location?.coordinate
        print("locations = \(String(describing: locValue?.latitude)) \(String(describing: locValue?.longitude))")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

