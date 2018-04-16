//
//  MedicationTask.swift
//  TestMedKit
//
//  Created by Student on 2018-03-15.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class MedicationTask: Task {
    static let medTypes = ["Prescription", "Over-the-Counter", "Herbal"]
    
    init(_ viewController: UIViewController, patient: Patient) {
        let steps = MedicationTask.createSteps()
        
        let medicationTask = ORKNavigableOrderedTask(identifier: "medicationTask", steps: steps)
        MedicationTask.createNavigationRule(for: medicationTask)
        
        let delegate = MedicationTaskResultProcessor(patient: patient)
        delegate.medTypes = MedicationTask.medTypes
        super.init(task: medicationTask, viewController: viewController, delegate: delegate)
    }
    
    
    
    private static func createSteps() -> [ORKStep] {
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Medication History"
        instructionStep.detailText = "This survey helps us understand your medication history"
        steps.append(instructionStep)
        
        for medType in medTypes {
            steps.append(createTakeAnyMedicationStep(medType: medType))
            steps.append(createMedicationNameStep(medType: medType))
            steps.append(createMedicationDoseUnitStep(medType: medType))
            steps.append(createMedicationDoseAmountStep(medType: medType))
            steps.append(createMedicationFrequencyStep(medType: medType))
            steps.append(createMedicationStartDateStep(medType: medType))
        }

        self.appendReviewStep(steps: &steps)
        
        return steps
    }
    
    private static func createTakeAnyMedicationStep(medType: String) -> ORKStep {
        let id = medType.lowercased() + "_" + "TakeAnyMedicationStep"
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        return ORKQuestionStep(identifier: id, title: "Do you currently take any \(medType) medications?", answer: booleanAnswer)
    }
    
    private static func createMedicationNameStep(medType: String) -> ORKStep {
        let textAnswerFormat = ORKTextAnswerFormat(maximumLength: 99)
        
        return ORKQuestionStep(identifier: medType.lowercased() + "_" + "NameStep", title: "Using the information supplied on the pharmacy label please complete the following, what is the name of the medication.", answer: textAnswerFormat)
    }
    
    private static func createMedicationDoseUnitStep(medType: String) -> ORKStep {
        let doseUnitAnswerFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices:
            [ORKTextChoice(text: "mg", value: "mg" as NSString),
             ORKTextChoice(text: "Mcg", value: "Mcg" as NSString),
             ORKTextChoice(text: "G", value: "G" as NSString),
             ORKTextChoice(text: "mL", value: "mL" as NSString),
             ORKTextChoice(text: "L", value: "L" as NSString),
             ORKTextChoice(text: "Units", value: "Units" as NSString),
             ORKTextChoice(text: "Tablets", value: "Tablets" as NSString),
             ORKTextChoice(text: "Capsules", value: "Capsules" as NSString),
             ORKTextChoice(text: "Puffs", value: "Puffs" as NSString),
             ORKTextChoice(text: "Drops", value: "Drops" as NSString)
            ])

        
        return ORKQuestionStep(identifier: medType.lowercased() + "_" + "DoseUnitStep", title: "What is the dose unit", answer: doseUnitAnswerFormat)
    }
    
    private static func createMedicationDoseAmountStep(medType: String) -> ORKStep {
        let numberAnswerFormat = ORKNumericAnswerFormat(style: .decimal)
        
        return ORKQuestionStep(identifier: medType.lowercased() + "_" + "DoseAmountStep", title: "What is the dose", answer: numberAnswerFormat)
    }
    
    private static func createMedicationFrequencyStep(medType: String) -> ORKStep {
        let frequencyAnswerFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices:
            [ORKTextChoice(text: "Once daily", value: "Once daily" as NSString),
             ORKTextChoice(text: "Twice daily", value: "Twice daily" as NSString),
             ORKTextChoice(text: "Three times daily", value: "Three times daily" as NSString),
             ORKTextChoice(text: "Four times daily", value: "Four times daily" as NSString),
             ORKTextChoice(text: "Every certain hours (see next screen)", value: "Every certain hours" as NSString),
             ORKTextChoice(text: "At bedtime", value: "At bedtime" as NSString),
             ORKTextChoice(text: "Before meals", value: "Before meals" as NSString),
             ORKTextChoice(text: "After meals", value: "After meals" as NSString),
             ORKTextChoice(text: "As required", value: "As required" as NSString)
            ])
        
        return ORKQuestionStep(identifier: medType.lowercased() + "_" + "FrequencyStep", title: "How often do you take it", answer: frequencyAnswerFormat)
    }
    
    private static func createIntakeWayStep(medType: String) -> ORKStep {
        let takenWayAnswerFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices:
            [ORKTextChoice(text: "Orally", value: "Orally" as NSString),
             ORKTextChoice(text: "Injection", value: "Injection" as NSString),
             ORKTextChoice(text: "Rectally", value: "Rectally" as NSString),
             ORKTextChoice(text: "In the eye", value: "In the eye" as NSString),
             ORKTextChoice(text: "In the ear", value: "In the ear" as NSString),
             ORKTextChoice(text: "At bedtime", value: "At bedtime" as NSString),
             ORKTextChoice(text: "Nasally", value: "Nasally" as NSString),
             ORKTextChoice(text: "Topically", value: "Topically" as NSString),
             ORKTextChoice(text: "vaginally", value: "vaginally" as NSString)
            ])
        
        return ORKQuestionStep(identifier: medType.lowercased() + "_" + "IntakeWayStep", title: "How is it taken", answer: takenWayAnswerFormat)
    }
    
    private static func createMedicationStartDateStep (medType: String) -> ORKStep {
        let dateAnswerFormat = ORKDateAnswerFormat(style: .date)
        
        return ORKQuestionStep(identifier: medType.lowercased() + "_" + "StartDateStep", title: "When did you start?", answer: dateAnswerFormat)
    }
    
    private static func createNavigationRule(for task: ORKNavigableOrderedTask) {
        for medType in medTypes {
            createTakeAnyMedicationStepRule(for: task, medType: medType)
        }
    }
    
    static func createTakeAnyMedicationStepRule(for task: ORKNavigableOrderedTask, medType: String) {

        let id = medType.lowercased() + "_" + "TakeAnyMedicationStep"
        let index = medTypes.index(of: medType)!
        let nextId = index == medTypes.count - 1 ? "reviewStep" : medTypes[index + 1].lowercased() + "_" + "TakeAnyMedicationStep"
        
        let takeAnyMedicationResult = ORKResultSelector(resultIdentifier: id)
        
        let predicateNoForTakeAnyMedication = ORKResultPredicate.predicateForBooleanQuestionResult(with: takeAnyMedicationResult, expectedAnswer: false)
        
        let predicateNoForTakeAnyMedicationRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForTakeAnyMedication, nextId)])
        task.setNavigationRule(predicateNoForTakeAnyMedicationRule, forTriggerStepIdentifier: id)
    }
}
