//
//  TobaccoTask.swift
//  TestMedKit
//
//  Created by Student on 2018-02-27.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit
import UIKit

class TobaccoTask: Task {
    init(_ viewController: UIViewController) {
        let steps = TobaccoTask.createTobaccoSteps()
        
        let tobaccoTask = ORKNavigableOrderedTask(identifier: "alcoholTask", steps: steps)
        
        TobaccoTask.createTobaccoNavigationRule(for: tobaccoTask)
        
        super.init(tobaccoTask, viewController)
    }
    
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
        Task.appendReviewStep(steps: &steps)
        
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
}
