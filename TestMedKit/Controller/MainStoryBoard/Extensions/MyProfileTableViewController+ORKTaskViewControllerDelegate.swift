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
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        guard let uploadEndpoint = uploadEndpoint, let resultProcessor = resultProcessor, let selectedSurveyIndex = selectedSurveyIndex, error == nil, reason == .completed, let result = resultProcessor.startProcessResult(taskViewController.result) else { return }
        
        let encoder = JSONEncoder()
        guard let jsonData = try? encoder.encode(result) else { fatalError() }
        
        server.asyncSendJsonData(endpoint: uploadEndpoint.rawValue, jsonData: jsonData) { _, response, _ in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            self.patient.surveyResults.append(result)
            
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: selectedSurveyIndex, section: 1)
                let cell = self.tableView.cellForRow(at: indexPath)
                cell?.accessoryType = .checkmark
                
                taskViewController.dismiss(animated: true, completion: nil)
            }
            
        } //closure
    } //func
}
