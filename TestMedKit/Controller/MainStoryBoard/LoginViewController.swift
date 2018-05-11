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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signInButton.layer.cornerRadius = 8

        // Do any additional setup after loading the view.
        
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
        
        var serverIP = "localhost"
        if serverIPText.text != "" {
            serverIP = serverIPText.text!
        }
        
        let server = Server(serverIP: serverIP, serverPort: 8084)
        
        server.asyncAuthenticate(endpoint: Endpoints.appLogin.rawValue, userID: ID, password: pswd) {_, response, _ in
            
            let loginURL = URL(string: "\(server.base)/\(Endpoints.appLogin)")!
            guard let response = response as? HTTPURLResponse, response.statusCode == 200,  let cookies = HTTPCookieStorage.shared.cookies(for: loginURL) else {
                fatalError()
            }
            
            for cookie in cookies {
                if cookie.name == "JSESSIONID" {
                    server.sessionID = cookie.value
                    //closure
                    server.asyncGetJsonData(endpoint: Endpoints.getBasicInfo.rawValue) {data, response, _ in
                        guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200, let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else {
                            return
                        }
                        
                        let jsonDecoder = JSONDecoder()
                        let basicInfo = try! jsonDecoder.decode(BasicInfo.self, from: data)
                        let patient = Patient(basicInfo: basicInfo)
                        
                        tabBarController.patient = patient
                        tabBarController.server = server
                        
                        DispatchQueue.main.async {
                            self.present(tabBarController, animated: true, completion: nil)
                        }
                    } //end of closure
                    
                    break
                } //if
            } //for
        } //auth closure
    } //loginAction
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
