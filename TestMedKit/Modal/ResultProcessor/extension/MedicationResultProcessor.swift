//
//  MedicationTaskResultProcessor.swift
//  TestMedKit
//
//  Created by Student on 2018-04-12.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class MedicationResultProcessor: SurveyResultProcessor {
    var medTypes: [String]!
    
    func startProcessResult(_ result: ORKTaskResult) -> Data? {
        guard let res = processTakeAnyMedicationResult(with: result, for: medTypes.first!) else { return nil }
        
        let encoder = JSONEncoder()
        
        let jsonData = try! encoder.encode(res)
        
        return jsonData
    }
    
    func processTakeAnyMedicationResult(with result: ORKTaskResult, for medType: String) -> MedicationResult? {
        let id = medType.lowercased() + "_" + "TakeAnyMedicationStep"
        
        guard let takeAnyMedicationResult = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        var medicationInfo: MedicationResult?
        if takeAnyMedicationResult == 1 {
            medicationInfo = processNameResult(with: result, for: medType)
            let index = medTypes.index(of: medType)!
            medicationInfo?.takeMedication[index] = true
        } else {
            let index = medTypes.index(of: medType)!
            if index == medTypes.count - 1 {
                medicationInfo = MedicationResult()
            } else {
                let nextMedType = medTypes[index + 1]
                medicationInfo = processTakeAnyMedicationResult(with: result, for: nextMedType)
            }
        }
        
        return medicationInfo
    }
    
    func processNameResult(with result: ORKTaskResult, for medType: String) -> MedicationResult? {
        let id = medType.lowercased() + "_" + "NameStep"
        guard let name = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKTextQuestionResult)?.textAnswer else { return nil }
        
        let medicationInfo = processDoseUnitResult(with: result, for: medType)
        
        medicationInfo?.names.append(name)
        
        return medicationInfo
    }
    
    func processDoseUnitResult(with result: ORKTaskResult, for medType: String) -> MedicationResult? {
        let id = medType.lowercased() + "_" + "DoseUnitStep"
        
        guard let doseUnit = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else { return nil }
        
        let medicationInfo = processDoseResult(with: result, for: medType)
        
        medicationInfo?.units.append(contentsOf: doseUnit)
        
        return medicationInfo
    }
    
    func processDoseResult(with result: ORKTaskResult, for medType: String) -> MedicationResult? {
        let id = medType.lowercased() + "_" + "DoseAmountStep"
        guard let dose = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKNumericQuestionResult)?.numericAnswer as? Int else { return nil }
        
        let medicationInfo = processFrequencyResult(with: result, for: medType)
        medicationInfo?.doses.append(dose)
        
        return medicationInfo
    }
    
    func processFrequencyResult(with result: ORKTaskResult, for medType: String) -> MedicationResult? {
        let id = medType.lowercased() + "_" + "FrequencyStep"
        guard let frequency = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else { return nil }
        
        let medicationInfo = processIntakeWayResult(with: result, for: medType)
        medicationInfo?.frequencies.append(contentsOf: frequency)
        
        return medicationInfo
    }
    
    func processIntakeWayResult(with result: ORKTaskResult, for medType: String) -> MedicationResult? {
        let id = medType.lowercased() + "_" + "FrequencyStep"
        guard let intakeWay = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else { return nil }
        
        let medicationInfo = processStartDateResult(with: result, for: medType)
        medicationInfo?.intakeWays.append(contentsOf: intakeWay)
        
        return medicationInfo
    }
    
    func processStartDateResult(with result: ORKTaskResult, for medType: String) -> MedicationResult? {
        let id = medType.lowercased() + "_" + "StartDateStep"
        guard let startDate = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKDateQuestionResult)?.dateAnswer else { return nil }
        
        var medicationInfo: MedicationResult?
        let index = medTypes.index(of: medType)!
        if index == medTypes.count - 1 {
            medicationInfo = MedicationResult()
            medicationInfo?.startDates.append(startDate)
        } else {
            let nextMedType = medTypes[index + 1]
            medicationInfo = processTakeAnyMedicationResult(with: result, for: nextMedType)
        }
        
        return medicationInfo
    }
}
