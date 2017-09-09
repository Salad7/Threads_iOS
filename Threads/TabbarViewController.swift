//
//  TabbarViewController.swift
//  Threads
//
//  Created by cci-loaner on 9/9/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    var threadCode = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        print("tabbar - threadCode = " + threadCode)
        //let vc = self.tabBarController?.viewControllers![1] as! LocalViewController
        //vc.threadCode = threadCode
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
