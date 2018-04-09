//
//  ORKFamilyHistoryTask.swift
//  TestMedKit
//
//  Created by Student on 2018-03-27.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class ORKFamilyHistoryTask: ORKNavigableOrderedTask {
    var familyMembers: [String]!
    
    override func step(after step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
        guard let thisStep = step else { return super.step(after: step, with: result)}
        
        if thisStep.identifier == "familiyMemberSelectionStep" {
            return familiyMemberSelectionStepRule(step: thisStep, result: result)
        } else if thisStep.identifier.contains("PassAwayAgeStep") || thisStep.identifier.contains("CurrentAgeStep") {
            return nextFamilyMember(step: thisStep, result: result)
        }
        
        return super.step(after: step, with: result)
    }
    
    private func familiyMemberSelectionStepRule(step: ORKStep, result: ORKTaskResult) -> ORKStep? {
        guard let selectedFamilyMembers = ((result.result(forIdentifier: step.identifier) as? ORKStepResult)?.result(forIdentifier: step.identifier) as? ORKChoiceQuestionResult)?.choiceAnswers as? [String], selectedFamilyMembers.count > 0 else { return super.step(after: step, with: result)}
        
        for familyMember in familyMembers {
            if selectedFamilyMembers.contains(familyMember){
                return self.step(withIdentifier: familyMember.lowercased() + "_" + "DiagnosisStep")
            }
        }
        
        return super.step(after: step, with: result)
    }
    
    private func nextFamilyMember(step: ORKStep, result: ORKTaskResult) -> ORKStep? {
        guard let selectedMembers = ((result.result(forIdentifier: "familiyMemberSelectionStep") as? ORKStepResult)?.result(forIdentifier: "familiyMemberSelectionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String], selectedMembers.count > 0 else { return super.step(after: step, with: result)}
        
        let currentFamilyMember = getFamilyMember(stepId: step.identifier)
        let index = familyMembers.index(of: currentFamilyMember)!
        
        for i in index + 1..<familyMembers.count {
            if selectedMembers.contains(familyMembers[i]){
                return self.step(withIdentifier: familyMembers[i].lowercased() + "_" + "DiagnosisStep")
            }
        }
        
        return self.step(withIdentifier: "reviewStep")
    }
    
    private func getFamilyMember(stepId: String) -> String {
        let underscoreIndex = stepId.index(of: "_")!
        let startIndex = stepId.startIndex
        
        return stepId[startIndex..<underscoreIndex].capitalized
    }
}
