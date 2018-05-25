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

class TobaccoFactory: SurveyFactory {
    
    static func getEndpoint() -> String {
        return Server.Endpoints.Tobacco.rawValue
    }
    
    static func createResultProcessor() -> SurveyResultProcessor {
        return TobaccoResultProcessor()
    }
    
    static let tobaccoProducts = ["Cigarette", "Cigar", "Pipe"]
    
    static func createSteps() -> [ORKStep]{
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Tobacco history"
        instructionStep.detailText = "This survey helps us understand your tobacco history"
        steps.append(instructionStep)
        
        steps.append(createTobaccoUseStep())
        steps.append(createTobaccoSelectionStep(nth: 1))
        
        tobaccoProducts.forEach() {
            steps.append(createStartDateStep(for: $0, nth: 1))
            steps.append(createAmountStep(for: $0, nth: 1))
        }
        
        steps.append(createEverUsedTobaccoStep())
        steps.append(createTobaccoSelectionStep(nth: 2))
        
        tobaccoProducts.forEach() {
            steps.append(createStartDateStep(for: $0, nth: 2))
            steps.append(createAmountStep(for: $0, nth: 2))
        }
        
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
        
        tobaccoProducts.forEach() {
            tobaccoSelections.append(ORKTextChoice(text: $0, value: $0 as NSString))
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
    
    static func createORKTask(identifier: String, steps: [ORKStep]) -> ORKNavigableOrderedTask {
        let orkTask = ORKTobaccoTask(identifier: identifier, steps: steps)
        createNavigationRule(for: orkTask)
        
        return orkTask
    }
    
    static func createNavigationRule(for tobaccoTask: ORKNavigableOrderedTask){
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
