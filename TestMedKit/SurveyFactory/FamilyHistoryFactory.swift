//
//  FamilyHistoryTask.swift
//  TestMedKit
//
//  Created by Student on 2018-03-12.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class FamilyHistoryFactory: SurveyFactory {
    
    static func getEndpoint() -> String {
        return Server.Endpoints.Family.rawValue
    }
    
    static func createResultProcessor() -> SurveyResultProcessor {
        return FamilyHistoryResultProcessor()
    }
    
    
    static let familyMembers = ["Father", "Mother", "Brother", "Sister", "Son", "Daughter", "Maternal Grandmother", "Maternal Grandfather", "Maternal Aunt", "Maternal Uncle", "Paternal Aunt", "Paternal Uncle", "Half Brother", "Half Sister", "Cousin"]
    
    static func createSteps() -> [ORKStep]{
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Family History"
        instructionStep.detailText = "This survey helps us understand your family history"
        steps.append(instructionStep)
        
        steps.append(createHaveAnyCancerStep())
        steps.append(createFamiliyMemberSelectionStep())
        
        for familyMember in familyMembers {
            steps.append(createDiagnosisStep(for: familyMember))
            steps.append(createDiagnosisAgeStep(for: familyMember))
            steps.append(createIsPassAwayStep(for: familyMember))
            steps.append(createPassAwayAgeStep(for: familyMember))
            steps.append(createCurrentAgeStep(for: familyMember))
        }

        return steps
    }
    
    private static func createHaveAnyCancerStep() -> ORKStep {
        let booleanAnswerFormat = ORKBooleanAnswerFormat()
        
        return ORKQuestionStep(identifier: "haveAnyCancerStep", title: "Is any of yor family members diagnosed with cancer?", answer: booleanAnswerFormat)
    }
    
    private static func createFamiliyMemberSelectionStep() -> ORKStep {
        var familyMemberChoices: [ORKTextChoice] = []
        
        for familyMember in familyMembers {
            familyMemberChoices.append(ORKTextChoice(text: familyMember, value: familyMember as NSString))
        }
        
        let familyMemberSelectionAnswerFormat = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices: familyMemberChoices)
        
        return ORKQuestionStep(identifier: "familiyMemberSelectionStep", title: "From the following list Select all family members who have been diagnosis with Cancer or a Blood Disorder:", answer: familyMemberSelectionAnswerFormat)
    }
    
    private static func createDiagnosisStep(for familyMember: String) -> ORKStep {
        let id = familyMember.lowercased() + "_" + "DiagnosisStep"
        let textAnswerFormat = ORKTextAnswerFormat(maximumLength: 99)
        
        return ORKQuestionStep(identifier: id, title: "What was your \(familyMember)'s diagnosis?", answer: textAnswerFormat)
    }
    
    private static func createDiagnosisAgeStep(for familyMember: String) -> ORKStep {
        let id = familyMember.lowercased() + "_" + "DiagnosisAgeStep"
        let ageAnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: nil, minimum: 1, maximum: 200)
        
        return ORKQuestionStep(identifier: id, title: "At What Age was your \(familyMember) Diagnosed?", answer: ageAnswerFormat)
    }
    
    private static func createIsPassAwayStep(for familyMember: String) -> ORKStep {
        let id = familyMember.lowercased() + "_" + "IsPassAwayStep"
        let booleanAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        return ORKQuestionStep(identifier: id, title: "Did your \(familyMember) pass away as a result of their diagnosis?", answer: booleanAnswerFormat)
    }
    
    private static func createPassAwayAgeStep(for familyMember: String) -> ORKStep {
        let id = familyMember.lowercased() + "_" + "PassAwayAgeStep"
        let ageAnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: nil, minimum: 1, maximum: 200)
        
        return ORKQuestionStep(identifier: id, title: "At what age?", answer: ageAnswerFormat)
    }
    
    private static func createCurrentAgeStep(for familyMember: String) -> ORKStep {
        let id = familyMember.lowercased() + "_" + "CurrentAgeStep"
        let ageAnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: nil, minimum: 1, maximum: 200)
        
        return ORKQuestionStep(identifier: id, title: "What is your \(familyMember) current age?", answer: ageAnswerFormat)
    }
    
    static func createORKTask(identifier: String, steps: [ORKStep]) -> ORKNavigableOrderedTask {
        let orkTask = ORKFamilyHistoryTask(identifier: identifier, steps: steps)
        createNavigationRule(for: orkTask)
        
        return orkTask
    }
    
    static func createNavigationRule(for familyTask: ORKNavigableOrderedTask) {
        
        createHaveAnyCancerStepRule(for: familyTask)
        createIsPassAwayStepRule(for: familyTask)
    }
    
    private static func createHaveAnyCancerStepRule(for task: ORKNavigableOrderedTask) {
        let anyCancerResult = ORKResultSelector(resultIdentifier: "haveAnyCancerStep")
        let predicateNoForAnyCancer = ORKResultPredicate.predicateForBooleanQuestionResult(with: anyCancerResult, expectedAnswer: false)
        let predicateNoForAnyCancerRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForAnyCancer, "reviewStep")])
        task.setNavigationRule(predicateNoForAnyCancerRule, forTriggerStepIdentifier: "haveAnyCancerStep")
    }
    
   private static func createIsPassAwayStepRule(for task: ORKNavigableOrderedTask) {
        for familyMember in familyMembers {
            let isPassAwayResult = ORKResultSelector(resultIdentifier: familyMember.lowercased() + "_" + "IsPassAwayStep")
            let predicateNoForIsPassAway = ORKResultPredicate.predicateForBooleanQuestionResult(with: isPassAwayResult, expectedAnswer: false)
            let predicateNoForIsPassAwayRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForIsPassAway, familyMember.lowercased() + "_" + "CurrentAgeStep")])
            task.setNavigationRule(predicateNoForIsPassAwayRule, forTriggerStepIdentifier: familyMember.lowercased() + "_" + "IsPassAwayStep")
        }
    
    }
}
