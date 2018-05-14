//
//  SurveyFactory.swift
//  TestMedKit
//
//  Created by Student on 2018-05-11.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

protocol SurveyFactory {
    static func create(with identifier: String, delegate: ORKTaskViewControllerDelegate, uploadEndpoint: String) -> Survey
    static func createSteps() -> [ORKStep]
    static func createORKTask(identifier: String, steps: [ORKStep]) -> ORKNavigableOrderedTask
    static func createNavigationRule(for orkTask: ORKNavigableOrderedTask)
    static func createResultProcessor() -> SurveyResultProcessor
}

extension SurveyFactory {
    
    static func create(with identifier: String, delegate: ORKTaskViewControllerDelegate, uploadEndpoint: String) -> Survey {
        
        func appendReviewStep(steps: inout [ORKStep]) {
            let reviewStep = ORKReviewStep(identifier: "reviewStep")
            reviewStep.title = "Answer review"
            steps.append(reviewStep)
            steps.forEach {$0.isOptional = false}
        }
        
        var steps = createSteps()
        appendReviewStep(steps: &steps)
        
        let orkTask = createORKTask(identifier: identifier, steps: steps)
        let orkTaskViewController = ORKTaskViewController(task: orkTask, taskRun: nil)
        orkTaskViewController.delegate = delegate
        orkTaskViewController.navigationBar.tintColor = UIColor.darkText
        
        return Survey(identifier: identifier, orkTaskViewController: orkTaskViewController, uploadEndpoint: uploadEndpoint, resultProcessor: createResultProcessor())
    }
    
    static func createORKTask(identifier: String, steps: [ORKStep]) -> ORKNavigableOrderedTask {
        let orkTask = ORKNavigableOrderedTask(identifier: identifier, steps: steps)
        createNavigationRule(for: orkTask)
        
        return orkTask
    }
}
