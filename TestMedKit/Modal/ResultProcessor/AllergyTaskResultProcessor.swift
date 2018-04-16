//
//  AllergyTaskResultProcessor.swift
//  TestMedKit
//
//  Created by Student on 2018-04-12.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class AllergyTaskResultProcessor: TaskResultProcessor {
    
    override init(patient: Patient) {
        super.init(patient: patient)
    }
    
    override func startProcessResult(with result: ORKTaskResult) {
        let allergyInfo = processHaveAnyAllergyResult(with: result)
        allergyInfo?.isCompleted = true
        patient.allergyInfo = allergyInfo
    }
    
    func processHaveAnyAllergyResult(with result: ORKTaskResult) -> AllergyInfo? {
        guard let haveAllergyResult = ((result.result(forIdentifier: "haveAnyAllergyStep") as? ORKStepResult)?.result(forIdentifier: "haveAnyAllergyStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        var allergyInfo: AllergyInfo?
        if haveAllergyResult == 1 {
            allergyInfo = processAllergyTypeSelectionResult(with: result)
        } else {
            allergyInfo = AllergyInfo()
        }
        
        return allergyInfo
    }
    
    func processAllergyTypeSelectionResult(with result: ORKTaskResult) -> AllergyInfo? {
        guard let allergyTypeSelected = ((result.result(forIdentifier: "allergyTypeSelectionStep") as? ORKStepResult)?.result(forIdentifier: "allergyTypeSelectionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else { return nil }
        
        let allergyInfo = processAllergyNameResult(with: result, selectedAllergyTypes: allergyTypeSelected)
        allergyInfo?.allergyTypes = allergyTypeSelected
        
        return allergyInfo
    }
    
    func processAllergyNameResult(with result: ORKTaskResult, selectedAllergyTypes: [String]) -> AllergyInfo? {
        
        var allergyNames: [String] = []
        for allergyType in selectedAllergyTypes {
            let id = allergyType.lowercased() + "_" + "AllergyNameStep"
            
            guard let allergyName = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKTextQuestionResult)?.textAnswer else { return nil }
            
            allergyNames.append(allergyName)
        }
        
        let allergyInfo = processReactionSelectionResult(with: result, allergyTypes: selectedAllergyTypes)
        allergyInfo?.allergyNames = allergyNames
        
        return allergyInfo
    }
    
    func processReactionSelectionResult(with result: ORKTaskResult, allergyTypes: [String]) -> AllergyInfo? {
        
        var reactions: [[String]] = []
        for allergyType in allergyTypes {
            let id = allergyType.lowercased() + "_" + "AllergyReactionStep"
            
            guard let reactionSelected = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else { return nil }
            
            reactions.append(reactionSelected)
        }
        
        let allergyInfo = processSeverityResult(with: result, allergyTypes: allergyTypes, reactions: reactions)
        
        allergyInfo?.reactions = reactions
        
        return allergyInfo
    }
    
    func processSeverityResult(with result: ORKTaskResult, allergyTypes: [String], reactions: [[String]]) -> AllergyInfo? {
        
        var severities: [[String]] = []
        for i in 0..<allergyTypes.count {
            var theSeverities: [String] = []
            for reaction in reactions[i] {
                let id = allergyTypes[i] + "_" + reaction + "$" +  "SeverityStep"
                
                guard let severity = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else { return nil }
                
                theSeverities.append(severity[0])
            }
            
            severities.append(theSeverities)
        }
        
        let allergyInfo = processDateOfOccurrenceResult(with: result, allergyTypes: allergyTypes, reactions: reactions)
        allergyInfo?.severities = severities
        
        return allergyInfo
    }
    
    func processDateOfOccurrenceResult(with result: ORKTaskResult, allergyTypes: [String], reactions: [[String]]) -> AllergyInfo? {
        
        var datesOfOccurence: [[Date]] = []
        for i in 0..<allergyTypes.count {
            var dates: [Date] = []
            
            for reaction in reactions[i] {
                let id = allergyTypes[i] + "_" + reaction + "$" +  "DateOfOccurrenceStep"
                
                guard let date = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKDateQuestionResult)?.dateAnswer else { return nil }
                
                dates.append(date)
            }
            
            datesOfOccurence.append(dates)
        }
        
        let allergyInfo = AllergyInfo()
        allergyInfo.datesOfOccurrence = datesOfOccurence
        
        return allergyInfo
    }
}
