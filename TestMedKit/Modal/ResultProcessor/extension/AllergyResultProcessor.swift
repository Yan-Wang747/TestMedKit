//
//  AllergyTaskResultProcessor.swift
//  TestMedKit
//
//  Created by Student on 2018-04-12.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class AllergyResultProcessor: SurveyResultProcessor {
    
    func startProcessResult(_ result: ORKTaskResult) -> (SurveyResult, Data)? {
        guard let result = processHaveAnyAllergyResult(with: result) else { return nil }
        
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(result) else { fatalError() }
        
        return (result, jsonData)
    }
    
    func processHaveAnyAllergyResult(with result: ORKTaskResult) -> AllergyResult? {
        guard let haveAllergyResult = ((result.result(forIdentifier: "haveAnyAllergyStep") as? ORKStepResult)?.result(forIdentifier: "haveAnyAllergyStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        var allergyInfo: AllergyResult?
        if haveAllergyResult == 1 {
            allergyInfo = processAllergyTypeSelectionResult(with: result)
        } else {
            allergyInfo = AllergyResult()
        }
        
        return allergyInfo
    }
    
    func processAllergyTypeSelectionResult(with result: ORKTaskResult) -> AllergyResult? {
        guard let allergyTypeSelected = ((result.result(forIdentifier: "allergyTypeSelectionStep") as? ORKStepResult)?.result(forIdentifier: "allergyTypeSelectionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else { return nil }
        
        let allergyInfo = processAllergyNameResult(with: result, selectedAllergyTypes: allergyTypeSelected)
        allergyInfo?.allergyTypes = allergyTypeSelected
        
        return allergyInfo
    }
    
    func processAllergyNameResult(with result: ORKTaskResult, selectedAllergyTypes: [String]) -> AllergyResult? {
        
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
    
    func processReactionSelectionResult(with result: ORKTaskResult, allergyTypes: [String]) -> AllergyResult? {
        
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
    
    func processSeverityResult(with result: ORKTaskResult, allergyTypes: [String], reactions: [[String]]) -> AllergyResult? {
        
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
    
    func processDateOfOccurrenceResult(with result: ORKTaskResult, allergyTypes: [String], reactions: [[String]]) -> AllergyResult? {
        
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
        
        let allergyInfo = AllergyResult()
        allergyInfo.datesOfOccurrence = datesOfOccurence
        
        return allergyInfo
    }
}
