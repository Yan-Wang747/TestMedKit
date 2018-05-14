//
//  SurgicalResultProcessor.swift
//  TestMedKit
//
//  Created by Student on 2018-04-18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class SurgeryResultProcessor: SurveyResultProcessor {
    
    func startProcessResult(_ result: ORKTaskResult) -> SurveyResult? {
        return processHaveAnySurgeryResult(with: result)
    }
    
    func processHaveAnySurgeryResult(with result: ORKTaskResult) -> SurgicalResult? {
        guard let haveAnyMedicalConditionResult = ((result.result(forIdentifier: "haveAnySurgeryStep") as? ORKStepResult)?.result(forIdentifier: "haveAnySurgeryStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        var surgicalInfo: SurgicalResult?
        if haveAnyMedicalConditionResult == 1 {
            surgicalInfo = processSurgerySelectionResult(with: result)
            surgicalInfo?.takeSurgical = true
        } else {
            surgicalInfo = SurgicalResult()
        }
        
        return surgicalInfo
    }
    
    func processSurgerySelectionResult(with result: ORKTaskResult) -> SurgicalResult? {
        guard let selectedSurgeries = ((result.result(forIdentifier: "surgerySelectionStep") as? ORKStepResult)?.result(forIdentifier: "surgerySelectionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else { return nil }
        
        let surgicalInfo = processOnsetDateResult(with: result, selectedSurgeries: selectedSurgeries)
        surgicalInfo?.surgeries = selectedSurgeries
        
        return surgicalInfo
    }
        
    func processOnsetDateResult(with result: ORKTaskResult, selectedSurgeries: [String]) -> SurgicalResult? {
        
        var dates: [Date] = []
        for surgery in selectedSurgeries {
            let id = surgery.lowercased() + "_" + "OnsetDateStep"
            guard let date = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKDateQuestionResult)?.dateAnswer else { return nil }
            
            dates.append(date)
        }
        
        let surgicalInfo = SurgicalResult()
        surgicalInfo.dates = dates
        
        return surgicalInfo
    }
}
