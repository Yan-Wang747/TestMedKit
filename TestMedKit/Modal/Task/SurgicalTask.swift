//
//  SurgicalTask.swift
//  TestMedKit
//
//  Created by Student on 2018-03-20.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class SurgicalTask: Task {
    private static let surgeryTypes = ["Amputation", "Appendectomy", "Biopsy", "Bone Marrow Biopsy", "Bone Marrow Transplant", "Cholecystectomy", "Colon Resection", "Colposcopy", "Cystectomy", "Heart By‐pass", "Hernia Repair", "Hysterectomy", "Liver Biopsy", "Mastectomy", "Melanoma Removal", "Ovarian Tumor Removal", "Plastic Surgery", "Prostate Gland Removal", "Tonsillectomy", "Tubal Ligation", "Vasectomy", "Breast Fine Needle Aspiration", "Breast Core Biopsy", "Breast Lumpectomy", "Breast Mastectomy", "Breast Sentinel Node Lymph Biopsy", "Breast Axillary Lymph Node Dissection", "Other"]
    
    init(_ viewController: UIViewController, patient: Patient) {
        let steps = SurgicalTask.createSteps()
        
        let surgicalTask = ORKSurgicalTask(identifier: "surgicalTask", steps: steps)
        surgicalTask.surgeryTypes = SurgicalTask.surgeryTypes
        
        SurgicalTask.createNavigationRule(for: surgicalTask)
        
        super.init(task: surgicalTask, viewController: viewController, delegate: TaskResultProcessor(patient: patient))
    }
    
    private static func createSteps() -> [ORKStep] {
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Surgery History"
        instructionStep.detailText = "This survey helps us understand your medication history"
        steps.append(instructionStep)
        
        steps.append(createHaveAnySurgeryStep())
        steps.append(createSurgerySelectionStep())
        
        for surgeryType in surgeryTypes {
            steps.append(createOnsetDateStep(surgeryType: surgeryType))
            steps.append(createIsTreatedStep(surgeryType: surgeryType))
        }
        
        self.appendReviewStep(steps: &steps)
        return steps
    }
    
    private static func createHaveAnySurgeryStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        let haveAnySurgeryStep = ORKQuestionStep(identifier: "haveAnySurgeryStep", title: "Have you ever had surgery or any procedure performed?", answer: booleanAnswer)
        
        return haveAnySurgeryStep
    }
    
    private static func createSurgerySelectionStep() -> ORKStep {
        var textChoices: [ORKTextChoice] = []
        for surgeryType in surgeryTypes {
            textChoices.append(ORKTextChoice(text: surgeryType, value: surgeryType as NSString))
        }
        
        let surgerySelectionAnswerFormat = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices: textChoices)
        
        let surgerySelectionStep = ORKQuestionStep(identifier: "surgerySelectionStep", title: "Please select all that apply", answer: surgerySelectionAnswerFormat)
        
        return surgerySelectionStep
    }
    
    private static func createOnsetDateStep(surgeryType: String) -> ORKStep {
        let dateAnswer = ORKDateAnswerFormat(style: .date)
        
        let id = surgeryType.lowercased() + "_" + "OnsetDateStep"
        let onsetDateStep = ORKQuestionStep(identifier: id, title: "What is the onset date of \(surgeryType)?", answer: dateAnswer)
        
        return onsetDateStep
    }
    
    private static func createIsTreatedStep(surgeryType: String) -> ORKStep {
        let booleanAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        let id = surgeryType.lowercased() + "_" + "IsTreatedStep"
        let isTreatedStep = ORKQuestionStep(identifier: id, title: "Treated?", answer: booleanAnswerFormat)
        
        return isTreatedStep
    }
    
    private static func createNavigationRule(for surgicalTask: ORKNavigableOrderedTask) {
    let haveAnySurgeryResultSelector = ORKResultSelector(resultIdentifier: "haveAnySurgeryStep")
        
        let predicateNoForHaveAnySurgery = ORKResultPredicate.predicateForBooleanQuestionResult(with: haveAnySurgeryResultSelector, expectedAnswer: false)
        
        let predicateNoForHaveAnySurgeryRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForHaveAnySurgery, "reviewStep")])
        
    surgicalTask.setNavigationRule(predicateNoForHaveAnySurgeryRule, forTriggerStepIdentifier: "haveAnySurgeryStep")
    }
    
}
