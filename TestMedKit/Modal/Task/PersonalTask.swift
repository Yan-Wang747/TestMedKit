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

class PersonalTask: Task {
    init(_ viewController: UIViewController, patient: Patient) {
        let steps = PersonalTask.createPersonalSteps()
        
        let personalTask = ORKNavigableOrderedTask(identifier: "personalTask", steps: steps)
        
        PersonalTask.createPersonalNavigationRule(for: personalTask)
        super.init(task: personalTask, viewController: viewController, delegate: TaskResultProcessor(patient: patient))
    }

    private static func createPersonalSteps() -> [ORKStep]{
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Personal Information"
        instructionStep.detailText = "This survey helps us understand your personal background"
        steps.append(instructionStep)
        
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        let marriedStep = ORKQuestionStep(identifier: "marriedStep", title: "Are you married?", answer: booleanAnswer)
        steps.append(marriedStep)
        
        let liveWithAnswer = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices:
            [ORKTextChoice(text: "Spouse", value: "Spouse" as NSString),
             ORKTextChoice(text: "Child", value: "Parent" as NSString),
             ORKTextChoice(text: "Grandparent", value: "Grandparent" as NSString),
             ORKTextChoice(text: "Friend", value: "Friend" as NSString)])
        
        let liveWithStep = ORKQuestionStep(identifier: "liveWithStep", title: "Next to you who else lives with you?\nSelect all that apply", answer: liveWithAnswer)
        steps.append(liveWithStep)
        
        let supportStep = ORKQuestionStep(identifier: "supportStep", title: "Please indicate who will be your support during your care with us", answer: liveWithAnswer)
        steps.append(supportStep)
        
        let accessToTransportationStep = ORKQuestionStep(identifier: "accessToTransportationStep", title: "Will you have access to transportation during your care?", answer: booleanAnswer)
        steps.append(accessToTransportationStep)
        
        let resideAnswer = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices:
            [ORKTextChoice(text: "Home", value: "Home" as NSString),
             ORKTextChoice(text: "Nursing", value: "Nursing" as NSString),
             ORKTextChoice(text: "Assisted living", value: "Assisted living" as NSString),
             ORKTextChoice(text: "Incarcerated", value: "Incarerated" as NSString)])
        
        let resideStep = ORKQuestionStep(identifier: "resideStep", title: "Where do you reside?\nSelect all that apply", answer: resideAnswer)
        steps.append(resideStep)
        
        let occupationAnswer = ORKTextAnswerFormat(maximumLength: 99)
        let occupationStep = ORKQuestionStep(identifier: "occupationStep", title: "What is your occupation", answer: occupationAnswer)
        steps.append(occupationStep)
        
        let activePersonStep = ORKQuestionStep(identifier: "activePersonStep", title: "Are you an active person?", answer: booleanAnswer)
        steps.append(activePersonStep)
        
        let activityAnswer = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices:
            [ORKTextChoice(text: "Sedentary", value: "Sedentary" as NSString),
             ORKTextChoice(text: "Daily Activities", value: "Daily Activities" as NSString),
             ORKTextChoice(text: "Occasional Exercise", value: "Occasional Exercise" as NSString),
             ORKTextChoice(text: "Regular Excercise", value: "Regular Excercise" as NSString),
             ORKTextChoice(text: "Extensive Excercise", value: "Extensive Excercise" as NSString)])
        
        let activityStep = ORKQuestionStep(identifier: "activityStep", title: "Select all that apply", answer: activityAnswer)
        steps.append(activityStep)
        
        let regularMealStep = ORKQuestionStep(identifier: "regularMealStep", title: "Do you eat regular meals?", answer: booleanAnswer)
        steps.append(regularMealStep)
        
        let nutritionalSupplementsStep = ORKQuestionStep(identifier: "nutritionalSupplementsStep", title: "Do you take nutritional supplements?", answer: booleanAnswer)
        steps.append(nutritionalSupplementsStep)
        
        let liquidDietStep = ORKQuestionStep(identifier: "liquidDietStep", title: "Do you require a liquid diet?", answer: booleanAnswer)
        steps.append(liquidDietStep)
        
        Task.appendReviewStep(steps: &steps)
        
        return steps
    }
    
    private static func createPersonalNavigationRule(for personalTask: ORKNavigableOrderedTask){
        let marriedResult = ORKResultSelector(resultIdentifier: "marriedStep")
        let predicateNoForMarriedStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: marriedResult, expectedAnswer: false)
        let predicateNoForMarriedStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForMarriedStep, "resideStep")])
        personalTask.setNavigationRule(predicateNoForMarriedStepRule, forTriggerStepIdentifier: "marriedStep")
        
        let activeResult = ORKResultSelector(resultIdentifier: "activePersonStep")
        let predicateNoForActiveStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: activeResult, expectedAnswer: false)
        let predicateNoForActiveStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForActiveStep, "regularMealStep")])
        personalTask.setNavigationRule(predicateNoForActiveStepRule, forTriggerStepIdentifier: "activePersonStep")
        
        let regularMealResult = ORKResultSelector(resultIdentifier: "regularMealStep")
        let predicateNoForRegularMealStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: regularMealResult, expectedAnswer: false)
        let predicateNoForRegularMealStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForRegularMealStep, "reviewStep")])
        personalTask.setNavigationRule(predicateNoForRegularMealStepRule, forTriggerStepIdentifier: "regularMealStep")
    }
}
