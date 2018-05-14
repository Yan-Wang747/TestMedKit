//
//  GynecologicTaskResultProcessor.swift
//  TestMedKit
//
//  Created by Student on 2018-04-18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class GynecologyResultProcessor: SurveyResultProcessor {
    
    func startProcessResult(_ result: ORKTaskResult) -> SurveyResult? {
        return processHaveEverBeenPregnantResult(with: result)
    }
    
    func processHaveEverBeenPregnantResult(with result: ORKTaskResult) -> GynecologyResult? {
        guard let haveEverBeenPregnant = ((result.result(forIdentifier: "haveEverBeenPregnantStep") as? ORKStepResult)?.result(forIdentifier: "haveEverBeenPregnantStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        var gynecologyInfo: GynecologyResult?
        if haveEverBeenPregnant == 1 {
            gynecologyInfo = processNumberOfFullTimePregnaciesResult(with: result)
            gynecologyInfo?.haveEverBeenPregnant = true
        } else {
            gynecologyInfo = GynecologyResult()
        }
        
        return gynecologyInfo
    }
    
    func processNumberOfFullTimePregnaciesResult(with result: ORKTaskResult) -> GynecologyResult? {
        guard let num = ((result.result(forIdentifier: "numberOfFullTimePregnanciesStep") as? ORKStepResult)?.result(forIdentifier: "numberOfFullTimePregnanciesStep") as? ORKNumericQuestionResult)?.numericAnswer else { return nil }
        
        let gynecologyInfo = processFullTimePregnancyAgeResult(with: result)
        gynecologyInfo?.numberOfFullTimePregnancies = num as? Int
        
        return gynecologyInfo
    }
    
    func processFullTimePregnancyAgeResult(with result: ORKTaskResult) -> GynecologyResult? {
        guard let age = ((result.result(forIdentifier: "fullTimePregnancyAgeStep") as? ORKStepResult)?.result(forIdentifier: "fullTimePregnancyAgeStep") as? ORKNumericQuestionResult)?.numericAnswer else { return nil }
        
        let gynecologyInfo = processNumberOfMiscarriagesResult(with: result)
        
        gynecologyInfo?.fullTimePregnancyAge = age as? Int
        
        return gynecologyInfo
    }
    
    func processNumberOfMiscarriagesResult(with result: ORKTaskResult) -> GynecologyResult? {
        guard let num = ((result.result(forIdentifier: "numberOfMiscarriagesStep") as? ORKStepResult)?.result(forIdentifier: "numberOfMiscarriagesStep") as? ORKNumericQuestionResult)?.numericAnswer else { return nil }
        
        let gynecologyInfo = processMiscarriageAgeResult(with: result)
        gynecologyInfo?.numberOfMiscarriages = num as? Int
        
        return gynecologyInfo
    }
    
    func processMiscarriageAgeResult(with result: ORKTaskResult) -> GynecologyResult? {
        guard let age = ((result.result(forIdentifier: "miscarriageAgeStep") as? ORKStepResult)?.result(forIdentifier: "miscarriageAgeStep") as? ORKNumericQuestionResult)?.numericAnswer as? Int else { return nil }
        
        let gynecoloyInfo = processNumberOfTerminatedPregnanciesResult(with: result)
        
        gynecoloyInfo?.miscarriageAge = age
        
        return gynecoloyInfo
    }
    
    func processNumberOfTerminatedPregnanciesResult(with result: ORKTaskResult) -> GynecologyResult? {
        guard let num = ((result.result(forIdentifier: "numberOfTerminatedPregnanciesStep") as? ORKStepResult)?.result(forIdentifier: "numberOfTerminatedPregnanciesStep") as? ORKNumericQuestionResult)?.numericAnswer as? Int else { return nil }
        
        let gynecologyInfo = processTerminatedPregnancyAgeResult(with: result)
        gynecologyInfo?.numberOfTerminatedPregnancies = num
        
        return gynecologyInfo
    }
    
    func processTerminatedPregnancyAgeResult(with result: ORKTaskResult) -> GynecologyResult? {
        guard let age = ((result.result(forIdentifier: "terminatedPregnancyAgeStep") as? ORKStepResult)?.result(forIdentifier: "terminatedPregnancyAgeStep") as? ORKNumericQuestionResult)?.numericAnswer as? Int else { return nil }
        
        let gynecologyInfo = processMenstrualCycle(with: result)
        gynecologyInfo?.terminatedPregnancyAge = age
        
        return gynecologyInfo
    }
    
    func processMenstrualCycle(with result: ORKTaskResult) -> GynecologyResult? {
        guard let menstrualCycle = ((result.result(forIdentifier: "menstrualCycleStep") as? ORKStepResult)?.result(forIdentifier: "menstrualCycleStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        var gynecoloyInfo: GynecologyResult?
        if menstrualCycle == 1 {
            gynecoloyInfo = processMenstruateStartAgeResult(with: result)
            gynecoloyInfo?.menstrualCycle = true
        } else {
            gynecoloyInfo = processIsMenopauseBegunResult(with: result)
        }
        
        return gynecoloyInfo
    }
    
    func processMenstruateStartAgeResult(with result: ORKTaskResult) -> GynecologyResult? {
        guard let age = ((result.result(forIdentifier: "menstruateStartAgeStep") as? ORKStepResult)?.result(forIdentifier: "menstruateStartAgeStep") as? ORKNumericQuestionResult)?.numericAnswer as? Int else { return nil }
        
        let gynecoloyInfo = processLastMenstrualPeriodResult(with: result)
        
        gynecoloyInfo?.menstruateStartAge = age
        
        return gynecoloyInfo
    }
    
    func processLastMenstrualPeriodResult(with result: ORKTaskResult) -> GynecologyResult? {
        guard let date = ((result.result(forIdentifier: "lastMenstrualPeriodStep") as? ORKStepResult)?.result(forIdentifier: "lastMenstrualPeriodStep") as? ORKDateQuestionResult)?.dateAnswer else { return nil }
        
        let gynecologyInfo = processMenstrualCycleLengthResult(with: result)
        gynecologyInfo?.lastMenstrualPeriod = date
        
        return gynecologyInfo
    }
    
    func processMenstrualCycleLengthResult(with result: ORKTaskResult) -> GynecologyResult? {
        guard let length = ((result.result(forIdentifier: "menstrualCycleLengthStep") as? ORKStepResult)?.result(forIdentifier: "menstrualCycleLengthStep") as? ORKNumericQuestionResult)?.numericAnswer as? Int else { return nil }
        
        let gynecologyInfo = processIsMenopauseBegunResult(with: result)
        gynecologyInfo?.menstrualCycleLength = length
        
        return gynecologyInfo
    }
    
    func processIsMenopauseBegunResult(with result: ORKTaskResult) -> GynecologyResult? {
        guard let isMenopauseBegun = ((result.result(forIdentifier: "isMenopauseBegunStep") as? ORKStepResult)?.result(forIdentifier: "isMenopauseBegunStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        var gynecologyInfo: GynecologyResult?
        if isMenopauseBegun == 1 {
            gynecologyInfo = processMenopauseStatusSelectionResult(with: result)
        } else {
            gynecologyInfo = processHaveEverUsedHormonesStepResult(with: result)
        }
        
        return gynecologyInfo
    }
    
    func processMenopauseStatusSelectionResult(with result: ORKTaskResult) -> GynecologyResult? {
        guard let selectedStatuses = ((result.result(forIdentifier: "menopauseStatusSelectionStep") as? ORKStepResult)?.result(forIdentifier: "menopauseStatusSelectionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else { return nil }
        
        var gynecologyInfo: GynecologyResult?
        if selectedStatuses.contains("Postmenopausal") {
            gynecologyInfo = processPostmenopausalAgeResult(with: result)
        } else {
            gynecologyInfo = processMenopauseReasonSelectionResult(with: result)
        }
        
        gynecologyInfo?.menopauseStatusSelections = selectedStatuses
        
        return gynecologyInfo
    }
    
    func processPostmenopausalAgeResult(with result: ORKTaskResult) -> GynecologyResult? {
        guard let age = ((result.result(forIdentifier: "postmenopausalAgeStep") as? ORKStepResult)?.result(forIdentifier: "postmenopausalAgeStep") as? ORKNumericQuestionResult)?.numericAnswer as? Int else { return nil }
        
        let gynecologyInfo = processMenopauseReasonSelectionResult(with: result)
        gynecologyInfo?.postmenopausalAge = age
        
        return gynecologyInfo
    }
    
    func processMenopauseReasonSelectionResult(with result: ORKTaskResult) -> GynecologyResult? {
        guard let selectedReasons = ((result.result(forIdentifier: "menopauseReasonSelectionStep") as? ORKStepResult)?.result(forIdentifier: "menopauseReasonSelectionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else { return nil }
        
        let gynecologyInfo = processHaveEverUsedHormonesStepResult(with: result)
        gynecologyInfo?.menopauseReasons = selectedReasons
        
        return gynecologyInfo
    }
    
    func processHaveEverUsedHormonesStepResult(with result: ORKTaskResult) -> GynecologyResult? {
        guard let haveEverUsedHormones = ((result.result(forIdentifier: "haveEverUsedHormonesStep") as? ORKStepResult)?.result(forIdentifier: "haveEverUsedHormonesStep") as? ORKBooleanQuestionResult)?.booleanAnswer else { return nil }
        
        var gynecologyInfo: GynecologyResult?
        if haveEverUsedHormones == 1 {
            gynecologyInfo = processHormoneSelectionResult(with: result)
            gynecologyInfo?.haveEverUsedHormones = true
        } else {
            gynecologyInfo = processLastPAPSmearDateResult(with: result)
        }
        
        return gynecologyInfo
    }
    
    func processHormoneSelectionResult(with result: ORKTaskResult) -> GynecologyResult? {
        guard let selectedHormones = ((result.result(forIdentifier: "hormoneSelectionStep") as? ORKStepResult)?.result(forIdentifier: "hormoneSelectionStep") as? ORKChoiceQuestionResult)?.choiceAnswers as? [String] else { return nil }
        
        let gynecologyInfo = processHowManyYears(with: result, selectedHormones: selectedHormones)
        gynecologyInfo?.hormoneSelections = selectedHormones
        
        return gynecologyInfo
    }
    
    func processHowManyYears(with result: ORKTaskResult, selectedHormones: [String]) -> GynecologyResult? {
        
        var years: [Int] = []
        for selectedHormone in selectedHormones {
            let id = selectedHormone.lowercased() + "_" + "HowManyYearsStep"
            guard let year = ((result.result(forIdentifier: id) as? ORKStepResult)?.result(forIdentifier: id) as? ORKNumericQuestionResult)?.numericAnswer as? Int else { return nil }
            years.append(year)
        }
        
        let gynecologyInfo = processLastPAPSmearDateResult(with: result)
        gynecologyInfo?.hormoneYears = years
        
        return gynecologyInfo
    }
    
    func processLastPAPSmearDateResult(with result: ORKTaskResult) -> GynecologyResult? {
        guard let date = ((result.result(forIdentifier: "lastPAPSmearDateStep") as? ORKStepResult)?.result(forIdentifier: "lastPAPSmearDateStep") as? ORKDateQuestionResult)?.dateAnswer else { return nil }
        
        let gynecologyInfo = processLastMammogramDate(with: result)
        gynecologyInfo?.lastPAPSmearDate = date
        
        return gynecologyInfo
    }
    
    func processLastMammogramDate(with result: ORKTaskResult) -> GynecologyResult? {
        guard let date = ((result.result(forIdentifier: "lastMammogramDateStep") as? ORKStepResult)?.result(forIdentifier: "lastMammogramDateStep") as? ORKDateQuestionResult)?.dateAnswer else { return nil }
        
        let gynecologyInfo = GynecologyResult()
        gynecologyInfo.lastMammogramDate = date
        
        return gynecologyInfo
    }
}
