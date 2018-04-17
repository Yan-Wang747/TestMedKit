//
//  ORKMedicalConditionTask.swift
//  TestMedKit
//
//  Created by Student on 2018-03-26.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class ORKMedicalConditionTask: ORKNavigableOrderedTask {
    var medicalConditions: [String]!
    
    override func step(after step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
        
        guard let thisStep = step else { return super.step(after: step, with: result) }
        
        if thisStep.identifier == "medicalConditionSelectionStep" {
            return medicalConditionSelectionStepRule(step: thisStep, with: result)
        }else if thisStep.identifier.contains("HowIsTreatedStep") {
            return howIsTreatedStepRule(step: thisStep, with: result)
        }else if thisStep.identifier.contains("IsTreatedStep") {
            return isTreatedStepRule(step: thisStep, with: result)
        }
        
        return super.step(after: step, with: result)
    }
    
    private func medicalConditionSelectionStepRule(step: ORKStep, with result: ORKTaskResult) -> ORKStep? {
        guard let selectedSurgeries = ((result.result(forIdentifier: step.identifier) as? ORKStepResult)?.result(forIdentifier: step.identifier) as? ORKChoiceQuestionResult)?.choiceAnswers as? [String], selectedSurgeries.count > 0 else { return super.step(after: step, with: result)}
        
        for medicalCondition in medicalConditions {
            if selectedSurgeries.contains(medicalCondition){
                return self.step(withIdentifier: medicalCondition.lowercased() + "_" + "OnsetDateStep")
            }
        }
        
        return super.step(after: step, with: result)
    }
    
    private func isTreatedStepRule(step: ORKStep, with result: ORKTaskResult) -> ORKStep? {
        guard let selectedConditions = ((result.result(forIdentifier: "medicalConditionSelectionStep") as? ORKStepResult)?.result(forIdentifier: "medicalConditionSelectionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String], selectedConditions.count > 0 else { return super.step(after: step, with: result) }
        
        guard let isTreatedResult = ((result.result(forIdentifier: step.identifier) as? ORKStepResult)?.result(forIdentifier: step.identifier) as? ORKBooleanQuestionResult)?.booleanAnswer, isTreatedResult == 0 else { return super.step(after: step, with: result) }
        
        let currentCondition = getCondition(stepId: step.identifier)
        return nextConditionOnsetDate(currentCondition: currentCondition, selectedConditions: selectedConditions)
    }
    
    private func howIsTreatedStepRule(step: ORKStep, with result: ORKTaskResult) -> ORKStep? {
        guard let selectedConditions = ((result.result(forIdentifier: "medicalConditionSelectionStep") as? ORKStepResult)?.result(forIdentifier: "medicalConditionSelectionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String], selectedConditions.count > 0 else { return super.step(after: step, with: result) }
        
        let currentCondition = getCondition(stepId: step.identifier)
        return nextConditionOnsetDate(currentCondition: currentCondition, selectedConditions: selectedConditions)
    }
    
    private func getCondition(stepId: String) -> String {
        let underscoreIndex = stepId.index(of: "_")!
        let startIndex = stepId.startIndex
        
        return stepId[startIndex..<underscoreIndex].capitalized
    }
    
    private func nextConditionOnsetDate(currentCondition: String, selectedConditions: [String]) -> ORKStep? {
        let nextI = selectedConditions.index(of: currentCondition)! + 1
        if nextI == selectedConditions.count {
            return self.step(withIdentifier: "reviewStep")
        } else {
            let id = selectedConditions[nextI].lowercased() + "_" + "OnsetDateStep"
            
            return self.step(withIdentifier: id)
        }
    }
}
