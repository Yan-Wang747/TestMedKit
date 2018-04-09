//
//  ORKTobaccoTask.swift
//  TestMedKit
//
//  Created by Student on 2018-04-03.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class ORKTobaccoTask: ORKNavigableOrderedTask {
    var tobaccoProducts: [String]!
    
    override func step(after step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
        guard let thisStep = step else { return super.step(after: step, with: result) }
        
        if thisStep.identifier.contains("tobaccoSelectionStep") {
            return tobaccoSelectionStepRule(step: thisStep, with: result)
        } else if thisStep.identifier.contains("AmountStep"){
            return tobaccoAmountStepRule(step: thisStep, with: result)
        }
        
        return super.step(after: step, with: result)
    }
    
    private func tobaccoSelectionStepRule(step: ORKStep, with result: ORKTaskResult) -> ORKStep? {
        guard let selectedTobaccoProducts = ((result.result(forIdentifier: step.identifier) as? ORKStepResult)?.result(forIdentifier: step.identifier) as? ORKChoiceQuestionResult)?.choiceAnswers as? [String], selectedTobaccoProducts.count > 0 else { return super.step(after: step, with: result)}
        
        for tobaccoProduct in tobaccoProducts {
            if selectedTobaccoProducts.contains(tobaccoProduct) {
                return self.step(withIdentifier: tobaccoProduct.lowercased() + "_" + "StartDateStep\(step.identifier.last!)")
            }
        }
        
        return super.step(after: step, with: result)
    }
    
    private func tobaccoAmountStepRule(step: ORKStep, with result: ORKTaskResult) -> ORKStep? {
        guard let selectedTobaccoProducts = ((result.result(forIdentifier: "tobaccoSelectionStep\(step.identifier.last!)") as? ORKStepResult)?.result(forIdentifier: "tobaccoSelectionStep\(step.identifier.last!)") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String], selectedTobaccoProducts.count > 0 else { return super.step(after: step, with: result)}
        
        let tobaccoProduct = getTobaccoProdcut(stepId: step.identifier)
        let nth = step.identifier.last!
        
        for i in tobaccoProducts.index(of: tobaccoProduct)! + 1..<tobaccoProducts.count {
            if selectedTobaccoProducts.contains(tobaccoProducts[i]) {
                return self.step(withIdentifier: tobaccoProducts[i].lowercased() + "_" +  "StartDateStep\(nth)")
            }
        }
        
        if nth == "1" {
            return self.step(withIdentifier: "tobaccoEverUseStep")
        }
        
        return self.step(withIdentifier: "reviewStep")
    }
    
    private func getTobaccoProdcut(stepId: String) -> String {
        let underscoreIndex = stepId.index(of: "_")!
        let startIndex = stepId.startIndex
        
        return stepId[startIndex..<underscoreIndex].capitalized
    }
}
