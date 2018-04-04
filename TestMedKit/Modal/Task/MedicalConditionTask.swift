//
//  MedicalConditionTask.swift
//  TestMedKit
//
//  Created by Student on 2018-03-20.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class MedicalConditionTask: Task {
     static let medicalConditions = ["Cancer", "Asthma", "Bleeding Problems", "Blood Clots", "Blood Disorders", "Cardiovascular Disease", "Diabetes", "Emphysema", "Heart Attack", "Heart Disease", "Hypertension", "Kidney Stones", "Liver Problems", "Osteoarthritis", "Pneumonia", "Seizure", "Stroke", "Thyroid Problems", "Other"]
    
    init(_ viewController: UIViewController) {
        let steps = MedicalConditionTask.createSteps()
        
        let medicalConditionTask = ORKMedicalConditionTask(identifier: "medicalConditionTask", steps: steps)
        medicalConditionTask.medicalConditions = MedicalConditionTask.medicalConditions
        
        MedicalConditionTask.createNavigationRule(for: medicalConditionTask)
        super.init(medicalConditionTask, viewController)
    }
    
    private static func createSteps() -> [ORKStep] {
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Medical Condition History"
        instructionStep.detailText = "This survey helps us understand your medical condition history"
        steps.append(instructionStep)
        
        steps.append(createHaveAnyMedicalConditionStep())
        steps.append(createMedicalConditionSelectionStep())
        
        for medicalCondition in medicalConditions {
            steps.append(createOnsetDateStep(medicalCondiction: medicalCondition))
            steps.append(createIsTreatedStep(medicalCondiction: medicalCondition))
            steps.append(createHowIsTreated(medicalCondition: medicalCondition))
        }
        
        self.appendReviewStep(steps: &steps)
        
        return steps
    }
    
    private static func createHaveAnyMedicalConditionStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        let haveAnyMedicalConditionStep = ORKQuestionStep(identifier: "haveAnyMedicalConditionStep", title: "Do you have or have you ever had any medical condition?", answer: booleanAnswer)
        
        return haveAnyMedicalConditionStep
    }
    
    private static func createMedicalConditionSelectionStep() -> ORKStep {
        
        var textChoices: [ORKTextChoice] = []
        for medicalCondition in medicalConditions {
            textChoices.append(ORKTextChoice(text: medicalCondition, value: medicalCondition as NSString))
        }
        
        let medicalConditionSelectionAnswerFormat = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices: textChoices)
        
        let medicalConditionSelectionStep = ORKQuestionStep(identifier: "medicalConditionSelectionStep", title: "Please select all that apply", answer: medicalConditionSelectionAnswerFormat)
        
        return medicalConditionSelectionStep
    }
    
    private static func createOnsetDateStep(medicalCondiction: String) -> ORKStep {
        let dateAnswer = ORKDateAnswerFormat(style: .date)
        
        let id = medicalCondiction.lowercased() + "_" + "OnsetDateStep"
        let onsetDateStep = ORKQuestionStep(identifier: id, title: "What is the onset date of \(medicalCondiction)?", answer: dateAnswer)
        
        return onsetDateStep
    }
    
    private static func createIsTreatedStep(medicalCondiction: String) -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        let id = medicalCondiction.lowercased() + "_" + "IsTreatedStep"
        let isTreatedStep = ORKQuestionStep(identifier: id, title: "Is it treated?", answer: booleanAnswer)
        
        return isTreatedStep
    }
    
    private static func createHowIsTreated(medicalCondition: String) -> ORKStep {
        let textAnswerFormat = ORKTextAnswerFormat(maximumLength: 99)
        
        let howIsTreatedStep = ORKQuestionStep(identifier: medicalCondition.lowercased() + "_" + "HowIsTreatedStep", title: "How is/was it treated?", answer: textAnswerFormat)
        
        return howIsTreatedStep
    }
    
    private static func createNavigationRule(for task: ORKNavigableOrderedTask) {
        let haveAnyMedicalConditionResult = ORKResultSelector(resultIdentifier: "haveAnyMedicalConditionStep")
        let predicateNoForHaveAnyMedicalCondition = ORKResultPredicate.predicateForBooleanQuestionResult(with: haveAnyMedicalConditionResult, expectedAnswer: false)
        
        let predicateNoForHaveAnyMedicalConditionRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForHaveAnyMedicalCondition, "reviewStep")])
        
        task.setNavigationRule(predicateNoForHaveAnyMedicalConditionRule, forTriggerStepIdentifier: "haveAnyMedicalConditionStep")
    }
}
