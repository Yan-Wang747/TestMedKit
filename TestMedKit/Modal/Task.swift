//
//  Task.swift
//  TestMedKit
//
//  Created by Student on 2018-02-26.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit
import UIKit

class Task: NSObject, ORKTaskViewControllerDelegate{
    let task: ORKNavigableOrderedTask
    let viewController: UIViewController
    
    private init(_ task: ORKNavigableOrderedTask, _ viewController: UIViewController){
        self.task = task
        self.viewController = viewController
    }
    
    private static func appendReviewStep(steps: inout [ORKStep]) {
        let reviewStep = ORKReviewStep(identifier: "reviewStep")
        reviewStep.title = "Answer review"
        steps.append(reviewStep)
        
        for step in steps{
            step.isOptional = false
        }
    }
    
    //Mark: -TobaccoTask
    private static func createTobaccoSteps() -> [ORKStep]{
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Tobacco history"
        instructionStep.detailText = "This survey helps us understand your tobacco history"
        steps.append(instructionStep)
        
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        let numericAnswer = ORKNumericAnswerFormat(style: .integer, unit: nil, minimum: 1, maximum: nil)
        let dateAnswer = ORKDateAnswerFormat(style: .date)
        
        let tobaccoUseStep = ORKQuestionStep(identifier: "tobaccoUseStep", title: "Do you use tobacco products? This includes cigarettes, pipe, cigars, cigarrillos", answer: booleanAnswer)
        steps.append(tobaccoUseStep)
        
        let everSmokeStep = ORKQuestionStep(identifier: "everSmokeStep", title: "Have you ever smoked", answer: booleanAnswer)
        steps.append(everSmokeStep)
        
        //==============================
        let useCigaretteStep = ORKQuestionStep(identifier: "useCigaretteStep", title: "Using/used cigarette?", answer: booleanAnswer)
        steps.append(useCigaretteStep)
        
        let cigaretteStartDateStep = ORKQuestionStep(identifier: "cigaretteStartDateStep", title: "When did you start cigarette?", answer: dateAnswer)
        steps.append(cigaretteStartDateStep)
        
        let cigaretteNumberStep = ORKQuestionStep(identifier: "cigaretteNumberStep", title: "How many cigarettes per day did you smoke", answer: numericAnswer)
        steps.append(cigaretteNumberStep)
        
        //=========================================================
        let useCigarStep = ORKQuestionStep(identifier: "useCigarStep", title: "Using/used cigar?", answer: booleanAnswer)
        steps.append(useCigarStep)
        
        let cigarStartDateStep = ORKQuestionStep(identifier: "cigarStartDateStep", title: "When did you start cigar?", answer: dateAnswer)
        steps.append(cigarStartDateStep)
        
        let cigarNumberStep = ORKQuestionStep(identifier: "cigarNumberStep", title: "How many cigars per day did you smoke", answer: numericAnswer)
        steps.append(cigarNumberStep)
        
        //=====================================================
        let usePipeStep = ORKQuestionStep(identifier: "usePipeStep", title: "Using/used Pipe?", answer: booleanAnswer)
        steps.append(usePipeStep)
        
        let pipeStartDateStep = ORKQuestionStep(identifier: "pipeStartDateStep", title: "When did you start pipe?", answer: dateAnswer)
        steps.append(pipeStartDateStep)
        
        let pipeNumberStep = ORKQuestionStep(identifier: "pipeNumberStep", title: "How many pipes per day did you smoke", answer: numericAnswer)
        steps.append(pipeNumberStep)
        
        //=====================================================
        appendReviewStep(steps: &steps)
        
        return steps
    }
    
