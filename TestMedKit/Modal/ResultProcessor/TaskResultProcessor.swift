//
//  TobaccoTaskResultProcessor.swift
//  TestMedKit
//
//  Created by Student on 2018-04-05.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class TaskResultProcessor: NSObject, ORKTaskViewControllerDelegate {
    let patient: Patient
    let server: Server
    let updateEndpoint: String
    
    init(patient: Patient, server: Server, updateEndpoint: String) {
        self.patient = patient
        self.server = server
        self.updateEndpoint = updateEndpoint
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        switch reason {
        case .completed:
            if let result = startProcessResult(with: taskViewController.result) {
                do {
                    let encoder = JSONEncoder()
                    let jsonData = try encoder.encode(result)
                    
                    server.asyncSendJsonData(endpoint: updateEndpoint, jsonData: jsonData) { _, response, _ in
                        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
                        
                        result.isCompleted = true
                        self.patient.surveyResults.append(result)
                        
                        DispatchQueue.main.async {
                            taskViewController.dismiss(animated: true, completion: nil)
                        }
                    }
                    
                } catch {
                    fatalError()
                }
            }
        default:
            break
        }
    }
    
    func startProcessResult(with result: ORKTaskResult) -> SurveyResult? {
        return nil
    }
}
