//
//  File.swift
//  TestMedKit
//
//  Created by Student on 2018-03-15.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class AllergyTask: Task {
    init(_ viewController: UIViewController, patient: Patient) {
        let steps = AllergyTask.createSteps()
        
        let allergyTask = ORKAllergyTask(identifier: "allergyTask", steps: steps)
        allergyTask.allergyTypes = AllergyTask.allergyTypes
        allergyTask.allergyReactions = AllergyTask.allergyReactions
        
        super.init(task: allergyTask, viewController: viewController, delegate: TaskResultProcessor(patient: patient))
    }
    
    static let allergyTypes = ["Drug", "Drugclass", "Food", "Other", "Unknown"]
    static let allergyReactions = ["Skin Rashes/Hives", "Shock/Unconsciousness", "Asthma/Shortness of Breath", "Nausea/Vomiting/Diarrhea", "Anemia/Blood Disorders", "Photosensitivity", "Swollen‐lips", "Chest Pains/Irregular Heart Rate", "Other"]
    
    private static func createSteps() -> [ORKStep] {
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Allergy Background"
        instructionStep.detailText = "This survey helps us understand your allergy background"
        steps.append(instructionStep)
        
        steps.append(createHaveAnyAllergyStep())
        steps.append(createAllergyTypeSelectionStep())
        
        for allergyType in allergyTypes {
            steps.append(createAllergyNameStep(for: allergyType))
            steps.append(createReactionSelectionStep(for: allergyType, allergyReactions: allergyReactions))
            
            for allergyReaction in allergyReactions {
                steps.append(createSeverityStep(for: allergyReaction, with: allergyType))
                steps.append(createDateOfOccurrenceStep(for: allergyReaction, with: allergyType))
            }

        }
        
        self.appendReviewStep(steps: &steps)
        
        return steps
    }
    
    private static func createHaveAnyAllergyStep() -> ORKStep{
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        let haveAnyAllergyStep = ORKQuestionStep(identifier: "haveAnyllergyStep", title: "Do you have any allergy", answer: booleanAnswer)
        
        return haveAnyAllergyStep
    }
    
    private static func createAllergyTypeSelectionStep() -> ORKStep {
        var allergyTypeChoices: [ORKTextChoice] = []
        
        for allergyType in allergyTypes {
            allergyTypeChoices.append(ORKTextChoice(text: allergyType, value: allergyType as NSString))
        }
        
        let id = "allergyTypeSelectionStep"
        
        let allergyTypeSelectionAnswerFormat = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices: allergyTypeChoices)
        let allergyTypeSelectionStep = ORKQuestionStep(identifier: id, title: "What type of allergy", answer: allergyTypeSelectionAnswerFormat)
        
        return allergyTypeSelectionStep
    }
    
    private static func createAllergyNameStep(for allergyType: String) -> ORKStep {
        let allergyNameAnswer = ORKTextAnswerFormat(maximumLength: 99)
        
        let id = allergyType.lowercased() + "_" + "AllergyNameStep"
        
        let alleryNameStep = ORKQuestionStep(identifier: id, title: "What is the name of the " + allergyType.lowercased() + " allergy", answer: allergyNameAnswer)
        
        return alleryNameStep
    }
    
    private static func createReactionSelectionStep(for allergyType: String, allergyReactions: [String]) -> ORKStep{
        var reactionChoices: [ORKTextChoice] = []
        
        for allergyReaction in allergyReactions {
            reactionChoices.append(ORKTextChoice(text: allergyReaction, value: allergyReaction as NSString))
        }
        
        let reactionSelectionAnswers = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices: reactionChoices)
        
        let id = allergyType.lowercased() + "_" + "AllergyReactionStep"
        let reactionSelectionStep = ORKQuestionStep(identifier: id, title: "What type of reaction?", answer: reactionSelectionAnswers)
        
        return reactionSelectionStep
    }
    
    private static func createSeverityStep(for reaction: String, with allergyType: String) -> ORKStep {
        let reactionAnswers = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices:
            [ORKTextChoice(text: "Mild", value: "Mild" as NSString),
             ORKTextChoice(text: "Moderate", value: "Moderate" as NSString),
             ORKTextChoice(text: "Severe", value: "Severe" as NSString),
             ORKTextChoice(text: "Life", value: "Life" as NSString),
             ORKTextChoice(text: "Threatening", value: "Threatening" as NSString)])
        
        let id = allergyType.lowercased() + "_" + reaction + "$" +  "SeverityStep"
        let severityStep = ORKQuestionStep(identifier: id, title: "How severe was your " + reaction.lowercased() + " reaction", answer: reactionAnswers)
        
        return severityStep
    }
    
    private static func createDateOfOccurrenceStep(for reaction: String, with allergyType: String) -> ORKStep {
        let dateAnswer = ORKDateAnswerFormat(style: .date)
        
        let id = allergyType.lowercased() + "_" + reaction + "$" +  "DateOfOccurrenceStep"
        let dateOfOccurrenceStep = ORKQuestionStep(identifier: id, title: "Date of occurrence of your " + reaction.lowercased() + " reaction", answer: dateAnswer)
        
        return dateOfOccurrenceStep
    }
    
    private static func createNavigationRule(for allergyTask: ORKNavigableOrderedTask) {
        let haveAnyAllergyResult = ORKResultSelector(resultIdentifier: "haveAnyllergyStep")
        let predicateNoForHaveAnyAllergyResult = ORKResultPredicate.predicateForBooleanQuestionResult(with: haveAnyAllergyResult, expectedAnswer: false)
        let predicateNoForHaveAnyAllergyStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForHaveAnyAllergyResult, "reviewStep")])
        allergyTask.setNavigationRule(predicateNoForHaveAnyAllergyStepRule, forTriggerStepIdentifier: "haveAnyllergyStep")
    }
}