    private static func createTobaccoNavigationRule(for tobaccoTask: ORKNavigableOrderedTask){
        //========================
        let tobaccoUseStepResult = ORKResultSelector(resultIdentifier: "tobaccoUseStep")
        let predicateYesForTobaccoUseStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: tobaccoUseStepResult, expectedAnswer: true)
        let predicateYesForTobaccoUseStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateYesForTobaccoUseStep, "useCigaretteStep")])
        tobaccoTask.setNavigationRule(predicateYesForTobaccoUseStepRule, forTriggerStepIdentifier: "tobaccoUseStep")
        
        //=======================
        let everSmokeStepResult = ORKResultSelector(resultIdentifier: "everSmokeStep")
        let predicateNoForEverSmokeStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: everSmokeStepResult, expectedAnswer: false)
        let predicateNoForEverSmokeStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForEverSmokeStep, "reviewStep")])
        tobaccoTask.setNavigationRule(predicateNoForEverSmokeStepRule, forTriggerStepIdentifier: "everSmokeStep")
        
        //======================
        let useCigaretteStepResult = ORKResultSelector(resultIdentifier: "useCigaretteStep")
        let predicateNoForUseCigaretteStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: useCigaretteStepResult, expectedAnswer: false)
        let predicateNoForUseCigaretteStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForUseCigaretteStep, "useCigarStep")])
        tobaccoTask.setNavigationRule(predicateNoForUseCigaretteStepRule, forTriggerStepIdentifier: "useCigaretteStep")
        
        //=======================
        let useCigarStepResult = ORKResultSelector(resultIdentifier: "useCigarStep")
        let predicateNoForUseCigarStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: useCigarStepResult, expectedAnswer: false)
        let predicateNoForUseCigarStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForUseCigarStep, "usePipeStep")])
        tobaccoTask.setNavigationRule(predicateNoForUseCigarStepRule, forTriggerStepIdentifier: "useCigarStep")
        
        //===========================
        let usePipeStepResult = ORKResultSelector(resultIdentifier: "usePipeStep")
        let predicateNoForUsePipeStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: usePipeStepResult, expectedAnswer: false)
        let predicateNoForUsePipeStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForUsePipeStep, "reviewStep")])
        tobaccoTask.setNavigationRule(predicateNoForUsePipeStepRule, forTriggerStepIdentifier: "usePipeStep")
    }
    
    static func createTobaccoTask(_ viewController: UIViewController) -> Task{
        let steps = createTobaccoSteps()
        
        let tobaccoTask = ORKNavigableOrderedTask(identifier: "tobaccoTask", steps: steps)
        
        createTobaccoNavigationRule(for: tobaccoTask)
        
        return Task(tobaccoTask, viewController)
    }
    
    private static func createAlcoholSteps() -> [ORKStep]{
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Alcohol history"
        instructionStep.detailText = "This survey helps us understand your alcohol history"
        steps.append(instructionStep)
        
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        let numericAnswer = ORKNumericAnswerFormat(style: .integer, unit: "cups", minimum: 1, maximum: nil)
        let hazardChoiceAnswer = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices:
            [ORKTextChoice(text: "Asbestors", value: "Asbestors" as NSString),
             ORKTextChoice(text: "Benzene", value: "Benzene" as NSString),
             ORKTextChoice(text: "Lead", value: "Lead" as NSString),
             ORKTextChoice(text: "Mercury", value: "Mercury" as NSString),
             ORKTextChoice(text: "Radiation", value: "Radiation" as NSString),
             ORKTextChoice(text: "Other Petroleum Products", value: "Other Petroleum Products" as NSString),
             ORKTextChoice(text: "Snuff", value: "Snuff" as NSString),
             ORKTextChoice(text: "Recreational Drug Use", value: "Recreational Drug Use" as NSString),
             ORKTextChoice(text: "Illicit Drug Use", value: "Illicit Drug Use" as NSString)])
        
        let alcoholUseStep = ORKQuestionStep(identifier: "alcoholUseStep", title: "Do you drink alcohol", answer: booleanAnswer)
        steps.append(alcoholUseStep)
        
        let quitStep = ORKQuestionStep(identifier: "quitStep", title: "Did you quit", answer: booleanAnswer)
        steps.append(quitStep)
        
        let alcoholAmountStep = ORKQuestionStep(identifier: "alcoholAmountStep", title: "How many cups a week?", answer: numericAnswer)
        steps.append(alcoholAmountStep)
        
        let hazardExposureStep = ORKQuestionStep(identifier: "hazardExposureStep", title: "Have you been exposed to Hazardous substances", answer: booleanAnswer)
        steps.append(hazardExposureStep)
        
        let hazardSelectStep = ORKQuestionStep(identifier: "hazardSelectStep", title: "Select all that apply", answer: hazardChoiceAnswer)
        steps.append(hazardSelectStep)
        
        appendReviewStep(steps: &steps)
        
        return steps
    }
    
    private static func createAlcoholNavigationRule(for alcoholTask: ORKNavigableOrderedTask){
        let alcoholUseStepResult = ORKResultSelector(resultIdentifier: "alcoholUseStep")
        let predicateNoForAlcoholUseStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: alcoholUseStepResult, expectedAnswer: false)
        let predicateNoForAlcoholUseStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForAlcoholUseStep, "hazardExposureStep")])
        alcoholTask.setNavigationRule(predicateNoForAlcoholUseStepRule, forTriggerStepIdentifier: "alcoholUseStep")
        
        let hazardExposureStepResult = ORKResultSelector(resultIdentifier: "hazardExposureStep")
        let predicateNoForHazardExposureStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: hazardExposureStepResult, expectedAnswer: false)
        let predicateNoForHazardExposureStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForHazardExposureStep, "reviewStep")])
        alcoholTask.setNavigationRule(predicateNoForHazardExposureStepRule, forTriggerStepIdentifier: "hazardExposureStep")
    }
    
    static func createAlcoholTask(_ viewController: UIViewController) -> Task{
        let steps = createAlcoholSteps()
        
        let alcoholTask = ORKNavigableOrderedTask(identifier: "alcoholTask", steps: steps)
        
        createAlcoholNavigationRule(for: alcoholTask)
        
        return Task(alcoholTask, viewController)
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
        
        appendReviewStep(steps: &steps)
        
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
    
    static func createPersonalTask(_ viewController: UIViewController) -> Task{
        let steps = createPersonalSteps()
        
        let personalTask = ORKNavigableOrderedTask(identifier: "personalTask", steps: steps)
        
        createPersonalNavigationRule(for: personalTask)
        
        return Task(personalTask, viewController)
    }
    
    func performTask(){
        let taskViewController = ORKTaskViewController(task: task, taskRun: nil)
        taskViewController.delegate = self
        taskViewController.navigationBar.tintColor = UIColor.darkText
        viewController.present(taskViewController, animated: true, completion: nil)
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        taskViewController.dismiss(animated: true, completion: nil)
    }
}
