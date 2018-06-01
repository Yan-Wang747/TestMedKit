//
//  LoginViewController.swift
//  TestMedKit
//
//  Created by Student on 2018-04-27.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import ResearchKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var pswdTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var server: Server!
    var basicInfo: BasicInfo!
    
    var userID: String? = nil
    var password: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        signInButton.layer.cornerRadius = 8
        userIDTextField.text! = userID ?? ""
        pswdTextField.text! = password ?? ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (userID != nil && password != nil) && (userID != "" && password != "") {
            loginAction(self)
        } else {
            userIDTextField.becomeFirstResponder()
        }
    }

    @IBAction func swipeRightBack(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {

        userID = userIDTextField.text!
        password = pswdTextField.text!
        
        if userID == "" || password == "" {
            alertController.message = "Please enter your ID and password"
            
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        loginStart()
        
        server = server ?? Server()
        
        //self could be removed from the memory
        server.asyncAuthenticate(userID: userID!, password: password!) { [weak self] _, response, error in
            do {
                if error != nil {
                    throw error!
                }
                
                guard let response = response as? HTTPURLResponse else {
                    throw Server.Errors.invalidResponse
                }
                
                let loginURL = URL(string: "\(self?.server.base ?? "")/\(Server.Endpoints.Login)") //if the self is unloaded, intensionally set loginURL to an invalid url
                
                //if the self is unloaded, the loginURL will be invalid and no cookies could be found. A server error will be thrown and result is ignored
                guard let cookies = HTTPCookieStorage.shared.cookies(for: loginURL!) else {
                    throw Server.Errors.noCookieReturned
                }
                
                let cookie = cookies.filter() { cookie in cookie.name == "JSESSIONID" }.first
                if cookie == nil {
                    throw Server.Errors.invalidCookie
                }
                
                self?.server.sessionID = cookie!.value
                
                if response.statusCode != 200 {
                    throw Server.Errors.httpErrorCode(response.statusCode)
                }
                
            } catch let e {
                
                alertController.message = e.localizedDescription
                
                DispatchQueue.main.async {
                    self?.present(alertController, animated: true, completion: nil)
                    
                    self?.loginComplete()
                }
                
                return
            }
            
            self?.server.asyncGetJsonData(endpoint: Server.Endpoints.BasicInfo.rawValue) {data, response, error in
                do {
                    if error != nil {
                        throw error!
                    }
                    
                    guard let response = response as? HTTPURLResponse else {
                        throw Server.Errors.invalidResponse
                    }
                    
                    if response.statusCode != 200 {
                        if response.statusCode == 404 {
                            let surveyViewController = BasicInfoFactory.create(delegate: self, createReviewStep: false)
                            
                            self?.present(surveyViewController, animated: true, completion: nil)
                            
                            self?.loginComplete()
                            return //dont go further
                        } else {
                            throw Server.Errors.httpErrorCode(response.statusCode)
                        }
                    }
                    
                    guard let data = data else {
                        throw Server.Errors.noDataReturned
                    }
                    
                    let jsonDecoder = JSONDecoder()
                    guard let basicInfo = try? jsonDecoder.decode(BasicInfo.self, from: data) else {
                        throw Server.Errors.invalidData
                    }
                    
                    self?.basicInfo = basicInfo
                    DispatchQueue.main.async {
                        self?.loginComplete()
                        self?.performSegue(withIdentifier: "ShowMyProfile", sender: sender)
                    }
                    
                } catch let e {
                    
                    alertController.message = e.localizedDescription
                    
                    DispatchQueue.main.async {
                        self?.present(alertController, animated: true, completion: nil)
                        
                        self?.loginComplete()
                    }
                }
            }//asyncGetJsonData closure
        } //auth closure
    } //loginAction
    

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let myTabBarController = segue.destination as! MyTabBarController
        
        myTabBarController.basicInfo = basicInfo
        myTabBarController.server = server
    }
    
    func loginStart() {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.coverView.alpha = 0.5
            }, completion: nil)
        
        userIDTextField.isEnabled = false
        pswdTextField.isEnabled = false
        signInButton.isEnabled = false
        activityIndicator.startAnimating()
    }
    
    func loginComplete() {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.coverView.alpha = 0
        }, completion: nil)
        
        userIDTextField.isEnabled = true
        pswdTextField.isEnabled = true
        signInButton.isEnabled = true
        activityIndicator.stopAnimating()
    }
}
