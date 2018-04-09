//
//  AlcoholTaskResultProcessor.swift
//  TestMedKit
//
//  Created by Student on 2018-04-09.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class AlcoholTaskResultProcessor: TaskResultProcessor {
    override init(patient: Patient) {
        super.init(patient: patient)
    }
    
    override func startProcessResult(with result: ORKTaskResult) {
        let alcoholInfo = processDrinkAlcoholResult(with: result)
        alcoholInfo?.isCompleted = true
        patient.alcoholInfo = alcoholInfo
    }
    
    func processDrinkAlcoholResult(with result: ORKTaskResult) -> AlcoholInfo? {
        guard let drinkAlcoholAnswer = ((result.result(forIdentifier: "alcoholUseStep") as? ORKStepResult)?.result(forIdentifier: "alcoholUseStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        var alcoholInfo: AlcoholInfo?
        if drinkAlcoholAnswer == 1 {
            alcoholInfo = processAmountOfCupsResult(with: result)
            alcoholInfo?.drinkAlcohol = true
        } else {
            alcoholInfo = processEverDrinkAlcoholResult(with: result)
        }
        
        return alcoholInfo
    }
    
    func processAmountOfCupsResult(with result: ORKTaskResult) -> AlcoholInfo? {
        guard let amountOfCupsAnswer = ((result.result(forIdentifier: "amountOfCupsStep1") as? ORKStepResult)?.result(forIdentifier: "amountOfCupsStep1") as? ORKNumericQuestionResult)?.numericAnswer else { return nil }
        
        let alcoholInfo = processEverDrinkAlcoholResult(with: result)
        alcoholInfo?.amountOfCups = amountOfCupsAnswer as? Int
        
        return alcoholInfo
    }
    
    func processEverDrinkAlcoholResult(with result: ORKTaskResult) -> AlcoholInfo? {
        guard let everDrinkAlcoholAnswer = ((result.result(forIdentifier: "everDrinkAlcoholStep") as? ORKStepResult)?.result(forIdentifier: "everDrinkAlcoholStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        var alcoholInfo: AlcoholInfo?
        if everDrinkAlcoholAnswer == 1 {
            alcoholInfo = processHasQuitDrinkingResult(with: result)
            alcoholInfo?.drinkAlcohol = true
        } else {
            alcoholInfo = processExposedToHazardousInstancesResult(with: result)
        }
        
        return alcoholInfo
    }
    
    func processHasQuitDrinkingResult(with result: ORKTaskResult) -> AlcoholInfo? {
        guard let hasQuitAnswer = ((result.result(forIdentifier: "hasQuitStep") as? ORKStepResult)?.result(forIdentifier: "hasQuitStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        let alcoholInfo = processAmountOfCupsForEverDrinkingResult(with: result)
        alcoholInfo?.hasQuitDrinking = hasQuitAnswer == 1 ? true : false
        
        return alcoholInfo
    }
    
    func processAmountOfCupsForEverDrinkingResult(with result: ORKTaskResult) -> AlcoholInfo? {
        guard let amount = ((result.result(forIdentifier: "amountOfCups2") as? ORKStepResult)?.result(forIdentifier: "amountOfCups2") as? ORKNumericQuestionResult)?.numericAnswer else { return nil }
        
        let alcoholInfo = processExposedToHazardousInstancesResult(with: result)
        
        alcoholInfo?.amountOfCupsForEverDrinking = amount as? Int
        
        return alcoholInfo
    }
    
    func processExposedToHazardousInstancesResult(with result: ORKTaskResult) -> AlcoholInfo? {
        guard let exposedToHazardousInstancesAnswer = ((result.result(forIdentifier: "exposeToHazardousInstancesStep") as? ORKStepResult)?.result(forIdentifier: "exposeToHazardousInstancesStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        var alcoholInfo: AlcoholInfo?
        if exposedToHazardousInstancesAnswer == 1 {
            alcoholInfo = processHazardousInstancesSelectionResult(with: result)
            
            alcoholInfo?.exposedToHazardousInstances = true
        } else {
            alcoholInfo = processUsedProductResult(with: result)
        }
        
        return alcoholInfo
    }
    
    func processHazardousInstancesSelectionResult(with result: ORKTaskResult) -> AlcoholInfo? {
        guard let selectedInstances = ((result.result(forIdentifier: "hazardousInstancesSelectionStep") as? ORKStepResult)?.result(forIdentifier: "hazardousInstancesSelectionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else {return nil}
        
        let alcoholInfo = processUsedProductResult(with: result)
        alcoholInfo?.hazardousInstances = selectedInstances
        
        return alcoholInfo
    }
    
    func processUsedProductResult(with result: ORKTaskResult) -> AlcoholInfo? {
        guard let usedProductsAnswer = ((result.result(forIdentifier: "usedProductsStep") as? ORKStepResult)?.result(forIdentifier: "usedProductsStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        var alcoholInfo: AlcoholInfo?
        if usedProductsAnswer == 1 {
            alcoholInfo = processUsedProductsSelectionResult(with: result)
            alcoholInfo?.usedProducts = true
        } else {
            alcoholInfo = AlcoholInfo()
        }
        
        return alcoholInfo
    }
    
    func processUsedProductsSelectionResult(with result: ORKTaskResult) -> AlcoholInfo? {
        guard let selectedProducts = ((result.result(forIdentifier: "productSelectionStep") as? ORKStepResult)?.result(forIdentifier: "productSelectionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else {return nil}
        
        let alcoholInfo = AlcoholInfo()
        alcoholInfo.products = selectedProducts
        
        return alcoholInfo
    }
}
