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
    
    func startProcessResult(_ result: ORKTaskResult) -> Data? {
        guard let res = processHaveAnySurgeryResult(with: result) else { return nil }
        
        let encoder = JSONEncoder()
        
        let jsonData = try! encoder.encode(res)
        
        return jsonData
    }
    
    func processHaveAnySurgeryResult(with result: ORKTaskResult) -> SurgeryResult? {
        guard let haveAnyMedicalConditionResult = ((result.result(forIdentifier: "haveAnySurgeryStep") as? ORKStepResult)?.result(forIdentifier: "haveAnySurgeryStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        var surgeryInfo: SurgeryResult?
        if haveAnyMedicalConditionResult == 1 {
            surgeryInfo = processSurgerySelectionResult(with: result)
            surgeryInfo?.takeSurgery = true
        } else {
            surgeryInfo = SurgeryResult()
        }
        
        return surgeryInfo
    }
    
    func processSurgerySelectionResult(with result: ORKTaskResult) -> SurgeryResult? {
        guard let selectedSurgeries = ((result.result(forIdentifier: "surgerySelectionStep") as? ORKStepResult)?.result(forIdentifier: "surgerySelectionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else { return nil }
        
        let surgeryInfo = processOnsetDateResult(with: result, selectedSurgeries: selectedSurgeries)
        surgeryInfo?.surgeries = selectedSurgeries
        
        return surgeryInfo
    }
        
    func processOnsetDateResult(with result: ORKTaskResult, selectedSurgeries: [String]) -> SurgeryResult? {
        
        var dates: [Date] = []
        for surgery in selectedSurgeries {
            let id = surgery.lowercased() + "_" + "OnsetDateStep"
            guard let date = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKDateQuestionResult)?.dateAnswer else { return nil }
            
            dates.append(date)
        }
        
        let surgeryInfo = SurgeryResult()
        surgeryInfo.dates = dates
        
        return surgeryInfo
    }
}
