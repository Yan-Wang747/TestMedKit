//
//  SignUpViewController.swift
//  TestMedKit
//
//  Created by Student on 2018-05-31.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import ResearchKit

class SignUpViewController: UIViewController {
    
    enum Errors: LocalizedError {
        case errorCode(Int)
        case invalidUserID
        case mismatchedPassword
        
        var errorDescription: String? {
            switch self {
            case .errorCode(let code):
                if code == 1 {
                    return "The email address already exits, please login in."
                } else {
                    return "It isn't an error"
                }
            case .invalidUserID:
                return "Please enter a valid email address"
            case .mismatchedPassword:
                return "Sorry, password doesn't match"
            }
        }
    }
    
    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var pswdTextField: UITextField!
    @IBOutlet weak var repeatedPSWDTextField: UITextField!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func signUpAction(_ sender: UIButton) {
        signUpStart()
        
        let id = userIDTextField.text!
        do {
            if !validateUserID(id) {
                throw Errors.invalidUserID
            }
            
            if !validatePassword() {
                throw Errors.mismatchedPassword
            }
        }catch let e {
            
            signUpComplete()
            alertController.message = e.localizedDescription
            present(alertController, animated: true)
            
            return
        }
        
        let server = Server()
        
        server.asyncSignUp(endpoint: Server.Endpoints.RegisterNewUser.rawValue, userID: id, password: pswdTextField.text!) { [weak self] data, response, error in
            do {
                if error != nil {
                    throw error!
                }
                
                guard let response = response as? HTTPURLResponse else {
                    throw Server.Errors.invalidResponse
                }
                
                if response.statusCode != 200 {
                    throw Server.Errors.httpErrorCode(response.statusCode)
                }
                
                guard let data = data else {
                    throw Server.Errors.noDataReturned
                }
                
                guard let succeedString = String(data: data, encoding: .utf8) else { throw Server.Errors.invalidData }
                
                guard let succeed = Int(succeedString) else {
                    throw Server.Errors.invalidData
                }
                
                if succeed != 0 {
                    throw Errors.errorCode(succeed)
                }
                
                let messageViewController = UIAlertController(title: "Account Created!", message: nil, preferredStyle: .alert)
                
                //go to login screen
                let okAction = UIAlertAction(title: "ok", style: .default) { _ in
                    guard let loginViewController = self?.storyboard?.instantiateViewController(withIdentifier: "loginScreen") as? LoginViewController else {
                        self?.navigationController?.popToRootViewController(animated: true)
                        
                        return
                    }
                    
                    loginViewController.userID = self?.userIDTextField.text!
                    loginViewController.password = self?.pswdTextField.text!
                    loginViewController.server = server
                    
                    self?.navigationController?.popToRootViewController(animated: true)
                    self?.navigationController?.pushViewController(loginViewController, animated: true)
                }
                
                messageViewController.addAction(okAction)
                
                DispatchQueue.main.async {
                    self?.present(messageViewController, animated: true)
                }
                
            } catch let e {
                alertController.message = e.localizedDescription
                
                DispatchQueue.main.async {
                    self?.present(alertController, animated: true, completion: nil)
                    self?.signUpComplete()
                }
            }
            
            return
        }
    }
    
    func validateUserID(_ id: String) -> Bool {
        return true
    }
    
    func validatePassword() -> Bool {
        return pswdTextField.text! == repeatedPSWDTextField.text!
    }
    
    func signUpStart() {
        userIDTextField.isEnabled = false
        pswdTextField.isEnabled = false
        repeatedPSWDTextField.isEnabled = false
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.coverView.alpha = 0.5
        }, completion: nil)
        
        activityIndicator.startAnimating()
    }
    
    func signUpComplete() {
        userIDTextField.isEnabled = true
        pswdTextField.isEnabled = true
        repeatedPSWDTextField.isEnabled = true
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.coverView.alpha = 0
        }, completion: nil)
        
        activityIndicator.stopAnimating()
    }
}
