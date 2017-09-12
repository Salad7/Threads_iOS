//
//  SettingsViewController.swift
//  Threads
//
//  Created by cci-loaner on 9/12/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import UIKit
import Firebase
class SettingsViewController: UITabBarController, UITableViewDataSource, UITableViewDelegate  {
   
    var threadRef :DatabaseReference!
    let defaults = UserDefaults.standard
    var threadCode = ""
    var settingTableView = UITableView()
    var settings = [Thread]()

    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView.delegate = self
        settingTableView.dataSource = self
        self.threadCode = self.defaults.string(forKey: "threadCode")!
        threadRef = Database.database().reference()

        // Do any additional setup after loading the view.
    }
    
    func loadSettingsFromFirebase(){
         _ = threadRef.observe(DataEventType.value, with: { (snapshot) in
            if(snapshot.childSnapshot(forPath: "Anons").childSnapshot(forPath: "".getUID()).exists()){
                    var settingsPath = snapshot.childSnapshot(forPath: "Anons").childSnapshot(forPath: "".getUID())
                    var setting = settingsPath.value as! [Thread]()
                
//                    setting.setThreadTitle(t: settingsPath.childSnapshot(forPath: "Threads").childSnapshot(forPath: "threadName").value as! String)
//                    setting.setTimeStamp(ts: settingsPath.childSnapshot(forPath: "Threads").childSnapshot(forPath: "timeStamp").value as! UInt64)
                self.settings = setting
            }
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "settings_cell") as! SettingsTableViewCell
        cell.threadName.text = settings[indexPath.row].getThreadTitle()
        cell.dateCreated.text = String(settings[indexPath.row].getTimeStamp())
        
        return cell
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var positionHit = indexPath.row
      
        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
