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
    init(_ viewController: UIViewController) {
        let steps = MedicationTask.createSteps()
        
        let medicationTask = ORKNavigableOrderedTask(identifier: "medicationTask", steps: steps)
        super.init(medicationTask, viewController)
    }
    
    private static func createSteps() -> [ORKStep] {
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Medication History"
        instructionStep.detailText = "This survey helps us understand your medication history"
        steps.append(instructionStep)
        
        
        
        steps.append(createTakeAnyMedicationStep())
        steps.append(createMedicationNameStep())
        steps.append(createMedicationDoseUnitStep())
        steps.append(createMedicationDoseAmountStep())
        steps.append(createMedicationFrequencyStep())
        steps.append(createMedicationTakenWay())
        steps.append(createmedicationStartDateStep())
        
        self.appendReviewStep(steps: &steps)
        
        return steps
    }
    
    private static func createTakeAnyMedicationStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        let takeAnyMedicationStep = ORKQuestionStep(identifier: "takeAnyMedicationStep", title: "Do you currently take any Prescription medications?", answer: booleanAnswer)
        
        return takeAnyMedicationStep
    }
    
    private static func createMedicationNameStep() -> ORKStep {
        let textAnswerFormat = ORKTextAnswerFormat(maximumLength: 99)
        
        let medicationNameStep = ORKQuestionStep(identifier: "medicationNameStep", title: "Using the information supplied on the pharmacy label, what is the name of the medication.", answer: textAnswerFormat)
        
        return medicationNameStep
    }
    
    private static func createMedicationDoseUnitStep() -> ORKStep {
        let medicationDoseUnitAnswerFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices:
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

        
        let medicationDoseUnitStep = ORKQuestionStep(identifier: "medicationDoseUnitStep", title: "What is the dose unit", answer: medicationDoseUnitAnswerFormat)
        
        return medicationDoseUnitStep
    }
    
    private static func createMedicationDoseAmountStep() -> ORKStep {
        let numberAnswerFormat = ORKNumericAnswerFormat(style: .decimal)
        
        let medicationDoseAmountStep = ORKQuestionStep(identifier: "medicationDoseAmountStep", title: "What is the dose", answer: numberAnswerFormat)
        
        return medicationDoseAmountStep
    }
    
    private static func createMedicationFrequencyStep() -> ORKStep {
        let medicationFrequencyAnswerFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices:
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
        
        let medicationFrequencyStep = ORKQuestionStep(identifier: "medicationFrequencyStep", title: "How often do you take it", answer: medicationFrequencyAnswerFormat)
        
        return medicationFrequencyStep
    }
    
    private static func createMedicationTakenWay() -> ORKStep {
        let medicationTakenWayAnswerFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices:
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
        
        let medicationTakenWayStep = ORKQuestionStep(identifier: "medicationTakenWayStep", title: "How is it taken", answer: medicationTakenWayAnswerFormat)
        
        return medicationTakenWayStep
    }
    
    private static func createmedicationStartDateStep () -> ORKStep {
        let dateAnswerFormat = ORKDateAnswerFormat(style: .date)
        
        let medicationStartDateStep = ORKQuestionStep(identifier: "medicationStartDateStep", title: "When did you start?", answer: dateAnswerFormat)
        
        return medicationStartDateStep
    }
}
