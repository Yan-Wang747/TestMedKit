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

class AlcoholSurvey: PatientSurvey {
    static let hazardousInstances = ["Asbestors", "Benzene", "Lead", "Mercury", "Radiation", "Other Petroleum Products"]
    static let products = ["Cigarettes", "Cigars", "Chewing Tobacco", "Snuff", "Recreational Drug Use", "Illicit Drug Use"]
    
    init(viewController: UIViewController, patient: Patient, server: Server){

        let steps = AlcoholSurvey.createAlcoholSteps()
        
        let alcoholTask = ORKNavigableOrderedTask(identifier: "alcoholTask", steps: steps)

        AlcoholSurvey.createNavigationRule(for: alcoholTask)
        super.init(task: alcoholTask, viewController: viewController, delegate: AlcoholTaskResultProcessor(patient: patient, server: server))
    }
    
    private static func createAlcoholSteps() -> [ORKStep]{
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Alcohol history"
        instructionStep.detailText = "This survey helps us understand your alcohol history"
        steps.append(instructionStep)
        
        steps.append(createDrinkAlcoholStep())
        steps.append(createHowManyCupsStep1())
        steps.append(createEverDrinkAlcoholStep())
        steps.append(createHasQuitStep())
        steps.append(createHowManyCupsStep2())
        steps.append(createExposeToHazardousInstancesStep())
        steps.append(createHazardousInstancesSelectionStep())
        steps.append(createUsedProductsStep())
        steps.append(createUsedProductsSelectionStep())
        
        PatientSurvey.appendReviewStep(steps: &steps)
        
        return steps
    }
    
    private static func createDrinkAlcoholStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        return ORKQuestionStep(identifier: "alcoholUseStep", title: "Do you drink alcohol", answer: booleanAnswer)
    }
    
    private static func createHowManyCupsStep1() -> ORKStep {
        let numericAnswer = ORKNumericAnswerFormat(style: .integer, unit: "cups", minimum: 1, maximum: nil)
        
        return ORKQuestionStep(identifier: "amountOfCupsStep1", title: "How many cups a week?", answer: numericAnswer)
    }
    
    private static func createEverDrinkAlcoholStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        return ORKQuestionStep(identifier: "everDrinkAlcoholStep", title: "Have you ever drink alcohol", answer: booleanAnswer)
    }
    
    private static func createHasQuitStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        return ORKQuestionStep(identifier: "hasQuitStep", title: "Did you quit?", answer: booleanAnswer)
    }
    
    private static func createHowManyCupsStep2() -> ORKStep {
        let numericAnswer = ORKNumericAnswerFormat(style: .integer, unit: "cups", minimum: 1, maximum: nil)
        
        return ORKQuestionStep(identifier: "amountOfCupsStep2", title: "How many cups a week?", answer: numericAnswer)
    }
    
    private static func createExposeToHazardousInstancesStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        return ORKQuestionStep(identifier: "exposeToHazardousInstancesStep", title: "Have you been exposed to Hazardous substances?", answer: booleanAnswer)
    }
    
    private static func createHazardousInstancesSelectionStep() -> ORKStep {
        var choices: [ORKTextChoice] = []
        for hazardousInstance in hazardousInstances {
            choices.append(ORKTextChoice(text: hazardousInstance, value: hazardousInstance as NSString))
        }
        
        let hazardousInstancesSelectionAnswerFormat = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices: choices)
        
        return ORKQuestionStep(identifier: "hazardousInstancesSelectionStep", title: "Select all that apply", answer: hazardousInstancesSelectionAnswerFormat)
    }
    
    private static func createUsedProductsStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        return ORKQuestionStep(identifier: "usedProductsStep", title: "Have you used any of the following products?", answer: booleanAnswer)
    }
    
    private static func createUsedProductsSelectionStep() -> ORKStep {
        var choices: [ORKTextChoice] = []
        for product in products {
            choices.append(ORKTextChoice(text: product, value: product as NSString))
        }
        
        let productSelectionAnswerFormat = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices: choices)
        
        return ORKQuestionStep(identifier: "productSelectionStep", title: "Select all that apply", answer: productSelectionAnswerFormat)
    }
    
    private static func createNavigationRule(for alcoholTask: ORKNavigableOrderedTask){
        
        createAlcoholUseStepRule(for: alcoholTask)
        createEverDrinkAlcoholStepRule(for: alcoholTask)
        createExposeToHazardousInstancesStepRule(for: alcoholTask)
        createUsedProductStepRule(for: alcoholTask)
    }
    
    private static func createAlcoholUseStepRule(for alcoholTask: ORKNavigableOrderedTask) {
        let alcoholUseResult = ORKResultSelector(resultIdentifier: "alcoholUseStep")
        let predicateNoForAlcoholUse = ORKResultPredicate.predicateForBooleanQuestionResult(with: alcoholUseResult, expectedAnswer: false)
        let predicateNoForAlcoholUseRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForAlcoholUse, "everDrinkAlcoholStep")])
        alcoholTask.setNavigationRule(predicateNoForAlcoholUseRule, forTriggerStepIdentifier: "alcoholUseStep")
    }
    
    private static func createEverDrinkAlcoholStepRule(for alcoholTask: ORKNavigableOrderedTask) {
        let everDrinkAlcoholResult = ORKResultSelector(resultIdentifier: "everDrinkAlcoholStep")
        let predicateNoForEverDrinkAlcohol = ORKResultPredicate.predicateForBooleanQuestionResult(with: everDrinkAlcoholResult, expectedAnswer: false)
        let predicateNoForEverDrinkAlcoholRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForEverDrinkAlcohol, "exposeToHazardousInstancesStep")])
        alcoholTask.setNavigationRule(predicateNoForEverDrinkAlcoholRule, forTriggerStepIdentifier: "everDrinkAlcoholStep")
    }
    
    private static func createExposeToHazardousInstancesStepRule(for alcoholTask: ORKNavigableOrderedTask) {
        let exposeToHazardousInstancesResult = ORKResultSelector(resultIdentifier: "exposeToHazardousInstancesStep")
        
        let predicateNoForExposeToHazardousInstances = ORKResultPredicate.predicateForBooleanQuestionResult(with: exposeToHazardousInstancesResult, expectedAnswer: false)
        let predicateNoForexposeToHazardousInstancesRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForExposeToHazardousInstances, "usedProductsStep")])
        alcoholTask.setNavigationRule(predicateNoForexposeToHazardousInstancesRule, forTriggerStepIdentifier: "exposeToHazardousInstancesStep")
    }
    
    private static func createUsedProductStepRule(for alcoholTask: ORKNavigableOrderedTask) {
        let usedProductResult = ORKResultSelector(resultIdentifier: "usedProductsStep")
        
        let predicateNoForUsedProduct = ORKResultPredicate.predicateForBooleanQuestionResult(with: usedProductResult, expectedAnswer: false)
        let predicateNoForUsedProductRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForUsedProduct, "reviewStep")])
        alcoholTask.setNavigationRule(predicateNoForUsedProductRule, forTriggerStepIdentifier: "usedProductsStep")
    }
}
