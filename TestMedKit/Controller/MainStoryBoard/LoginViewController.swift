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
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var serverIPText: UITextField!
    var server: Server!
    var patient: Patient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        signInButton.layer.cornerRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        IDText.becomeFirstResponder()
        IDText.selectAll(nil)
    }

    @IBAction func swipeRightBack(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Oops", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        let ID = IDText.text!
        let pswd = pswdText.text!
        
        if ID == "" || pswd == "" {
            alertController.message = "Please enter your ID and password"
            
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        loginStart()
        
        var serverIP = serverIPText.text!
        
        if serverIP == "" {
            serverIP = "localhost"
        }
        
        server = Server(serverIP: serverIP, serverPort: 8084)
        
        //self could be removed from the memory and cause memory cycle
        server.asyncAuthenticate(userID: ID, password: pswd) { [weak self] _, response, error in
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
                let loginURL = URL(string: "\(self?.server.base ?? "")/\(Server.Endpoints.Login)") //if the self is unloaded, intensionally set loginURL to nil

                //if the self is unloaded, the loginURL will be invalid and no cookies could be found. A server error will be thrown and result is ignored
                guard let cookies = HTTPCookieStorage.shared.cookies(for: loginURL!) else {
                    throw Server.Errors.noCookieReturned
                }
                
                let cookieOp = cookies.filter() { cookie in cookie.name == "JSESSIONID" }.first
                guard let cookie = cookieOp else {
                    throw Server.Errors.invalidCookie
                }
                
                self?.server.sessionID = cookie.value
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
                        throw Server.Errors.errorCode(response.statusCode)
                    }
                    
                    guard let data = data else {
                        throw Server.Errors.noDataReturned
                    }
                    
                    let jsonDecoder = JSONDecoder()
                    guard let basicInfo = try? jsonDecoder.decode(BasicInfo.self, from: data) else {
                        throw Server.Errors.invalidData
                    }
                    
                    self?.patient = Patient(basicInfo: basicInfo)
                } catch let e {
                    
                    alertController.message = e.localizedDescription
                    
                    DispatchQueue.main.async {
                        self?.present(alertController, animated: true, completion: nil)
                        
                        
                        self?.loginComplete()
                    }
                    
                    return
                }

                DispatchQueue.main.async {
                    self?.loginComplete()
                    self?.performSegue(withIdentifier: "ShowMyProfile", sender: sender)
                }
            }//asyncGetJsonData closure
        } //auth closure
    } //loginAction
    

    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let myTabBarController = segue.destination as! MyTabBarController
        
        myTabBarController.patient = patient
        myTabBarController.server = server
    }
    
    func loginStart() {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.coverView.alpha = 0.5
            }, completion: nil)
        
        IDText.isEnabled = false
        pswdText.isEnabled = false
        signInButton.isEnabled = false
        activityIndicator.startAnimating()
    }
    
    func loginComplete() {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.coverView.alpha = 0
        }, completion: nil)
        
        IDText.isEnabled = true
        pswdText.isEnabled = true
        signInButton.isEnabled = true
        activityIndicator.stopAnimating()
    }
}
