//
//  FamilyHistoryTask.swift
//  TestMedKit
//
//  Created by Student on 2018-03-12.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class FamilyHistoryTask: Task {
    
    static let familyMembers = ["Father", "Mother", "Brother", "Sister", "Son", "Daughter", "Maternal Grandmother", "Maternal Grandfather", "Maternal Aunt", "Maternal Uncle", "Paternal Aunt", "Paternal Uncle", "Half Brother", "Half Sister", "Cousin"]
    
    init(_ viewController: UIViewController) {
        let steps = FamilyHistoryTask.createSteps()
        
        let familyHistoryTask = ORKFamilyHistoryTask(identifier: "familyHistoryTask", steps: steps)
        familyHistoryTask.familyMembers = FamilyHistoryTask.familyMembers
        
        FamilyHistoryTask.createNavigationRule(for: familyHistoryTask)
        super.init(familyHistoryTask, viewController)
    }
    
    private static func createSteps() -> [ORKStep]{
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Family History"
        instructionStep.detailText = "This survey helps us understand your family history"
        steps.append(instructionStep)
        
        steps.append(createAnyCancerStep())
        steps.append(createFamiliyMemberSelectionStep())
        
        for familyMember in familyMembers {
            steps.append(createDiagnosisStep(for: familyMember))
            steps.append(createDiagnosisAgeStep(for: familyMember))
            steps.append(createIsPassAwayStep(for: familyMember))
            steps.append(createPassAwayAgeStep(for: familyMember))
            steps.append(createCurrentAgeStep(for: familyMember))
        }
 
        Task.appendReviewStep(steps: &steps)
        return steps
    }
    
    private static func createAnyCancerStep() -> ORKStep {
        let booleanAnswerFormat = ORKBooleanAnswerFormat()
        
        return ORKQuestionStep(identifier: "anyCancerStep", title: "Is any of yor family members diagnosed with cancer?", answer: booleanAnswerFormat)
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
    
    private static func createNavigationRule(for task: ORKNavigableOrderedTask) {
        let anyCancerResult = ORKResultSelector(resultIdentifier: "anyCancerStep")
        let predicateNoForAnyCancer = ORKResultPredicate.predicateForBooleanQuestionResult(with: anyCancerResult, expectedAnswer: false)
        let predicateNoForAnyCancerRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForAnyCancer, "reviewStep")])
        task.setNavigationRule(predicateNoForAnyCancerRule, forTriggerStepIdentifier: "anyCancerStep")
        
        for familyMember in familyMembers {
            let isPassAwayResult = ORKResultSelector(resultIdentifier: familyMember.lowercased() + "_" + "IsPassAwayStep")
            let predicateNoForiIsPassAway = ORKResultPredicate.predicateForBooleanQuestionResult(with: isPassAwayResult, expectedAnswer: false)
            let predicateNoForiIsPassAwayRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForiIsPassAway, familyMember.lowercased() + "_" + "CurrentAgeStep")])
            task.setNavigationRule(predicateNoForiIsPassAwayRule, forTriggerStepIdentifier: familyMember.lowercased() + "_" + "IsPassAwayStep")
        }
    }
}
