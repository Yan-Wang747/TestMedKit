//
//  File.swift
//  TestMedKit
//
//  Created by Student on 2018-03-14.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class ORKAllergyTask : ORKNavigableOrderedTask {
    var allergyTypes: [String]!
    var allergyReactions: [String]!
    
    override func step(after step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
        guard let thisStep = step else { return super.step(after: step, with: result) }
        
        var nextStep = super.step(after: thisStep, with: result)
        
        let id = thisStep.identifier
        if id == "allergyTypeSelectionStep"{
            nextStep = allergyTypeSelectionStepRule(step: thisStep, with: result)
        }else if id.contains("AllergyReactionStep") {
            nextStep = allergyReactionStepRule(step: thisStep, with: result)
        }else if id.contains("DateOfOccurrenceStep") {
            nextStep = dateOfOccurrenceStepRule(step: thisStep, with: result)
        }
        
        return nextStep
    }
    
    private func allergyTypeSelectionStepRule(step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
       guard let selectedAllergies = ((result.result(forIdentifier: "allergyTypeSelectionStep") as? ORKStepResult)?.result(forIdentifier: "allergyTypeSelectionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String], selectedAllergies.count > 0 else {
        
            return super.step(after: step, with: result)}
        
        for alleryType in allergyTypes {
            if selectedAllergies.contains(alleryType) {
                return self.step(withIdentifier: alleryType.lowercased() + "_" + "AllergyNameStep")
            }
        }
        
        return super.step(after: step, with: result)
    }
    
    private func allergyReactionStepRule (step: ORKStep, with result: ORKTaskResult) -> ORKStep? {
        
        guard let selectedReactions = ((result.result(forIdentifier: step.identifier) as? ORKStepResult)?.result(forIdentifier: step.identifier) as? ORKChoiceQuestionResult)?.choiceAnswers as? [String], selectedReactions.count > 0 else { return super.step(after: step, with: result) }
        
        let allergyType = getAllergyType(stepId: step.identifier)
        for reaction in allergyReactions {
            if selectedReactions.contains(reaction) {
                return self.step(withIdentifier: allergyType.lowercased() + "_" + reaction + "$" + "SeverityStep")
            }
        }
        
        return super.step(after: step, with: result)
    }
    
    private func dateOfOccurrenceStepRule(step: ORKStep, with result: ORKTaskResult) -> ORKStep?  {
        
        let allergyType = getAllergyType(stepId: step.identifier)
        let reaction = getReaction(stepId: step.identifier)
        
        guard let selectedAllergies = ((result.result(forIdentifier: "allergyTypeSelectionStep") as? ORKStepResult)?.result(forIdentifier: "allergyTypeSelectionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String], selectedAllergies.count > 0, let selectedReactions = ((result.result(forIdentifier: allergyType.lowercased() + "_" + "AllergyReactionStep") as? ORKStepResult)?.result(forIdentifier: allergyType.lowercased() + "_" + "AllergyReactionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String], selectedReactions.count > 0 else {
            return super.step(after: step, with: result)
        }
        
        let currentReactionIndex = allergyReactions.index(of: reaction)!
        
        for i in currentReactionIndex + 1..<allergyReactions.count {
            let nextReaction = allergyReactions[i]
            if selectedReactions.contains(nextReaction) {
                return self.step(withIdentifier: allergyType.lowercased() + "_" + nextReaction + "$" + "SeverityStep")
            }
        }
        
        for i in allergyTypes.index(of: allergyType)! + 1..<allergyTypes.count {
            let nextAllergyType = allergyTypes[i]
            if selectedAllergies.contains(nextAllergyType) {
                return self.step(withIdentifier: nextAllergyType.lowercased() + "_" + "AllergyNameStep")
            }
        }
        
        return self.step(withIdentifier: "reviewStep")
    }

    
    private func getAllergyType(stepId: String) -> String {
        let underscoreIndex = stepId.index(of: "_")!
        let startIndex = stepId.startIndex
        
        return stepId[startIndex..<underscoreIndex].capitalized
    }
    
    private func getReaction(stepId: String) -> String {
        let dollarMarkIndex = stepId.index(of: "$")!
        let startIndex = stepId.index(after: stepId.index(of: "_")!)
        
        return String(stepId[startIndex..<dollarMarkIndex])
    }

}
