//
//  NavigationViewController.swift
//  TestMedKit
//
//  Created by Student on 2018-04-30.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
    var patient: Patient!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let myProfileTableViewController = self.topViewController as? MyProfileTableViewController else {
            return
        }
        
        myProfileTableViewController.patient = patient
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
