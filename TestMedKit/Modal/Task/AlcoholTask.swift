//
//  AlcoholTask.swift
//  TestMedKit
//
//  Created by Student on 2018-02-27.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import UIKit
import ResearchKit

class AlcoholTask: Task {
    init(_ viewController: UIViewController){

        let steps = AlcoholTask.createAlcoholSteps()
        
        let alcoholTask = ORKNavigableOrderedTask(identifier: "alcoholTask", steps: steps)
        
        AlcoholTask.createNavigationRule(for: alcoholTask)
        super.init(alcoholTask, viewController)
    }
    
    private static func createAlcoholSteps() -> [ORKStep]{
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Alcohol history"
        instructionStep.detailText = "This survey helps us understand your alcohol history"
        steps.append(instructionStep)
        
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        let numericAnswer = ORKNumericAnswerFormat(style: .integer, unit: "cups", minimum: 1, maximum: nil)
        let hazardChoiceAnswer = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices:
            [ORKTextChoice(text: "Asbestors", value: "Asbestors" as NSString),
             ORKTextChoice(text: "Benzene", value: "Benzene" as NSString),
             ORKTextChoice(text: "Lead", value: "Lead" as NSString),
             ORKTextChoice(text: "Mercury", value: "Mercury" as NSString),
             ORKTextChoice(text: "Radiation", value: "Radiation" as NSString),
             ORKTextChoice(text: "Other Petroleum Products", value: "Other Petroleum Products" as NSString),
             ORKTextChoice(text: "Snuff", value: "Snuff" as NSString),
             ORKTextChoice(text: "Recreational Drug Use", value: "Recreational Drug Use" as NSString),
             ORKTextChoice(text: "Illicit Drug Use", value: "Illicit Drug Use" as NSString)])
        
        let alcoholUseStep = ORKQuestionStep(identifier: "alcoholUseStep", title: "Do you drink alcohol", answer: booleanAnswer)
        steps.append(alcoholUseStep)
        
        let quitStep = ORKQuestionStep(identifier: "quitStep", title: "Did you quit", answer: booleanAnswer)
        steps.append(quitStep)
        
        let alcoholAmountStep = ORKQuestionStep(identifier: "alcoholAmountStep", title: "How many cups a week?", answer: numericAnswer)
        steps.append(alcoholAmountStep)
        
        let hazardExposureStep = ORKQuestionStep(identifier: "hazardExposureStep", title: "Have you been exposed to Hazardous substances", answer: booleanAnswer)
        steps.append(hazardExposureStep)
        
        let hazardSelectStep = ORKQuestionStep(identifier: "hazardSelectStep", title: "Select all that apply", answer: hazardChoiceAnswer)
        steps.append(hazardSelectStep)
        
        Task.appendReviewStep(steps: &steps)
        
        return steps
    }
    
    private static func createNavigationRule(for alcoholTask: ORKNavigableOrderedTask){
        let alcoholUseStepResult = ORKResultSelector(resultIdentifier: "alcoholUseStep")
        let predicateNoForAlcoholUseStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: alcoholUseStepResult, expectedAnswer: false)
        let predicateNoForAlcoholUseStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForAlcoholUseStep, "hazardExposureStep")])
        alcoholTask.setNavigationRule(predicateNoForAlcoholUseStepRule, forTriggerStepIdentifier: "alcoholUseStep")
        
        let hazardExposureStepResult = ORKResultSelector(resultIdentifier: "hazardExposureStep")
        let predicateNoForHazardExposureStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: hazardExposureStepResult, expectedAnswer: false)
        let predicateNoForHazardExposureStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForHazardExposureStep, "reviewStep")])
        alcoholTask.setNavigationRule(predicateNoForHazardExposureStepRule, forTriggerStepIdentifier: "hazardExposureStep")
    }
}
