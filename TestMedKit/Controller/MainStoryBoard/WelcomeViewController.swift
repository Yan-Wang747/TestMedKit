//
//  WelcomeViewController.swift
//  TestMedKit
//
//  Created by GodIsALoli on 2018-03-04.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import ResearchKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        signUpButton.layer.cornerRadius = 8
        signUpButton.layer.borderWidth = 1.5
        signUpButton.layer.borderColor =  signInButton.layer.backgroundColor
        
        signInButton.layer.cornerRadius = 8
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
