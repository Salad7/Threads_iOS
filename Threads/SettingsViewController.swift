//
//  SettingsViewController.swift
//  Threads
//
//  Created by cci-loaner on 9/12/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import UIKit
import Firebase
class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    @IBOutlet weak var settingTableView: UITableView!
   
    var threadRef :DatabaseReference!
    let defaults = UserDefaults.standard
    var threadCode = ""
    //var settingTableView = UITableView()
    var settings = [Settings]()

    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView.delegate = self
        settingTableView.dataSource = self
        self.threadCode = self.defaults.string(forKey: "threadCode")!
        threadRef = Database.database().reference()
        loadSettingsFromFirebase()
        // Do any additional setup after loading the view.
    }
    
    func loadSettingsFromFirebase(){
         _ = threadRef.observe(DataEventType.value, with: { (snapshot) in
            self.settings.removeAll()

            for i in 0 ... FirebaseCounter().MAX_SETTINGS {
            if(snapshot.childSnapshot(forPath: "Anons").childSnapshot(forPath: "".getUID()).exists()){
                print("poop at index " + String(i))
                    var settingsPath = snapshot.childSnapshot(forPath: "Anons").childSnapshot(forPath: "".getUID())
                if(settingsPath.childSnapshot(forPath: String(i)).exists()){
                    let individualSettingsPath = settingsPath.childSnapshot(forPath: String(i))
                    print("poop2")
                    var setting = Settings()
                    setting.setThreadCode(t: individualSettingsPath.childSnapshot(forPath: "threadCode").value as! String)
                    setting.setTimeStamp(ts: individualSettingsPath.childSnapshot(forPath: "timeStamp").value as! UInt64)
                    setting.setName(n: individualSettingsPath.childSnapshot(forPath: "threadName").value as! String)
                    self.settings.append(setting)
                    print("poopy " + setting.getName())
                
                }
            }
            }
            self.settingTableView.reloadData()
            
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
        cell.threadName.text = settings[indexPath.row].getName()
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
