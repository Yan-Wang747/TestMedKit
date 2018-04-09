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
    init(_ viewController: UIViewController, patient: Patient) {
        let steps = MedicationTask.createSteps()
        
        let medicationTask = ORKNavigableOrderedTask(identifier: "medicationTask", steps: steps)
        MedicationTask.createNavigationRule(for: medicationTask)
        super.init(task: medicationTask, viewController: viewController, delegate: TaskResultProcessor(patient: patient))
    }
    
    static let medTypes = ["Prescription", "Over-the-Counter", "Herbal"]
    
    private static func createSteps() -> [ORKStep] {
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Medication History"
        instructionStep.detailText = "This survey helps us understand your medication history"
        steps.append(instructionStep)
        
        let createTakeAnyFunctions = [createTakeAnyPrescriptionMedicationStep, createTakeAnyOverTheCounterMedicationStep, createTakeHerbalProductsStep]
        
        var i = 0
        for medType in medTypes {
            steps.append(createTakeAnyFunctions[i]())
            i += 1
            steps.append(createMedicationNameStep(medType: medType))
            steps.append(createMedicationDoseUnitStep(medType: medType))
            steps.append(createMedicationDoseAmountStep(medType: medType))
            steps.append(createMedicationFrequencyStep(medType: medType))
            steps.append(createMedicationTakenWayStep(medType: medType))
            steps.append(createmedicationStartDateStep(medType: medType))
        }

        self.appendReviewStep(steps: &steps)
        
        return steps
    }
    
    private static func createTakeAnyPrescriptionMedicationStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        let takeAnyPrescriptionMedicationStep = ORKQuestionStep(identifier: "takeAnyPrescriptionMedicationStep", title: "Do you currently take any Prescription medications?", answer: booleanAnswer)
        
        return takeAnyPrescriptionMedicationStep
    }
    
    private static func createMedicationNameStep(medType: String) -> ORKStep {
        let textAnswerFormat = ORKTextAnswerFormat(maximumLength: 99)
        
        let nameStep = ORKQuestionStep(identifier: medType.lowercased() + "_" + "NameStep", title: "Using the information supplied on the pharmacy label please complete the following, what is the name of the medication.", answer: textAnswerFormat)
        
        return nameStep
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

        
        let doseUnitStep = ORKQuestionStep(identifier: medType.lowercased() + "_" + "DoseUnitStep", title: "What is the dose unit", answer: doseUnitAnswerFormat)
        
        return doseUnitStep
    }
    
    private static func createMedicationDoseAmountStep(medType: String) -> ORKStep {
        let numberAnswerFormat = ORKNumericAnswerFormat(style: .decimal)
        
        let doseAmountStep = ORKQuestionStep(identifier: medType.lowercased() + "_" + "DoseAmountStep", title: "What is the dose", answer: numberAnswerFormat)
        
        return doseAmountStep
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
        
        let frequencyStep = ORKQuestionStep(identifier: medType.lowercased() + "_" + "FrequencyStep", title: "How often do you take it", answer: frequencyAnswerFormat)
        
        return frequencyStep
    }
    
    private static func createMedicationTakenWayStep(medType: String) -> ORKStep {
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
        
        let takenWayStep = ORKQuestionStep(identifier: medType.lowercased() + "_" + "TakenWayStep", title: "How is it taken", answer: takenWayAnswerFormat)
        
        return takenWayStep
    }
    
    private static func createmedicationStartDateStep (medType: String) -> ORKStep {
        let dateAnswerFormat = ORKDateAnswerFormat(style: .date)
        
        let startDateStep = ORKQuestionStep(identifier: medType.lowercased() + "_" + "StartDateStep", title: "When did you start?", answer: dateAnswerFormat)
        
        return startDateStep
    }
    
    private static func createTakeAnyOverTheCounterMedicationStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        let takeAnyOverTheCounterMedicationStep = ORKQuestionStep(identifier: "takeAnyOverTheCounterMedicationStep", title: "Do you currently take any over the counter medications?", answer: booleanAnswer)
        
        return takeAnyOverTheCounterMedicationStep
    }
    
    private static func createTakeHerbalProductsStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        let takeAnyHerbalProductsStep = ORKQuestionStep(identifier: "takeAnyHerbalProductsStep", title: "Do you currently take any Herbal or Holistic products?", answer: booleanAnswer)
        
        return takeAnyHerbalProductsStep
    }
    
    private static func createNavigationRule(for task: ORKNavigableOrderedTask) {
        let takeAnyPrescriptionMedicationResult = ORKResultSelector(resultIdentifier: "takeAnyPrescriptionMedicationStep")
        
        let predicateNoForTakeAnyPrescriptionMedication = ORKResultPredicate.predicateForBooleanQuestionResult(with: takeAnyPrescriptionMedicationResult, expectedAnswer: false)
        
        let predicateNoForTakeAnyPrescriptionMedicationRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForTakeAnyPrescriptionMedication, "takeAnyOverTheCounterMedicationStep")])
        
        task.setNavigationRule(predicateNoForTakeAnyPrescriptionMedicationRule, forTriggerStepIdentifier: "takeAnyPrescriptionMedicationStep")
        
        let takeAnyOverTheCounterMedicationResult = ORKResultSelector(resultIdentifier: "takeAnyOverTheCounterMedicationStep")
        let predicateNoForTakeAnyOverTheCounterMedication = ORKResultPredicate.predicateForBooleanQuestionResult(with: takeAnyOverTheCounterMedicationResult, expectedAnswer: false)
        let predicateNoForTakeAnyOverTheCounterMedicationRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForTakeAnyOverTheCounterMedication, "takeAnyHerbalProductsStep")])
        task.setNavigationRule(predicateNoForTakeAnyOverTheCounterMedicationRule, forTriggerStepIdentifier: "takeAnyOverTheCounterMedicationStep")
        
        let takeAnyHerbalProductsResult = ORKResultSelector(resultIdentifier: "takeAnyHerbalProductsStep")
        let predicateNoForTakeAnyHerbalProducts = ORKResultPredicate.predicateForBooleanQuestionResult(with: takeAnyHerbalProductsResult, expectedAnswer: false)
        let predicateNoForTakeAnyHerbalProductsRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForTakeAnyHerbalProducts, "reviewStep")])
        task.setNavigationRule(predicateNoForTakeAnyHerbalProductsRule, forTriggerStepIdentifier: "takeAnyHerbalProductsStep")
    }
}
