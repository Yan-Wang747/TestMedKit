//
//  LoginViewController.swift
//  TestMedKit
//
//  Created by Student on 2018-04-27.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var IDText: UITextField!
    @IBOutlet weak var pswdText: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var serverIPText: UITextField!
    
    let conf = URLSessionConfiguration.default
    var session: URLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conf.allowsCellularAccess = true
        conf.waitsForConnectivity = true

        signInButton.layer.cornerRadius = 8
        
        session = URLSession(configuration: conf)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestBasicInfo(sessionID: String, basicInfoURL: URL) {
        var basicInfoRequest = URLRequest(url: basicInfoURL)
        basicInfoRequest.addValue("Bear \(sessionID)", forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: basicInfoRequest) {_, response, _ in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200, let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else {
                return
            }
            
            let patient = Patient(sessionID: sessionID, basicInfo: BasicInfo(firstName: "Jong-un", lastName: "Kim", gender: "Male", dateOfBirth: "01-08-1984", phone: "001-204-123-4567", email: "kimthesun@KWP.nkr"))
            
            tabBarController.patient = patient
            
            DispatchQueue.main.async {
                self.present(tabBarController, animated: true, completion: nil)
            }
        }.resume()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard let ID = IDText.text, let pswd = pswdText.text else {
            return
        }
        
        var serverIP = "localhost"
        if serverIPText.text != "" {
            serverIP = serverIPText.text!
        }
        
        let baseURLString = "http://\(serverIP):8084/MyCCMB/"
        let loginURL = URL(string: "\(baseURLString)AppLogin")!
        let basicInfoURL = URL(string: "\(baseURLString)GetBasicInfo")!
        
        let loginString = "\(ID):\(pswd)"
        let loginBase64 = loginString.data(using: .utf8)!.base64EncodedString()
        
        var loginRequest = URLRequest(url: loginURL)
        loginRequest.addValue("Basic \(loginBase64)", forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: loginRequest) {_, response, _ in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200,  let cookies = HTTPCookieStorage.shared.cookies(for: loginURL) else {
                return
            }
            
            for cookie in cookies {
                if cookie.name == "JSESSIONID" {
                    self.requestBasicInfo(sessionID: cookie.value, basicInfoURL: basicInfoURL)
                    break
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
