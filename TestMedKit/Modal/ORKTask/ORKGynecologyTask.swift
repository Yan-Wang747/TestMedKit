
//  ORKGynecologyTask.swift
//  TestMedKit
//
//  Created by Student on 2018-03-23.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class ORKGynecologyTask: ORKNavigableOrderedTask {
    var hormoneTypeStrings: [String]!
    
    override func step(after step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
        guard let thisStep = step else { return super.step(after: step, with: result)}
        
        var nextStep = super.step(after: step, with: result)
        
        if thisStep.identifier == "hormoneSelectionStep" {
            nextStep = hormoneSelectionStepRule(step: thisStep, with: result)
        }

        return nextStep
    }
    
    private func hormoneSelectionStepRule(step: ORKStep, with result: ORKTaskResult) -> ORKStep? {
        guard let selectedHormones = ((result.result(forIdentifier: "hormoneSelectionStep") as? ORKStepResult)?.result(forIdentifier: "hormoneSelectionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String], selectedHormones.count > 0 else { return super.step(after: step, with: result)}
        
        for hormone in hormoneTypeStrings {
            if selectedHormones.contains(hormone) {
                let nextStep = self.step(withIdentifier: hormone.lowercased() + "_" + "HowManyYearsStep")
                
                return nextStep
            }
        }
        
        return super.step(after: step, with: result)
    }
}

