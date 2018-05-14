//
//  PersonalTask.swift
//  TestMedKit
//
//  Created by Student on 2018-02-27.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import UIKit
import ResearchKit

class PersonalFactory: SurveyFactory {
    static func createResultProcessor() -> SurveyResultProcessor {
        return PersonalResultProcessor()
    }
    
    static func createSteps() -> [ORKStep]{
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Personal Information"
        instructionStep.detailText = "This survey helps us understand your personal background"
        steps.append(instructionStep)
        
        steps.append(createIsMarriedStep())
        steps.append(createLivingWithStep())
        steps.append(createWhoWillSupportStep())
        steps.append(createAccessToTransportationStep())
        steps.append(createResideStep())
        steps.append(createOccupationStep())
        steps.append(createIsActivePersonStep())
        steps.append(createActivitySelectionStep())
        steps.append(createRegularMealStep())
        steps.append(createNutritionSupplementsStep())
        steps.append(createLiquidDietStep())
        
        return steps
    }
    
    private static func createIsMarriedStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        return ORKQuestionStep(identifier: "isMarriedStep", title: "Are you married?", answer: booleanAnswer)
    }
    
    private static func createLivingWithStep() -> ORKStep {
        let familySelectionAnswer = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices:
            [ORKTextChoice(text: "Spouse", value: "Spouse" as NSString),
             ORKTextChoice(text: "Child", value: "Parent" as NSString),
             ORKTextChoice(text: "Grandparent", value: "Grandparent" as NSString),
             ORKTextChoice(text: "Friend", value: "Friend" as NSString)])
        
        return ORKQuestionStep(identifier: "livingWithStep", title: "Next to you who else lives with you?\nSelect all that apply", answer: familySelectionAnswer)
    }
    
    private static func createWhoWillSupportStep() -> ORKStep {
        let familySelectionAnswer = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices:
            [ORKTextChoice(text: "Spouse", value: "Spouse" as NSString),
             ORKTextChoice(text: "Child", value: "Parent" as NSString),
             ORKTextChoice(text: "Grandparent", value: "Grandparent" as NSString),
             ORKTextChoice(text: "Friend", value: "Friend" as NSString)])
        
        return ORKQuestionStep(identifier: "whoWillSupportStep", title: "Next to you who else lives with you?\nSelect all that apply", answer: familySelectionAnswer)
    }
    
    private static func createAccessToTransportationStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        return ORKQuestionStep(identifier: "accessToTransportationStep", title: "Will you have access to transportation during your care?", answer: booleanAnswer)
    }
    
    private static func createResideStep() -> ORKStep {
        let resideAnswer = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices:
            [ORKTextChoice(text: "Home", value: "Home" as NSString),
             ORKTextChoice(text: "Nursing", value: "Nursing" as NSString),
             ORKTextChoice(text: "Assisted living", value: "Assisted living" as NSString),
             ORKTextChoice(text: "Incarcerated", value: "Incarerated" as NSString)])
        
        return ORKQuestionStep(identifier: "resideStep", title: "Where do you reside?\nSelect all that apply", answer: resideAnswer)
    }
    
    private static func createOccupationStep() -> ORKStep {
        let occupationAnswer = ORKTextAnswerFormat(maximumLength: 99)
        
        return ORKQuestionStep(identifier: "occupationStep", title: "What is your occupation", answer: occupationAnswer)
    }
    
    private static func createIsActivePersonStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        return ORKQuestionStep(identifier: "isActivePersonStep", title: "Are you an active person?", answer: booleanAnswer)
    }
    
    private static func createActivitySelectionStep() -> ORKStep {
        let activitySelectionAnswer = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices:
            [ORKTextChoice(text: "Sedentary", value: "Sedentary" as NSString),
             ORKTextChoice(text: "Daily Activities", value: "Daily Activities" as NSString),
             ORKTextChoice(text: "Occasional Exercise", value: "Occasional Exercise" as NSString),
             ORKTextChoice(text: "Regular Excercise", value: "Regular Excercise" as NSString),
             ORKTextChoice(text: "Extensive Excercise", value: "Extensive Excercise" as NSString)])
        
        return ORKQuestionStep(identifier: "activitySelectionStep", title: "Select all that apply", answer: activitySelectionAnswer)
    }
    
    private static func createRegularMealStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        return ORKQuestionStep(identifier: "regularMealStep", title: "Do you eat regular meals?", answer: booleanAnswer)
    }
    
    private static func createNutritionSupplementsStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        return ORKQuestionStep(identifier: "nutritionSupplementsStep", title: "Do you take nutritional supplements?", answer: booleanAnswer)
    }
    
    private static func createLiquidDietStep() -> ORKStep {
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        return ORKQuestionStep(identifier: "liquidDietStep", title: "Do you require a liquid diet?", answer: booleanAnswer)
    }
    
    static func createNavigationRule(for personalTask: ORKNavigableOrderedTask){
        
        createIsMarriedStepRule(for: personalTask)
        createIsActivePersonStepRule(for: personalTask)
    }
    
    private static func createIsMarriedStepRule(for task: ORKNavigableOrderedTask) {
        let marriedResult = ORKResultSelector(resultIdentifier: "isMarriedStep")
        let predicateNoForIsMarried = ORKResultPredicate.predicateForBooleanQuestionResult(with: marriedResult, expectedAnswer: false)
        let predicateNoForIsMarriedRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForIsMarried, "resideStep")])
        task.setNavigationRule(predicateNoForIsMarriedRule, forTriggerStepIdentifier: "isMarriedStep")
    }
    
    static func createIsActivePersonStepRule(for task: ORKNavigableOrderedTask) {
        let isActiveResult = ORKResultSelector(resultIdentifier: "isActivePersonStep")
        let predicateNoForIsActive = ORKResultPredicate.predicateForBooleanQuestionResult(with: isActiveResult, expectedAnswer: false)
        let predicateNoForIsActiveRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForIsActive, "regularMealStep")])
        task.setNavigationRule(predicateNoForIsActiveRule, forTriggerStepIdentifier: "isActivePersonStep")
    }
}
