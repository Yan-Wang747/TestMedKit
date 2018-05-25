//
//  GynecologicTask.swift
//  TestMedKit
//
//  Created by Student on 2018-03-21.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class GynecologyFactory: SurveyFactory {
    static func getEndpoint() -> String {
        return Server.Endpoints.Gynecology.rawValue
    }
    
    static func createResultProcessor() -> SurveyResultProcessor {
        return GynecologyResultProcessor()
    }
    
    static let hormoneTypeStrings = ["Contraceptive", "Post Menopause Use", "Other Hormone Use"]
    static let menopauseStatuses = ["Premenopausal", "Perimenopause", "Postmenopausal", "Unknown"]
    
    static func createSteps() -> [ORKStep] {
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Gynecology History"
        instructionStep.detailText = "This survey helps us understand your Gynecology history"
        steps.append(instructionStep)
        
        steps.append(createHaveEverBeenPregnantStep())
        steps.append(createNumberOfFullTimePregnanciesStep())
        steps.append(createFullTimePregnancyAgeStep())
        steps.append(createNumberOfMiscarriagesStep())
        steps.append(createMiscarriageAgeStep())
        steps.append(createNumberOfTerminatedPregnanciesStep())
        steps.append(createTerminatedPregnancyAgeStep())
        steps.append(createMenstrualCycleStep())
        steps.append(createMenstruateStartAgeStep())
        steps.append(createLastMenstrualPeriodStep())
        steps.append(createMenstrualCycleLengthStep())
        steps.append(createIsMenopauseBegunStep())
        steps.append(createMenopauseStatusSelectionStep())
        steps.append(createPostmenopausalAgeStep())
        steps.append(createMenopauseReasonSelectionStep())
        steps.append(createHaveEverUsedHormonesStep())
        steps.append(createHormoneSelectionStep())
        
        for hormone in hormoneTypeStrings {
            steps.append(createHowManyYearsStep(for: hormone))
        }
        
        steps.append(createLastPAPSmearDateStep())
        steps.append(createLastMammogramDateStep())
        
        return steps
    }
    
    private static func createHaveEverBeenPregnantStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        let haveEverBeenPregnantStep = ORKQuestionStep(identifier: "haveEverBeenPregnantStep", title: "Have you ever been pregnant?", answer: booleanAnswer)
        
        return haveEverBeenPregnantStep
    }
    
    private static func createNumberOfFullTimePregnanciesStep() -> ORKStep {
        let numericalAnswerFormat = ORKNumericAnswerFormat(style: .integer)
        
        let numberOfFullTimePregnanciesStep = ORKQuestionStep(identifier: "numberOfFullTimePregnanciesStep", title: "Number of full time pregnancies?", answer: numericalAnswerFormat)
        
        return numberOfFullTimePregnanciesStep
    }
    
    private static func createFullTimePregnancyAgeStep() -> ORKStep {
        let ageNumericalAnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: nil, minimum: 1, maximum: 200)
        
        let fullTimePregnancyAgeStep = ORKQuestionStep(identifier: "fullTimePregnancyAgeStep", title: "What was your age?", answer: ageNumericalAnswerFormat)
        
        return fullTimePregnancyAgeStep
    }
    
    private static func createNumberOfMiscarriagesStep() -> ORKStep {
        let numericalAnswerFormat = ORKNumericAnswerFormat(style: .integer)
        
        let numberOfMiscarriagesStep = ORKQuestionStep(identifier: "numberOfMiscarriagesStep", title: "Number of miscarriages?", answer: numericalAnswerFormat)
        
        return numberOfMiscarriagesStep
    }
    
    private static func createMiscarriageAgeStep() -> ORKStep {
        let ageNumericalAnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: nil, minimum: 1, maximum: 200)
        
        let miscarriageAgeStep = ORKQuestionStep(identifier: "miscarriageAgeStep", title: "What was your age?", answer: ageNumericalAnswerFormat)
        
        return miscarriageAgeStep
    }
    
    private static func createNumberOfTerminatedPregnanciesStep() -> ORKStep {
        let numericalAnswerFormat = ORKNumericAnswerFormat(style: .integer)
        
        let numberOfTerminatedPregnanciesStep = ORKQuestionStep(identifier: "numberOfTerminatedPregnanciesStep", title: "Number of terminated pregnancies?", answer: numericalAnswerFormat)
        
        return numberOfTerminatedPregnanciesStep
    }
    
    private static func createTerminatedPregnancyAgeStep() -> ORKStep {
        let ageNumericalAnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: nil, minimum: 1, maximum: 200)
        
        let terminatedPregnancyAgeStep = ORKQuestionStep(identifier: "terminatedPregnancyAgeStep", title: "What was your age?", answer: ageNumericalAnswerFormat)
        
        return terminatedPregnancyAgeStep
    }
    
    private static func createMenstrualCycleStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        let menstrualCycleStep = ORKQuestionStep(identifier: "menstrualCycleStep", title: "Do you currently have a menstrual cycle?", answer: booleanAnswer)
        
        return menstrualCycleStep
    }
    
    private static func createMenstruateStartAgeStep() -> ORKStep {
        let ageNumericalAnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: nil, minimum: 1, maximum: 200)
        
        let menstruateStartAgeStep = ORKQuestionStep(identifier: "menstruateStartAgeStep", title: "What was your age?", answer: ageNumericalAnswerFormat)
        
        return menstruateStartAgeStep
    }

    private static func createLastMenstrualPeriodStep() -> ORKStep {
        let dateAnswerFormat = ORKDateAnswerFormat(style: .date)
        
        let lastMenstrualPeriodStep = ORKQuestionStep(identifier: "lastMenstrualPeriodStep", title: "When was your last menstrual period?", answer: dateAnswerFormat)
        
        return lastMenstrualPeriodStep
    }
    
    private static func createMenstrualCycleLengthStep() -> ORKStep {
        let numericalAnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "days")
        
        let menstrualCycleLengthStep = ORKQuestionStep(identifier: "menstrualCycleLengthStep", title: "How Long does your cycle last (in days)?", answer: numericalAnswerFormat)
        
        return menstrualCycleLengthStep
    }
    
    private static func createIsMenopauseBegunStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        let isMenopauseBegunStep = ORKQuestionStep(identifier: "isMenopauseBegunStep", title: "Have you begun menopause?", answer: booleanAnswer)
        
        return isMenopauseBegunStep
    }
    
    private static func createMenopauseStatusSelectionStep() -> ORKStep {
        
        var statusChoices: [ORKTextChoice] = []
        
        for status in menopauseStatuses {
            statusChoices.append(ORKTextChoice(text: status, value: status as NSString))
        }
        
        let menopauseStatusSelectionAnswerFormat = ORKTextChoiceAnswerFormat(style: .singleChoice
            , textChoices: statusChoices)
        
        let menopauseStatusSelectionStep = ORKQuestionStep(identifier: "menopauseStatusSelectionStep", title: "Select the answer that best describes the status:", answer: menopauseStatusSelectionAnswerFormat)
        
        return menopauseStatusSelectionStep
    }
    
    private static func createPostmenopausalAgeStep() -> ORKStep {
        let ageAnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: nil, minimum: 1, maximum: 200)
        
        let postmenopausalAgeStep = ORKQuestionStep(identifier: "postmenopausalAgeStep", title: "At what age?", answer: ageAnswerFormat)
        
        return postmenopausalAgeStep
    }
    
    private static func createMenopauseReasonSelectionStep() -> ORKStep {
        let reasonStrings = ["Chemotherapy", "Natural", "Removal of ovaries", "Removal of uterus", "Surgery", "Total Hysterectomy"]
        
        var reasonChoices: [ORKTextChoice] = []
        
        for reason in reasonStrings {
            reasonChoices.append(ORKTextChoice(text: reason, value: reason as NSString))
        }
        
        let reasonSelectionAnswerFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: reasonChoices)
        
        let menopauseReasonSelectionStep = ORKQuestionStep(identifier: "menopauseReasonSelectionStep", title: "Reason for Menopause?", answer: reasonSelectionAnswerFormat)
        
        return menopauseReasonSelectionStep
    }
    
    private static func createHaveEverUsedHormonesStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        let haveEverUsedHormonesStep = ORKQuestionStep(identifier: "haveEverUsedHormonesStep", title: "Have you ever used any hormones?", answer: booleanAnswer)
        
        return haveEverUsedHormonesStep
    }
    
    private static func createHormoneSelectionStep() -> ORKStep {
        
        
        var hormoneChoices: [ORKTextChoice] = []
        
        for hormone in hormoneTypeStrings {
            hormoneChoices.append(ORKTextChoice(text: hormone, value: hormone as NSString))
        }
        
        let hormoneSelectionAnswerFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: hormoneChoices)
        
        let hormoneSelectionStep = ORKQuestionStep(identifier: "hormoneSelectionStep", title: "Please select all that apply", answer: hormoneSelectionAnswerFormat)
        
        return hormoneSelectionStep
    }
    
    private static func createHowManyYearsStep(for hormone: String) -> ORKStep {
        let yearsAnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "Years")
        
        let howManyYearsStep = ORKQuestionStep(identifier: hormone.lowercased() + "_" + "HowManyYearsStep", title: "How many years", answer: yearsAnswerFormat)
        
        return howManyYearsStep
    }
    
    private static func createLastPAPSmearDateStep() -> ORKStep {
        let dateAnswerFormat = ORKDateAnswerFormat(style: .date)
        
        let lastPAPSmearDateStep = ORKQuestionStep(identifier: "lastPAPSmearDateStep", title: "What is the date of your last PAP Smear?", answer: dateAnswerFormat)
        
        return lastPAPSmearDateStep
    }
    
    private static func createLastMammogramDateStep() -> ORKStep {
        let dateAnswerFormat = ORKDateAnswerFormat(style: .date)
        
        let lastMammogramDateStep = ORKQuestionStep(identifier: "lastMammogramDateStep", title: "What is the date of your last mammogram?", answer: dateAnswerFormat)
        
        return lastMammogramDateStep
    }
    
    static func createORKTask(identifier: String, steps: [ORKStep]) -> ORKNavigableOrderedTask {
        let orkTask = ORKGynecologyTask(identifier: identifier, steps: steps)
        createNavigationRule(for: orkTask)
        
        return orkTask
    }
    
    static func createNavigationRule(for gynecologicTask: ORKNavigableOrderedTask) {
        let haveEverBeenPregnantResultSelector = ORKResultSelector(resultIdentifier: "haveEverBeenPregnantStep")
        
        let predicateNoForHaveEverBeenPregnant = ORKResultPredicate.predicateForBooleanQuestionResult(with: haveEverBeenPregnantResultSelector, expectedAnswer: false)
        
        let predicateNoForHaveEverBeenPregnantRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForHaveEverBeenPregnant, "menstrualCycleStep")])
        
        gynecologicTask.setNavigationRule(predicateNoForHaveEverBeenPregnantRule, forTriggerStepIdentifier: "haveEverBeenPregnantStep")
        
        let menstrualCycleResultSelector = ORKResultSelector(resultIdentifier: "menstrualCycleStep")
        
        let predicateNoForMenstrualCycle = ORKResultPredicate.predicateForBooleanQuestionResult(with: menstrualCycleResultSelector, expectedAnswer: false)
        
        let predicateNoForMenstrualCycleRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForMenstrualCycle, "isMenopauseBegunStep")])
        
        gynecologicTask.setNavigationRule(predicateNoForMenstrualCycleRule, forTriggerStepIdentifier: "menstrualCycleStep")
        
        let isMenopauseBegunResultSelector = ORKResultSelector(resultIdentifier: "isMenopauseBegunStep")
        
        let predicateNoForIsMenopauseBegun = ORKResultPredicate.predicateForBooleanQuestionResult(with: isMenopauseBegunResultSelector, expectedAnswer: false)
        
        let predicateNoForIsMenopauseBegunRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForIsMenopauseBegun, "haveEverUsedHormonesStep")])
        
        gynecologicTask.setNavigationRule(predicateNoForIsMenopauseBegunRule, forTriggerStepIdentifier: "isMenopauseBegunStep")
        
        let haveEverUsedHormoneResult = ORKResultSelector(resultIdentifier: "haveEverUsedHormonesStep")
        
        let predicateNoForHaveEverUsedHormone = ORKResultPredicate.predicateForBooleanQuestionResult(with: haveEverUsedHormoneResult, expectedAnswer: false)
        
        let predicateNoForHaveEverUsedHormoneRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForHaveEverUsedHormone, "lastPAPSmearDateStep")])
        
        gynecologicTask.setNavigationRule(predicateNoForHaveEverUsedHormoneRule, forTriggerStepIdentifier: "haveEverUsedHormonesStep")
        
        let menopauseStatusSelectionResult = ORKResultSelector(resultIdentifier: "menopauseStatusSelectionStep")
        let predicatePostmenopausalIsSelected = ORKResultPredicate.predicateForChoiceQuestionResult(with: menopauseStatusSelectionResult, expectedAnswerValue: "Postmenopausal" as NSString)
        
        let predicatePostmenopausalIsSelectedRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicatePostmenopausalIsSelected, "postmenopausalAgeStep")], defaultStepIdentifierOrNil: "menopauseReasonSelectionStep")
        
        gynecologicTask.setNavigationRule(predicatePostmenopausalIsSelectedRule, forTriggerStepIdentifier: "menopauseStatusSelectionStep")
        
        for hormone in hormoneTypeStrings {
        
            let howManyYearsJumpRule = ORKDirectStepNavigationRule(destinationStepIdentifier: "lastPAPSmearDateStep")
            gynecologicTask.setNavigationRule(howManyYearsJumpRule, forTriggerStepIdentifier: hormone.lowercased() + "_" + "HowManyYearsStep")
        }
        
        
    }
}
