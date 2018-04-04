//
//  TabaccoInfo.swift
//  TestMedKit
//
//  Created by Student on 2018-04-03.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class TabaccoInfo {
    var completed: Bool = false
    var useTobacco: Bool = false
    var everUseTobacco: Bool = false
    var selectedTobacco: [String]? = nil
    var startDates: [Date]? = nil
    var amount: [Int]? = nil
    
    init(result: ORKTaskResult) {
        processTobaccoUseStep(result: result)
    }
    
    func processTobaccoUseStep(result: ORKTaskResult) {
        let tobaccoUseResult = (result.result(forIdentifier: "tobaccoUseStep") as! ORKStepResult).result(forIdentifier: "tobaccoUseStep") as! ORKBooleanQuestionResult
        
        let answer = tobaccoUseResult.booleanAnswer!
        if answer == 1 {
            useTobacco = true
            processTobaccoSelectionStep(result: result)
        }else {
            processEverUsedTobaccoStep(result: result)
        }
    }
    
    func processTobaccoSelectionStep(result: ORKTaskResult) {
        
    }
}
