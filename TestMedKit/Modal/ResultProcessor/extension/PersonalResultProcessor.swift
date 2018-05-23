//
//  PersonalTaskResultProcessor.swift
//  TestMedKit
//
//  Created by Student on 2018-04-10.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class PersonalResultProcessor: SurveyResultProcessor {
    
    func startProcessResult(_ result: ORKTaskResult) -> (SurveyResult, Data)? {
        guard let result = processIsMarriedResult(with: result) else { return nil }
        
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(result) else { fatalError() }
        
        return (result, jsonData)
    }
    
    func processIsMarriedResult(with result: ORKTaskResult) -> PersonalResult? {
        guard let isMarriedAnswer = ((result.result(forIdentifier: "isMarriedStep") as? ORKStepResult)?.result(forIdentifier: "isMarriedStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        var personalInfo: PersonalResult?
        if isMarriedAnswer == 1 {
            personalInfo = processLivingWithResult(with: result)
            personalInfo?.isMarried = true
        } else {
            personalInfo = processResideResult(with: result)
        }
        
        return personalInfo
    }
    
    func processLivingWithResult(with result: ORKTaskResult) -> PersonalResult? {
        guard let selectedFamilies = ((result.result(forIdentifier: "livingWithStep") as? ORKStepResult)?.result(forIdentifier: "livingWithStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else { return nil }
        
        let personalInfo = processWhoWillSupportResult(with: result)
        personalInfo?.livingWith = selectedFamilies
        
        return personalInfo
    }
    
    func processWhoWillSupportResult(with result: ORKTaskResult) -> PersonalResult? {
        guard let selectedFamilies = ((result.result(forIdentifier: "whoWillSupportStep") as? ORKStepResult)?.result(forIdentifier: "whoWillSupportStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else { return nil }
        
        let personalInfo = processAccessToTransportationResult(with: result)
        
        personalInfo?.supportFamilies = selectedFamilies
        
        return personalInfo
    }
    
    func processAccessToTransportationResult(with result: ORKTaskResult) -> PersonalResult? {
        guard let accessToTransportationAnswer = ((result.result(forIdentifier: "whoWillSupportStep") as? ORKStepResult)?.result(forIdentifier: "whoWillSupportStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        let personalInfo = processResideResult(with: result)
        personalInfo?.accessToTransportation = accessToTransportationAnswer == 1 ? true : false
        
        return personalInfo
    }
    
    func processResideResult(with result: ORKTaskResult) -> PersonalResult? {
        guard let selectedLocations = ((result.result(forIdentifier: "resideStep") as? ORKStepResult)?.result(forIdentifier: "resideStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else { return nil }
        
        let personalInfo = processOccupationResult(with: result)
        personalInfo?.resideLocations = selectedLocations
        
        return personalInfo
    }
    
    func processOccupationResult(with result: ORKTaskResult) -> PersonalResult? {
        guard let occupation = ((result.result(forIdentifier: "occupationStep") as? ORKStepResult)?.result(forIdentifier: "occupationStep") as? ORKTextQuestionResult)?.textAnswer else { return nil }
        
        let personalInfo = processIsActivePersonResult(with: result)
        personalInfo?.occupation = occupation
        
        return personalInfo
    }
    
    func processIsActivePersonResult(with result: ORKTaskResult) -> PersonalResult? {
        guard let isActivePersonAnswer = ((result.result(forIdentifier: "isActivePersonStep") as? ORKStepResult)?.result(forIdentifier: "isActivePersonStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        var personalInfo: PersonalResult?
        if isActivePersonAnswer == 1 {
            personalInfo = processActivitySelectionResult(with: result)
            personalInfo?.isActivePerson = true
        } else {
            personalInfo = processRegularMealResult(with: result)
        }
        
        return personalInfo
    }
    
    func processActivitySelectionResult(with result: ORKTaskResult) -> PersonalResult? {
        guard let activitySelection = ((result.result(forIdentifier: "activitySelectionStep") as? ORKStepResult)?.result(forIdentifier: "activitySelectionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else { return nil }
        
        let personalInfo = processRegularMealResult(with: result)
        personalInfo?.activies = activitySelection
        
        return personalInfo
    }
    
    func processRegularMealResult(with result: ORKTaskResult) -> PersonalResult? {
        guard let regularMealAnswer = ((result.result(forIdentifier: "regularMealStep") as? ORKStepResult)?.result(forIdentifier: "regularMealStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        let personalInfo = processNutritionSupplementsResult(with: result)
        personalInfo?.regularMeal = regularMealAnswer == 1 ? true : false
        
        return personalInfo
    }
    
    func processNutritionSupplementsResult(with result: ORKTaskResult) -> PersonalResult? {
        guard let nutritionSupplementsAnswer = ((result.result(forIdentifier: "nutritionSupplementsStep") as? ORKStepResult)?.result(forIdentifier: "nutritionSupplementsStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        let personalInfo = processLiquidDietResult(with: result)
        personalInfo?.nutritionalSupplement = nutritionSupplementsAnswer == 1 ? true : false
        
        return personalInfo
    }
    
    func processLiquidDietResult(with result: ORKTaskResult) -> PersonalResult? {
        guard let liquidDietAnswer = ((result.result(forIdentifier: "liquidDietStep") as? ORKStepResult)?.result(forIdentifier: "liquidDietStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        let personalInfo = PersonalResult()
        personalInfo.liquidDiet = liquidDietAnswer == 1 ? true : false
        
        return personalInfo
    }
}
