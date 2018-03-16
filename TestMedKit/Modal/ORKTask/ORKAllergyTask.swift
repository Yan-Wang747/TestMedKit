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
    
    override func step(after step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
        guard let thisStep = step else {return step(after: step, with: result)}
        
        let nextStep: ORKStep?
        
        switch thisStep.identifier {
        case "AllergyTypeSelectionStep":
            nextStep = allergyTypeSelectionStepRule(result.)
        default:
           nextStep = super.step(after: step, with: result)
        }
        
        return nextStep
    }
    
    override func step(before step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
        print("called")
        
        return steps[0]
    }
    
    private func allergyTypeSelectionStepRule(result: ORK)
}
