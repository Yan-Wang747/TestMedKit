//
//  Task.swift
//  TestMedKit
//
//  Created by Student on 2018-02-26.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit
import UIKit

class PatientSurvey {
    let viewController: UIViewController
    let task: ORKNavigableOrderedTask
    let delegate: ORKTaskViewControllerDelegate
    
    init(task: ORKNavigableOrderedTask, viewController: UIViewController, delegate: ORKTaskViewControllerDelegate){
        self.viewController = viewController
        self.task = task
        self.delegate = delegate
    }
    
    static func appendReviewStep(steps: inout [ORKStep]) {
        let reviewStep = ORKReviewStep(identifier: "reviewStep")
        reviewStep.title = "Answer review"
        steps.append(reviewStep)
        
        for step in steps{
            step.isOptional = false
        }
    }
    
    func performTask(){
        let taskViewController = ORKTaskViewController(task: task, taskRun: nil)
        taskViewController.delegate = delegate
        taskViewController.navigationBar.tintColor = UIColor.darkText
        viewController.present(taskViewController, animated: true, completion: nil)
    }
}
