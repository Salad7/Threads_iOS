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
import Firebase

class ViewController: UIViewController {
let locationManager = CLLocationManager()
    var threadRef: DatabaseReference!
    var pureKey = ""
    var coor_near_me = [LatLng]()
    @IBAction func joinThread(_ sender: UIButton) {
//        searchIfThreadExistsInFirebase()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        threadRef = Database.database().reference()

        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as? CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        printNearLocs()
        searchIfThreadExistsInFirebase()

        
    }
    
   
    
    
    func searchIfThreadExistsInFirebase(){
        //SwiftSpinner.show("Finding thread...")
        
        
        _ = threadRef.observe(DataEventType.value, with: { (snapshot) in
            
            for i in 0 ... self.coor_near_me.count-1 {
                var lat = self.coor_near_me[i].lat
                var lon = self.coor_near_me[i].lon
                lat.roundToPlaces(places: 4)
                lon.roundToPlaces(places: 4)
                //print(" Searched Lat " + String(lat) + " Lon " + String(lon))
                var pos1 = String(lon).components(separatedBy: ".")
                var pos2 = String(lat).components(separatedBy: ".")
                //self.pureKey = pos1[0]+"!"+pos1[1] + "*" + pos2[0]+"!"+pos2[1]
                var testKey = pos1[0]+"!"+pos1[1] + "*" + pos2[0]+"!"+pos2[1]
                print(String(testKey)!)
                if(snapshot.childSnapshot(forPath: "Threads").childSnapshot(forPath: String(testKey)!).exists()){
                    SwiftSpinner.hide()
                    print("showing tabbar")
                    self.performSegue(withIdentifier: "show_tabbar", sender: nil)
                    break
                }
                //print("at index " + String(i))
            }
            let lat = Double((self.locationManager.location?.coordinate.latitude)!).roundToPlaces(places: 4)
            let lon = Double((self.locationManager.location?.coordinate.longitude)!).roundToPlaces(places: 4)
            var pos1 = String(lon).components(separatedBy: ".")
            var pos2 = String(lat).components(separatedBy: ".")
            self.pureKey = pos1[0]+"!"+pos1[1] + "*" + pos2[0]+"!"+pos2[1]
                SwiftSpinner.hide()
                print("going to create")
                self.performSegue(withIdentifier: "show_create", sender: nil)
            self.threadRef.removeAllObservers()
            
            
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "show_tabbar"){
            let defaults = UserDefaults.standard
            defaults.set(self.pureKey, forKey: "threadCode")
           
        }
        if(segue.identifier == "show_create"){
            let defaults = UserDefaults.standard
            defaults.set(self.pureKey, forKey: "threadCode")
        }
    }
    
    func getThreadsNearMe(lo :Double, la :Double) -> [LonLat] {
        /**
         Algorithim here
         **/
        //start in the first quad
        var upperBoundForLat = la + 200
        var lowerBoundForLon = lo - 200
        //for i in 0
        return [LonLat]()
    }
    
    func printNearLocs(){
        var la =  String(Double((self.locationManager.location?.coordinate.latitude)!))
        var lo =  String(Double((self.locationManager.location?.coordinate.longitude)!))
        print("My location Lat : " + la + " Lon : " +  lo)
    coor_near_me = ThreadFinder().runSimulation(laa: Double(la)!-0.0001, loo: Double(lo)!-0.0001)
        for i in 0 ... coor_near_me.count-1 {
            print("Latitude " + String(describing: coor_near_me[i].lat) + " Longitude " + String(describing: coor_near_me[i].lon))
        }
        print("Number of coordinates = " + String(coor_near_me.count))

    }
    

    
    
    
   // func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
//        var ss = ThreadFinder().runSimulation(laa: locValue.latitude-0.000100, loo: locValue.longitude-0.000100)
//        for i in 0 ... ss.count {
//            print("Latitude " + String(describing: ss[i].lat) + " Longitude " + String(describing: ss[i].lon))
//        }
//        print("Number of coordinates = " + String(coor_near_me.count))
  //  }
    
    override func viewWillAppear(_ animated: Bool) {

    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SwiftSpinner.show("Finding thread...")

        //DispatchQueue.main.async(execute: {
//            SwiftSpinner.show("Finding thread...")
            //SwiftSpinner.show(duration: 2.0, title: "Finding nearest thread...")
//        for i in 0 ... 200001 {
//        //print(String(i))
//            if(i == 200000){
//                SwiftSpinner.hide()
//            }
//        }
            
        //})
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

