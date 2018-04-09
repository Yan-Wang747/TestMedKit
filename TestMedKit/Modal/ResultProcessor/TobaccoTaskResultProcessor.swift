//
//  TobaccoTaskResultProcessor.swift
//  TestMedKit
//
//  Created by Student on 2018-04-05.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class TobaccoTaskResultProcessor: TaskResultProcessor {
    
    override init(patient: Patient) {
        super.init(patient: patient)
    }
    
    override func startProcessResult(with result: ORKTaskResult) {
        let tobaccoInfo = processTobaccoUseResult(with: result)
        tobaccoInfo?.isCompleted = true
        patient.tobaccoInfo = tobaccoInfo
    }
    
    func processTobaccoUseResult(with result: ORKTaskResult) -> TobaccoInfo?{
        guard let tobaccoUseAnswer = ((result.result(forIdentifier: "tobaccoUseStep") as? ORKStepResult)?.result(forIdentifier: "tobaccoUseStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        var tobaccoInfo: TobaccoInfo?
        if tobaccoUseAnswer == 1 {
            tobaccoInfo = processTobaccoProductsSelectionResult(with: result, nth: 1)
            tobaccoInfo?.useTobacco = true
        }else {
            tobaccoInfo = processEverUsedTobaccoResult(with: result)
        }
        
        return tobaccoInfo
    }
    
    func processTobaccoProductsSelectionResult(with result: ORKTaskResult, nth: Int) -> TobaccoInfo? {
        guard let selectedTobaccoProducts = ((result.result(forIdentifier: "tobaccoSelectionStep\(nth)") as? ORKStepResult)?.result(forIdentifier: "tobaccoSelectionStep\(nth)") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else {return nil}
        
        let tobaccoInfo = processStartDateResult(selectedTobaccoProducts: selectedTobaccoProducts, with: result, nth: nth)
        
        tobaccoInfo?.selectedTobaccoProducts = selectedTobaccoProducts
        
        return tobaccoInfo
    }
    
    func processStartDateResult(selectedTobaccoProducts: [String], with result: ORKTaskResult, nth: Int) -> TobaccoInfo? {
        
        var startDates: [String] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm-dd-yyyy"
        for selectedTobaccoProduct in selectedTobaccoProducts {
            let id = selectedTobaccoProduct.lowercased() + "_" + "StartDateStep\(nth)"
            guard let startDate = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKDateQuestionResult)?.dateAnswer else { return nil }
            let dateString = dateFormatter.string(from: startDate)
            startDates.append(dateString)
        }
        
        let tobaccoInfo = processAmountResult(selectedTobaccoProducts: selectedTobaccoProducts, with: result, nth: nth)
        if nth == 1 {
            tobaccoInfo?.startDates = startDates
        } else {
            tobaccoInfo?.startDatesForEverSmoke = startDates
        }
        
        return tobaccoInfo
    }
    
    func processAmountResult(selectedTobaccoProducts: [String], with result: ORKTaskResult, nth: Int) -> TobaccoInfo? {
        
        var amounts: [Int] = []
        
        for selectedTobaccoProduct in selectedTobaccoProducts {
            let id = selectedTobaccoProduct.lowercased() + "_" + "AmountStep\(nth)"
            guard let amount = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKNumericQuestionResult)?.numericAnswer else { return nil }
            
            amounts.append(Int(truncating: amount))
        }
        
        var tobaccoInfo: TobaccoInfo?
        if nth == 1 {
            tobaccoInfo = processEverUsedTobaccoResult(with: result)
            tobaccoInfo?.amounts = amounts
        } else {
            tobaccoInfo = TobaccoInfo()
            tobaccoInfo?.amountsForEverSmoke = amounts
        }
        
        return tobaccoInfo
    }
    
    func processEverUsedTobaccoResult(with result: ORKTaskResult) -> TobaccoInfo? {
        
        guard let everUsedTobaccoResult = (result.result(forIdentifier: "everUsedTobaccoStep") as? ORKStepResult)?.result(forIdentifier: "everUsedTobaccoStep") as? ORKBooleanQuestionResult else { return nil }
        
        var tobaccoInfo: TobaccoInfo?
        let answer = everUsedTobaccoResult.booleanAnswer!
        
        if answer == 1 {
            tobaccoInfo = processTobaccoProductsSelectionResult(with: result, nth: 2)
        }else {
            tobaccoInfo = TobaccoInfo()
            tobaccoInfo?.everUseTobacco = false
        }
        
        return tobaccoInfo
    }
}
