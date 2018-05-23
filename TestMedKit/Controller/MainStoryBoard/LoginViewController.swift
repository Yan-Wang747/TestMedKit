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
    
    var patient: Patient!
    var server: Server!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        signInButton.layer.cornerRadius = 8
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func swipeRightBack(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard let ID = IDText.text, let pswd = pswdText.text else {
            return
        }
        
        //diable the back button and enable the activity indicator(NOT IMPLEMENTED)
        
        var serverIP = "localhost"
        if serverIPText.text != "" {
            serverIP = serverIPText.text!
        }
        
        server = Server(serverIP: serverIP, serverPort: 8084)
        
        //self will not be unloaded from the memory since the back button is diabled
        server.asyncAuthenticate(endpoint: Server.Endpoints.Login.rawValue, userID: ID, password: pswd) { _, response, _ in
            
            guard let loginURL = URL(string: "\(self.server.base)/\(Server.Endpoints.Login)") else { fatalError() }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let cookies = HTTPCookieStorage.shared.cookies(for: loginURL) else {
                fatalError()
            }
            
            let cookieOp = cookies.filter { $0.name == "JSESSIONID" }.first
            guard let cookie = cookieOp else { fatalError() }
            
            self.server.sessionID = cookie.value
            
            self.server.asyncGetJsonData(endpoint: Server.Endpoints.BasicInfo.rawValue) {data, response, _ in
                guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                guard let basicInfo = try? jsonDecoder.decode(BasicInfo.self, from: data) else { fatalError() }
                
                self.patient = Patient(basicInfo: basicInfo)
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "ShowMyProfile", sender: sender)
                }
                
            }//asyncGetJsonData closure
        } //auth closure
    } //loginAction
    

    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        guard let myProfileViewController = ((segue.destination as? UITabBarController)?.viewControllers?.filter { $0 is UINavigationController }.first as? UINavigationController)?.topViewController as? MyProfileTableViewController else { fatalError() }
        
        myProfileViewController.patient = patient
        myProfileViewController.server = server
    }

}
