//
//  MedicationConditionTaskResultProcessor.swift
//  TestMedKit
//
//  Created by Student on 2018-04-17.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class MedicationConditionResultProcessor: SurveyResultProcessor {
    
    func startProcessResult(_ result: ORKTaskResult) -> (SurveyResult, Data)? {
        guard let result = processHaveAnyMedicalConditionResult(with: result) else { return nil }
        
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(result) else { fatalError() }
        
        return (result, jsonData)
    }
    
    func processHaveAnyMedicalConditionResult(with result: ORKTaskResult) -> MedicalConditionResult? {
        guard let haveAnyMedicalConditionResult = ((result.result(forIdentifier: "haveAnyMedicalConditionStep") as? ORKStepResult)?.result(forIdentifier: "haveAnyMedicalConditionStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        var medicalConditionInfo: MedicalConditionResult?
        if haveAnyMedicalConditionResult == 1 {
            medicalConditionInfo = processMedicalConditionSelectionResult(with: result)
            medicalConditionInfo?.haveAnyMedicalCondition = true
        } else {
            medicalConditionInfo = MedicalConditionResult()
        }
        
        return medicalConditionInfo
    }
    
    func processMedicalConditionSelectionResult(with result: ORKTaskResult) -> MedicalConditionResult? {
        guard let selectedConditions = ((result.result(forIdentifier: "medicalConditionSelectionStep") as? ORKStepResult)?.result(forIdentifier: "medicalConditionSelectionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else { return nil }
        
        let medicalConditionInfo = processOnsetDateResult(with: result, selectedConditions: selectedConditions)
        medicalConditionInfo?.medicalConditions = selectedConditions
        
        return medicalConditionInfo
    }
    
    func processOnsetDateResult(with result: ORKTaskResult, selectedConditions: [String]) -> MedicalConditionResult? {
        
        var onsetDates: [Date] = []
        for selectedCondition in selectedConditions {
            let id = selectedCondition.lowercased() + "_" + "OnsetDateStep"
            guard let date = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKDateQuestionResult)?.dateAnswer else { return nil }
            
            onsetDates.append(date)
        }
        
        let medicalConditionInfo = processIsTreatedResult(with: result, selectedConditions: selectedConditions)
        
        medicalConditionInfo?.onsetDates = onsetDates
        
        return medicalConditionInfo
    }
    
    func processIsTreatedResult(with result: ORKTaskResult, selectedConditions: [String]) -> MedicalConditionResult? {
        
        var isTreated: [Bool] = []
        for selectedCondition in selectedConditions {
            let id = selectedCondition.lowercased() + "_" + "IsTreatedStep"
            guard let treat = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
            isTreated.append(treat == 1 ? true : false)
        }
        
        let medicalConditionInfo = processHowIsTreatedResult(with: result, selectedConditions: selectedConditions, isTreated: isTreated)
        medicalConditionInfo?.isTreated = isTreated
        
        return medicalConditionInfo
    }
    
    func processHowIsTreatedResult(with result: ORKTaskResult, selectedConditions: [String], isTreated: [Bool]) -> MedicalConditionResult? {
        
        var howIsTreated: [String] = []
        for i in 0..<selectedConditions.count {
            if isTreated[i] {
                let id = selectedConditions[i].lowercased() + "_" + "HowIsTreatedStep"
                guard let treat = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKTextQuestionResult)?.textAnswer else { return nil }
                
                howIsTreated.append(treat)
            }
        }
        
        let medicalConditionInfo = MedicalConditionResult()
        medicalConditionInfo.howIsTreated = howIsTreated
        
        return medicalConditionInfo
    }
}
