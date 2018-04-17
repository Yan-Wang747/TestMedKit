//
//  MedicationConditionTaskResultProcessor.swift
//  TestMedKit
//
//  Created by Student on 2018-04-17.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class MedicalConditionTaskResultProcessor: TaskResultProcessor {
    override init(patient: Patient) {
        super.init(patient: patient)
    }
    
    override func startProcessResult(with result: ORKTaskResult) {
        let medicalConditionInfo = processHaveAnyMedicalConditionResult(with: result)
        medicalConditionInfo?.isCompleted = true
        
        patient.medicalConditionInfo = medicalConditionInfo
    }
    
    func processHaveAnyMedicalConditionResult(with result: ORKTaskResult) -> MedicalConditionInfo? {
        guard let haveAnyMedicalConditionResult = ((result.result(forIdentifier: "haveAnyMedicalConditionStep") as? ORKStepResult)?.result(forIdentifier: "haveAnyMedicalConditionStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        var medicalConditionInfo: MedicalConditionInfo?
        if haveAnyMedicalConditionResult == 1 {
            medicalConditionInfo = processMedicalConditionSelectionResult(with: result)
            medicalConditionInfo?.haveAnyMedicalCondition = true
        } else {
            medicalConditionInfo = MedicalConditionInfo()
        }
        
        return medicalConditionInfo
    }
    
    func processMedicalConditionSelectionResult(with result: ORKTaskResult) -> MedicalConditionInfo? {
        guard let selectedConditions = ((result.result(forIdentifier: "medicalConditionSelectionStep") as? ORKStepResult)?.result(forIdentifier: "medicalConditionSelectionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else { return nil }
        
        let medicalConditionInfo = processOnsetDateResult(with: result, selectedConditions: selectedConditions)
        medicalConditionInfo?.medicalConditions = selectedConditions
        
        return medicalConditionInfo
    }
    
    func processOnsetDateResult(with result: ORKTaskResult, selectedConditions: [String]) -> MedicalConditionInfo? {
        
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
    
    func processIsTreatedResult(with result: ORKTaskResult, selectedConditions: [String]) -> MedicalConditionInfo? {
        
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
    
    func processHowIsTreatedResult(with result: ORKTaskResult, selectedConditions: [String], isTreated: [Bool]) -> MedicalConditionInfo? {
        
        var howIsTreated: [String] = []
        for i in 0..<selectedConditions.count {
            if isTreated[i] {
                let id = selectedConditions[i].lowercased() + "_" + "HowIsTreatedStep"
                guard let treat = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKTextQuestionResult)?.textAnswer else { return nil }
                
                howIsTreated.append(treat)
            }
        }
        
        let medicalConditionInfo = MedicalConditionInfo()
        medicalConditionInfo.howIsTreated = howIsTreated
        
        return medicalConditionInfo
    }
}
