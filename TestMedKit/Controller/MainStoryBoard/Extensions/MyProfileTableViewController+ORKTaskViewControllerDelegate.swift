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
        
        guard let surveyViewController = taskViewController as? SurveyViewController, error == nil, reason == .completed, let (result, jsonData) = surveyViewController.resultProcessor.startProcessResult(surveyViewController.result) else { return }
        
        self.patient.surveyResults.append(result)
        
        server.asyncSendJsonData(endpoint: surveyViewController.uploadEndpoint, jsonData: jsonData) { _, response, _ in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }

            result.isUploaded = true

            DispatchQueue.main.async {
                guard let selectedSurveyIndex = self.selectedSurveyIndex else { fatalError() }

                let indexPath = IndexPath(row: selectedSurveyIndex, section: 1)
                let cell = self.tableView.cellForRow(at: indexPath)
                cell?.accessoryType = .checkmark

                taskViewController.dismiss(animated: true, completion: nil)
            }
        } //closure
    } //func
}

