//
//  LoginViewController.swift
//  TestMedKit
//
//  Created by Student on 2018-04-27.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var IDLabel: UITextField!
    @IBOutlet weak var pswdLabel: UITextField!
    
    let loginUrl = URL(string: "http://localhost:8084/MyCCMB/AppLogin")!
    let conf = URLSessionConfiguration.default
    var session: URLSession!
    var loginRequest: URLRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conf.allowsCellularAccess = true
        session = URLSession(configuration: conf)
        loginRequest = URLRequest(url: loginUrl)
        loginRequest.httpMethod = "GET"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard let ID = IDLabel.text, let pswd = pswdLabel.text else {
            return
        }
        
        let loginString = "\(ID):\(pswd)"
        let loginBase64 = loginString.data(using: .utf8)!.base64EncodedString()

        loginRequest.addValue("Basic \(loginBase64)", forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: loginRequest) {_, response, _ in
            guard let response = response as? HTTPURLResponse else {
                return
            }

            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! TabBarController
                    
                    for cookie in HTTPCookieStorage.shared.cookies(for: self.loginUrl)! {
                        if cookie.name == "JSESSIONID" {
                            tabBarController.sessionID = cookie.value
                        }
                    }
                    
                    self.present(tabBarController, animated: true, completion: nil)
                }
            }
            
        }.resume()
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
