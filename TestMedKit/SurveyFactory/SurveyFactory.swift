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
    static func create(delegate: ORKTaskViewControllerDelegate, createReviewStep: Bool) -> SurveyViewController
    static func createSteps() -> [ORKStep]
    static func createORKTask(identifier: String, steps: [ORKStep]) -> ORKNavigableOrderedTask
    static func createNavigationRule(for orkTask: ORKNavigableOrderedTask)
    static func createResultProcessor() -> SurveyResultProcessor
    static func getEndpoint() -> String
}

extension SurveyFactory {
    
    static func create(delegate: ORKTaskViewControllerDelegate, createReviewStep: Bool) -> SurveyViewController {
        
        func appendReviewStep(steps: inout [ORKStep]) {
            let reviewStep = ORKReviewStep(identifier: "reviewStep")
            reviewStep.title = "Answer review"
            steps.append(reviewStep)
            steps.forEach {$0.isOptional = false}
        }
        
        var steps = createSteps()
        
        if createReviewStep {
            appendReviewStep(steps: &steps)
        }
        
        let uploadEndpoint = getEndpoint()
        
        let orkTask = createORKTask(identifier: uploadEndpoint, steps: steps)
        let surveyViewController = SurveyViewController.createSurveyViewController(orkTask: orkTask, uploadEndpoint: uploadEndpoint, resultProcessor: createResultProcessor())
        surveyViewController.delegate = delegate
        surveyViewController.navigationBar.tintColor = UIColor.darkText
        
        return surveyViewController
    }
    
    static func createORKTask(identifier: String, steps: [ORKStep]) -> ORKNavigableOrderedTask {
        let orkTask = ORKNavigableOrderedTask(identifier: identifier, steps: steps)
        createNavigationRule(for: orkTask)
        
        return orkTask
    }
}
