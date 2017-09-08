//
//  ViewController.swift
//  Threads
//
//  Created by cci-loaner on 9/7/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftSpinner

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
        displayAlert()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    override func viewWillAppear(_ animated: Bool) {

    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        DispatchQueue.main.async(execute: {
            SwiftSpinner.show("Finding nearest thread...")
        for i in 0 ... 200001 {
        print(String(i))
            if(i == 200000){
                SwiftSpinner.hide()
            }
        }
            
        })
    }
    
    
    func displayAlert(){
        let alert = UIAlertController(title: "Congrats!",
                                      message: "",
                                      preferredStyle: .alert)
        // Submit button
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: { (action) -> Void in
            // Get 1st TextField's text
           // let textField = alert.textFields![0]
            //print(textField.text!)
        })
        // Add action buttons and present the Alert
        alert.addAction(submitAction)
        DispatchQueue.main.async(execute: {
        self.present(alert, animated: true, completion: nil)
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

