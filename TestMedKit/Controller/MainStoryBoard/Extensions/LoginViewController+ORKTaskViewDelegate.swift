//
//  SignUpViewController+taskViewDelegate.swift
//  TestMedKit
//
//  Created by Student on 2018-05-31.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

extension LoginViewController: ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        taskViewController.dismiss(animated: true, completion: nil)
        
        if reason != .completed || error != nil {
            //logout current session, ignore the server response
            server.asyncSignOut { _, _, _ in
                
            }
            
            DispatchQueue.main.async {
                self.loginComplete()
            }
            
            return
        }
        
        let taskViewController = taskViewController as! SurveyViewController
        
        let jsonData = taskViewController.resultProcessor.startProcessResult(taskViewController.result)!
        basicInfo = try! JSONDecoder().decode(BasicInfo.self, from: jsonData)

        server.asyncSendJsonData(endpoint: Server.Endpoints.BasicInfo.rawValue, jsonData: jsonData) { [weak self] _, response, error in
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
                
                DispatchQueue.main.async {
                    self?.performSegue(withIdentifier: "ShowMyProfile", sender: nil)
                    self?.loginComplete()
                }
                
            } catch let e {
                
                alertController.message = e.localizedDescription
                
                DispatchQueue.main.async {
                    self?.present(alertController, animated: true) {
                        self?.loginComplete()
                    }
                }
                
                return
            }
        }// sendDataClosure
    }
}

