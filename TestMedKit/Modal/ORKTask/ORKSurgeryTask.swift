//
//  ORKSurgicalTask.swift
//  TestMedKit
//
//  Created by Student on 2018-03-23.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class ORKSurgeryTask: ORKNavigableOrderedTask {
    var surgeryTypes: [String]!
    
    
    override func step(after step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
        
        guard let thisStep = step else { return super.step(after: step, with: result) }
        
        if thisStep.identifier == "surgerySelectionStep" {
            return surgerySelectionStepRule(step: thisStep, with: result)
        }else if thisStep.identifier.contains("OnsetDateStep"){
            return onsetDateStepRule(step: thisStep, with: result)
        }
        
        return super.step(after: step, with: result)
    }
    
    private func onsetDateStepRule(step: ORKStep, with result: ORKTaskResult) -> ORKStep? {
        guard let selectedSurgeries = ((result.result(forIdentifier: "surgerySelectionStep") as? ORKStepResult)?.result(forIdentifier: "surgerySelectionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String], selectedSurgeries.count > 0 else { return super.step(after: step, with: result)}
        
        let surgeryType = getSurgeryType(stepId: step.identifier)
        
        for i in surgeryTypes.index(of: surgeryType)! + 1..<surgeryTypes.count {
            if selectedSurgeries.contains(surgeryTypes[i]){
                let nextId = surgeryTypes[i].lowercased() + "_" + "OnsetDateStep"
                
                return self.step(withIdentifier: nextId)
            }
        }
        
        return self.step(withIdentifier: "reviewStep")
    }
    
    private func getSurgeryType(stepId: String) -> String {
        let underscoreIndex = stepId.index(of: "_")!
        let startIndex = stepId.startIndex
        
        return stepId[startIndex..<underscoreIndex].capitalized
    }
    
    private func surgerySelectionStepRule(step: ORKStep, with result: ORKTaskResult) -> ORKStep? {

        guard let selectedSurgeries = ((result.result(forIdentifier: step.identifier) as? ORKStepResult)?.result(forIdentifier: step.identifier) as? ORKChoiceQuestionResult)?.choiceAnswers as? [String], selectedSurgeries.count > 0 else { return super.step(after: step, with: result)}
        
        for surgery in surgeryTypes {
            if selectedSurgeries.contains(surgery) {
                return self.step(withIdentifier: surgery.lowercased() + "_" + "OnsetDateStep")
            }
        }
        
        return super.step(after: step, with: result)
    }
}
