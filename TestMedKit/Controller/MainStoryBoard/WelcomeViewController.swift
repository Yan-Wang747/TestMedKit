//
//  WelcomeViewController.swift
//  TestMedKit
//
//  Created by GodIsALoli on 2018-03-04.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import ResearchKit

class WelcomeViewController: UIViewController, ORKTaskViewControllerDelegate {
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        if reason != .completed || error != nil {
            return
        }
        
        let taskViewController = taskViewController as! SurveyViewController
        
        let jsonData = taskViewController.resultProcessor.startProcessResult(taskViewController.result)!
        
        let server = Server(serverAddr: "http://localhost", serverPort: 8084)
        
        //self will not be unloaded from the memory
        server.asyncSendJsonData(endpoint: Server.Endpoints.SignUp.rawValue, jsonData: jsonData) { data, response, error in
            do {
                if error != nil {
                    throw error!
                }
                
                guard let response = response as? HTTPURLResponse else {
                    throw Server.Errors.invalidResponse
                }
                
                if response.statusCode != 200 {
                    throw Server.Errors.errorCode(response.statusCode)
                }
                
                let signUpURL = URL(string: "\(server.base)/\(Server.Endpoints.SignUp)")
                
                guard let cookies = HTTPCookieStorage.shared.cookies(for: signUpURL!) else {
                    throw Server.Errors.noCookieReturned
                }
                
                let cookieOp = cookies.filter() { cookie in cookie.name == "JSESSIONID" }.first
                guard let cookie = cookieOp else {
                    throw Server.Errors.invalidCookie
                }
                
                server.sessionID = cookie.value
            } catch let e {
                
                alertController.message = e.localizedDescription
                
                DispatchQueue.main.async {
                    self?.present(alertController, animated: true, completion: nil)
                    
                    self?.loginComplete()
                }
                
                return
            }
        }
    }
    

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

    @IBAction func signUpAction(_ sender: UIButton) {
        let surveyViewController = BasicInfoFactory.create(delegate: self, createReviewStep: false)
        
        present(surveyViewController, animated: true, completion: nil)
    }
}
