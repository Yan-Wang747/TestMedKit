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
    
    init(patient: Patient) {
        self.patient = patient
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        switch reason {
        case .completed:
            startProcessResult(with: taskViewController.result)
        default:
            return
        }
        
        taskViewController.dismiss(animated: true, completion: nil)
    }
    
    func startProcessResult(with result: ORKTaskResult) {
        
    }
}
