//
//  TobaccoTask.swift
//  TestMedKit
//
//  Created by Student on 2018-02-27.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit
import UIKit

class TobaccoSurvey: PatientSurvey {
    static let tobaccoProducts = ["Cigarette", "Cigar", "Pipe"]
    
    init(viewController: UIViewController, patient: Patient, server: Server) {
        let steps = TobaccoSurvey.createTobaccoSteps()
        
        let tobaccoTask = ORKTobaccoTask(identifier: "tobaccoTask", steps: steps)
        
        tobaccoTask.tobaccoProducts = TobaccoSurvey.tobaccoProducts
        TobaccoSurvey.createTobaccoNavigationRule(for: tobaccoTask)
        
        super.init(task: tobaccoTask, viewController: viewController, delegate: TobaccoTaskResultProcessor(patient: patient, server: server))
    }
    
    private static func createTobaccoSteps() -> [ORKStep]{
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Tobacco history"
        instructionStep.detailText = "This survey helps us understand your tobacco history"
        steps.append(instructionStep)
        
        steps.append(createTobaccoUseStep())
        steps.append(createTobaccoSelectionStep(nth: 1))
        
        for tobaccoProduct in tobaccoProducts {
            steps.append(createStartDateStep(for: tobaccoProduct, nth: 1))
            steps.append(createAmountStep(for: tobaccoProduct, nth: 1))
        }
        
        steps.append(createEverUsedTobaccoStep())
        steps.append(createTobaccoSelectionStep(nth: 2))
        for tobaccoProduct in tobaccoProducts {
            steps.append(createStartDateStep(for: tobaccoProduct, nth: 2))
            steps.append(createAmountStep(for: tobaccoProduct, nth: 2))
        }
        
        PatientSurvey.appendReviewStep(steps: &steps)
        
        return steps
    }
    
    private static func createTobaccoUseStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        return ORKQuestionStep(identifier: "tobaccoUseStep", title: "Do you use tobacco products? This includes cigarettes, pipe, cigars, cigarrillos", answer: booleanAnswer)
    }
    
    private static func createEverUsedTobaccoStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
    
        return ORKQuestionStep(identifier: "everUsedTobaccoStep", title: "Have you ever smoked?", answer: booleanAnswer)
    }
    
    private static func createTobaccoSelectionStep(nth: Int) -> ORKStep {
        var tobaccoSelections: [ORKTextChoice] = []
        
        for tobaccoProduct in tobaccoProducts {
            tobaccoSelections.append(ORKTextChoice(text: tobaccoProduct, value: tobaccoProduct as NSString))
        }
        
        let tobaccoSelectionAnswerFormat = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices: tobaccoSelections)
        
        return ORKQuestionStep(identifier: "tobaccoSelectionStep\(nth)", title: "Select all that apply", answer: tobaccoSelectionAnswerFormat)
    }
    
    private static func createStartDateStep(for tobaccoProduct: String, nth: Int) -> ORKStep {
        let dateAnswer = ORKDateAnswerFormat(style: .date)
        
        return ORKQuestionStep(identifier: tobaccoProduct.lowercased() + "_" + "StartDateStep\(nth)", title: "When did you start \(tobaccoProduct)", answer: dateAnswer)
    }
    
    private static func createAmountStep(for tobaccoProduct: String, nth: Int) -> ORKStep {
        let numericAnswer = ORKNumericAnswerFormat(style: .integer, unit: nil, minimum: 1, maximum: nil)
        
        return ORKQuestionStep(identifier: tobaccoProduct.lowercased() + "_" + "AmountStep\(nth)", title: "How many \(tobaccoProduct) per day did you smoke", answer: numericAnswer)
    }
    
    private static func createTobaccoNavigationRule(for tobaccoTask: ORKNavigableOrderedTask){
        //========================
        let tobaccoUseResult = ORKResultSelector(resultIdentifier: "tobaccoUseStep")
        let predicateNoForTobaccoUseStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: tobaccoUseResult, expectedAnswer: false)
        let predicateNoForTobaccoUseStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForTobaccoUseStep, "everUsedTobaccoStep")])
        tobaccoTask.setNavigationRule(predicateNoForTobaccoUseStepRule, forTriggerStepIdentifier: "tobaccoUseStep")
        
        //=======================
        let everUsedTobaccoResult = ORKResultSelector(resultIdentifier: "everUsedTobaccoStep")
        let predicateNoForEverSmokeStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: everUsedTobaccoResult, expectedAnswer: false)
        let predicateNoForEverSmokeStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForEverSmokeStep, "reviewStep")])
        tobaccoTask.setNavigationRule(predicateNoForEverSmokeStepRule, forTriggerStepIdentifier: "everUsedTobaccoStep")
    }
}
