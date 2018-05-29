//
//  MyProfileTableViewController+ORKTaskViewControllerDelegate.swift
//  TestMedKit
//
//  Created by Student on 2018-05-11.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

extension MyProfileTableViewController: ORKTaskViewControllerDelegate {
    
    func taskViewController( _ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        taskViewController.dismiss(animated: true, completion: nil)
        
        guard reason == .completed, let surveyViewController = taskViewController as? SurveyViewController, let jsonData = surveyViewController.resultProcessor.startProcessResult(surveyViewController.result) else {
            //if the survey is not completed, release the lock
            locks[selectedSurveyIndex!] = false
            
            return
        }
        
        self.locks[selectedSurveyIndex!] = true
        self.patient.surveyResults[selectedSurveyIndex!] = jsonData
        activityIndicators[selectedSurveyIndex!].startAnimating()
        
        let indexPath = IndexPath(row: selectedSurveyIndex!, section: 1)
        let cell = tableView.cellForRow(at: indexPath)
        
        server.asyncSendJsonData(endpoint: surveyViewController.uploadEndpoint, jsonData: jsonData) { [weak self] _, response, error in
            
            guard let selectedSurveyIndex = self?.selectedSurveyIndex else { return }
            
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
            } catch let e {
                print(e.localizedDescription)
                
                DispatchQueue.main.async {
                    self?.activityIndicators[selectedSurveyIndex].stopAnimating()
                    
                    cell?.accessoryType = .detailButton
                } 
                    
                return
            }
            
            DispatchQueue.main.async {
                self?.activityIndicators[selectedSurveyIndex].stopAnimating()
                
                cell?.accessoryType = .checkmark
            }
        } //closure
    } //func
}

