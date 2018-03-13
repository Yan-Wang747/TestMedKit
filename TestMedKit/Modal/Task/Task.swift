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

class Task: NSObject, ORKTaskViewControllerDelegate{
    let viewController: UIViewController
    let task: ORKNavigableOrderedTask
    
    init(_ task: ORKNavigableOrderedTask, _ viewController: UIViewController){
        self.viewController = viewController
        self.task = task
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
        taskViewController.delegate = self
        taskViewController.navigationBar.tintColor = UIColor.darkText
        viewController.present(taskViewController, animated: true, completion: nil)
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        taskViewController.dismiss(animated: true, completion: nil)
    }
}
