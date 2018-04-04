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

class TobaccoTask: Task {
    static let tobaccoProducts = ["Cigarette", "Cigar", "Pipe"]
    
    init(_ viewController: UIViewController) {
        let steps = TobaccoTask.createTobaccoSteps()
        
        let tobaccoTask = ORKNavigableOrderedTask(identifier: "tobaccoTask", steps: steps)
        
        TobaccoTask.createTobaccoNavigationRule(for: tobaccoTask)
        
        super.init(tobaccoTask, viewController)
    }
    
    override func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        switch  reason {
        case .completed:
            processResult(result: taskViewController.result)
        default:
            <#code#>
        }
    }
    
    func processResult(result: ORKTaskResult) {
        
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
        
        steps.append(createEverSmokeStep())
        steps.append(createTobaccoSelectionStep(nth: 2))
        for tobaccoProduct in tobaccoProducts {
            steps.append(createStartDateStep(for: tobaccoProduct, nth: 2))
            steps.append(createAmountStep(for: tobaccoProduct, nth: 2))
        }
        
        Task.appendReviewStep(steps: &steps)
        
        return steps
    }
    
    private static func createTobaccoUseStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        return ORKQuestionStep(identifier: "tobaccoUseStep", title: "Do you use tobacco products? This includes cigarettes, pipe, cigars, cigarrillos", answer: booleanAnswer)
    }
    
    private static func createEverSmokeStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
    
        return ORKQuestionStep(identifier: "tobaccoEverUseStep", title: "Have you ever smoked?", answer: booleanAnswer)
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
        let tobaccoUseStepResult = ORKResultSelector(resultIdentifier: "tobaccoUseStep")
        let predicateYesForTobaccoUseStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: tobaccoUseStepResult, expectedAnswer: true)
        let predicateYesForTobaccoUseStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateYesForTobaccoUseStep, "useCigaretteStep")])
        tobaccoTask.setNavigationRule(predicateYesForTobaccoUseStepRule, forTriggerStepIdentifier: "tobaccoUseStep")
        
        //=======================
        let everSmokeStepResult = ORKResultSelector(resultIdentifier: "everSmokeStep")
        let predicateNoForEverSmokeStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: everSmokeStepResult, expectedAnswer: false)
        let predicateNoForEverSmokeStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForEverSmokeStep, "reviewStep")])
        tobaccoTask.setNavigationRule(predicateNoForEverSmokeStepRule, forTriggerStepIdentifier: "everSmokeStep")
        
        //======================
        let useCigaretteStepResult = ORKResultSelector(resultIdentifier: "useCigaretteStep")
        let predicateNoForUseCigaretteStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: useCigaretteStepResult, expectedAnswer: false)
        let predicateNoForUseCigaretteStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForUseCigaretteStep, "useCigarStep")])
        tobaccoTask.setNavigationRule(predicateNoForUseCigaretteStepRule, forTriggerStepIdentifier: "useCigaretteStep")
        
        //=======================
        let useCigarStepResult = ORKResultSelector(resultIdentifier: "useCigarStep")
        let predicateNoForUseCigarStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: useCigarStepResult, expectedAnswer: false)
        let predicateNoForUseCigarStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForUseCigarStep, "usePipeStep")])
        tobaccoTask.setNavigationRule(predicateNoForUseCigarStepRule, forTriggerStepIdentifier: "useCigarStep")
        
        //===========================
        let usePipeStepResult = ORKResultSelector(resultIdentifier: "usePipeStep")
        let predicateNoForUsePipeStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: usePipeStepResult, expectedAnswer: false)
        let predicateNoForUsePipeStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForUsePipeStep, "reviewStep")])
        tobaccoTask.setNavigationRule(predicateNoForUsePipeStepRule, forTriggerStepIdentifier: "usePipeStep")
    }
}
