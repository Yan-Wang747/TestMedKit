//
//  File.swift
//  TestMedKit
//
//  Created by Student on 2018-03-14.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class ORKAllergyTask : ORKNavigableOrderedTask {
    
    override func step(after step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
        guard let step = step, let result = result.stepResult(forStepIdentifier: "instructionStep") as! ORKQuestionResultelse else {return super.step(after: step, with: result)}
        
        let nextStep: ORKStep?
        
        switch step.identifier {
        case :
        default:
           nextStep = super.step(after: step, with: result)
        }
        
        return nextStep
    }
    
    override func step(before step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
        print("called")
        
        return steps[0]
    }
    
    
    static let allergyTypes = ["Drug", "DrugClass", "Food", "Other", "Unknown"]
    static let allergyReactions = ["Skin Rashes/Hives", "Shock/Unconsciousness", "Asthma/Shortness of Breath", "Nausea/Vomiting/Diarrhea", "Anemia/Blood Disorders", "Photosensitivity", "Swollen‐lips", "Chest Pains/Irregular Heart Rate", "other"]
    
    
    private static func createSteps() -> [ORKStep] {
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Allergy History"
        instructionStep.detailText = "This survey helps us understand your allergy history"
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
        
        //self.appendReviewStep(steps: &steps)
        
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
        
        let id = "AllergyTypeSelectionStep"
        
        let allergyTypeSelectionAnswerFormat = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices: allergyTypeChoices)
        let allergyTypeSelectionStep = ORKQuestionStep(identifier: id, title: "What type of allergy", answer: allergyTypeSelectionAnswerFormat)
        
        return allergyTypeSelectionStep
    }
    
    private static func createAllergyNameStep(for allergyType: String) -> ORKStep {
        let allergyNameAnswer = ORKTextAnswerFormat(maximumLength: 99)
        
        let id = allergyType + "AllergyNameStep"
        let alleryNameStep = ORKQuestionStep(identifier: id, title: "What is the name of the " + allergyType.lowercased() + " allergy", answer: allergyNameAnswer)
        
        return alleryNameStep
    }
    
    private static func createReactionSelectionStep(for allergyType: String, allergyReactions: [String]) -> ORKStep{
        var reactionChoices: [ORKTextChoice] = []
        
        for allergyReaction in allergyReactions {
            reactionChoices.append(ORKTextChoice(text: allergyReaction, value: allergyReaction as NSString))
        }
        
        let reactionSelectionAnswers = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices: reactionChoices)
        
        let id = allergyType + "AllergyReactionStep"
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

        let id = allergyType + reaction + "SeverityStep"
        let severityStep = ORKQuestionStep(identifier: id, title: "How severe was your " + reaction.lowercased() + " reaction", answer: reactionAnswers)
        
        return severityStep
    }
    
    private static func createDateOfOccurrenceStep(for reaction: String, with allergyType: String) -> ORKStep {
        let dateAnswer = ORKDateAnswerFormat(style: .date)
        
        let id = allergyType + reaction + "DateOfOccurrenceStep"
        let dateOfOccurrenceStep = ORKQuestionStep(identifier: id, title: "Date of occurrence of your " + reaction.lowercased() + " reaction", answer: dateAnswer)
        
        return dateOfOccurrenceStep
    }
    
    private static func createNavigationRule(for allergyTask: ORKNavigableOrderedTask) {
        let haveAnyAllergyResult = ORKResultSelector(resultIdentifier: "haveAnyllergyStep")
        let predicateNoForHaveAnyAllergyResult = ORKResultPredicate.predicateForBooleanQuestionResult(with: haveAnyAllergyResult, expectedAnswer: false)
        let predicateNoForHaveAnyAllergyStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForHaveAnyAllergyResult, "reviewStep")])
        allergyTask.setNavigationRule(predicateNoForHaveAnyAllergyStepRule, forTriggerStepIdentifier: "haveAnyllergyStep")
    }
    
    private static func createNavigationRule(for allergyTask: ORKNavigableOrderedTask, from: String, to: String) {
        
    }
}
