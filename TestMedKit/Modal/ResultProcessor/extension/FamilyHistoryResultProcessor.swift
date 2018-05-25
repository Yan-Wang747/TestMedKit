//
//  FamilyTaskResultProcessor.swift
//  TestMedKit
//
//  Created by Student on 2018-04-11.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class FamilyHistoryResultProcessor: SurveyResultProcessor {
    
    func startProcessResult(_ result: ORKTaskResult) -> Data? {
        guard let res = processHaveAnyCancerResult(with: result) else { return nil }
        
        let encoder = JSONEncoder()
        
        let jsonData = try! encoder.encode(res)
        
        return jsonData
    }
    
    func processHaveAnyCancerResult(with result: ORKTaskResult) -> FamilyHistoryResult? {
        guard let haveCancerAnswer = ((result.result(forIdentifier: "haveAnyCancerStep") as? ORKStepResult)?.result(forIdentifier: "haveAnyCancerStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        var familyInfo: FamilyHistoryResult?
        if haveCancerAnswer == 1 {
            familyInfo = processFamiliyMemberSelectionResult(with: result)
            
        } else {
            familyInfo = FamilyHistoryResult()
        }
        
        return familyInfo
    }
    
    func processFamiliyMemberSelectionResult(with result: ORKTaskResult) -> FamilyHistoryResult? {
        guard let selectedFamilies = ((result.result(forIdentifier: "familiyMemberSelectionStep") as? ORKStepResult)?.result(forIdentifier: "familiyMemberSelectionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else { return nil }
        
        let familyInfo = processDiagnosisResult(with: result, selectedFamilies: selectedFamilies)
        familyInfo?.familiesWithCancer = selectedFamilies
        
        return familyInfo
    }
    
    func processDiagnosisResult(with result: ORKTaskResult, selectedFamilies: [String]) -> FamilyHistoryResult? {
        
        var diagnosedCancers: [String] = []
        for familyMember in selectedFamilies {
            let id = familyMember.lowercased() + "_" + "DiagnosisStep"
            guard let diagnosedCancer = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKTextQuestionResult)?.textAnswer else { return nil }
            
            diagnosedCancers.append(diagnosedCancer)
        }
        
        let familyInfo = processDiagnosisAgeResult(with: result, selectedFamilies: selectedFamilies)
        familyInfo?.diagnosedCancers = diagnosedCancers
        
        return familyInfo
    }
    
    func processDiagnosisAgeResult(with result: ORKTaskResult, selectedFamilies: [String]) -> FamilyHistoryResult? {
        
        var diagnosisAges: [Int] = []
        for familyMember in selectedFamilies {
            let id = familyMember.lowercased() + "_" + "DiagnosisAgeStep"
            guard let diagnosisAge = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKNumericQuestionResult)?.numericAnswer as? Int else { return nil }
            
            diagnosisAges.append(diagnosisAge)
        }
        
        let familyInfo = processIsPassAwayResult(with: result, selectedFamilies: selectedFamilies)
        familyInfo?.diagnosisAges = diagnosisAges
        
        return familyInfo
    }
    
    func processIsPassAwayResult(with result: ORKTaskResult, selectedFamilies: [String]) -> FamilyHistoryResult? {
        
        var isPassedAway: [Bool] = []
        for familyMember in selectedFamilies {
            let id = familyMember.lowercased() + "_" + "IsPassAwayStep"
            guard let dead = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKBooleanQuestionResult)?.booleanAnswer as? Bool else { return nil }
            
            isPassedAway.append(dead)
        }
        
        let familyInfo = processPassAwayAgeResult(with: result, selectedFamilies: selectedFamilies, isPassedAway: isPassedAway)
        familyInfo?.isPassedAway = isPassedAway
        
        return familyInfo
    }
    
    func processPassAwayAgeResult(with result: ORKTaskResult, selectedFamilies: [String], isPassedAway: [Bool]) -> FamilyHistoryResult? {
        
        var passAwayAges: [Int] = []
        for i in 0..<selectedFamilies.count {
            if isPassedAway[i] {
                let id = selectedFamilies[i].lowercased() + "_" + "PassAwayAgeStep"
                guard let age = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKNumericQuestionResult)?.numericAnswer as? Int else { return nil }
                
                passAwayAges.append(age)
            }
        }
        
        let familyInfo = processCurrentAgeResult(with: result, selectedFamilies: selectedFamilies, isPassedAway: isPassedAway)
        familyInfo?.passeAwayAges = passAwayAges
        
        return familyInfo
    }
    
    func processCurrentAgeResult(with result: ORKTaskResult, selectedFamilies: [String], isPassedAway: [Bool]) -> FamilyHistoryResult? {
        
        var currentAges: [Int] = []
        for i in 0..<selectedFamilies.count {
            if !isPassedAway[i] {
                let id = selectedFamilies[i].lowercased() + "_" + "CurrentAgeStep"
                guard let age = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKNumericQuestionResult)?.numericAnswer as? Int else { return nil }
                
                currentAges.append(age)
            }
        }
        
        let familyInfo = FamilyHistoryResult()
        familyInfo.currentAges = currentAges
        
        return familyInfo
    }
}
