//
//  SurgicalResultProcessor.swift
//  TestMedKit
//
//  Created by Student on 2018-04-18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class SurgicalTaskResultProcessor: TaskResultProcessor {
    override init(patient: Patient) {
        super.init(patient: patient)
    }
    
    override func startProcessResult(with result: ORKTaskResult) {
        let surgicalInfo = processHaveAnySurgeryResult(with: result)
        surgicalInfo?.isCompleted = true
        
        patient.surgicalInfo = surgicalInfo
    }
    
    func processHaveAnySurgeryResult(with result: ORKTaskResult) -> SurgicalInfo? {
        guard let haveAnyMedicalConditionResult = ((result.result(forIdentifier: "haveAnySurgeryStep") as? ORKStepResult)?.result(forIdentifier: "haveAnySurgeryStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        var surgicalInfo: SurgicalInfo?
        if haveAnyMedicalConditionResult == 1 {
            surgicalInfo = processSurgerySelectionResult(with: result)
            surgicalInfo?.takeSurgical = true
        } else {
            surgicalInfo = SurgicalInfo()
        }
        
        return surgicalInfo
    }
    
    func processSurgerySelectionResult(with result: ORKTaskResult) -> SurgicalInfo? {
        guard let selectedSurgeries = ((result.result(forIdentifier: "surgerySelectionStep") as? ORKStepResult)?.result(forIdentifier: "surgerySelectionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else { return nil }
        
        let surgicalInfo = processOnsetDateResult(with: result, selectedSurgeries: selectedSurgeries)
        surgicalInfo?.surgeries = selectedSurgeries
        
        return surgicalInfo
    }
        
    func processOnsetDateResult(with result: ORKTaskResult, selectedSurgeries: [String]) -> SurgicalInfo? {
        
        var dates: [Date] = []
        for surgery in selectedSurgeries {
            let id = surgery.lowercased() + "_" + "OnsetDateStep"
            guard let date = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKDateQuestionResult)?.dateAnswer else { return nil }
            
            dates.append(date)
        }
        
        let surgicalInfo = SurgicalInfo()
        surgicalInfo.dates = dates
        
        return surgicalInfo
    }
}
