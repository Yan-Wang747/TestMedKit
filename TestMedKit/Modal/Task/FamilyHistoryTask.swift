//
//  FamilyHistoryTask.swift
//  TestMedKit
//
//  Created by Student on 2018-03-12.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class FamilyHistoryTask: Task {
    
    init(_ viewController: UIViewController) {
        let steps = FamilyHistoryTask.createSteps()
        
        let familyHistoryTask = ORKNavigableOrderedTask(identifier: "familyHistoryTask", steps: steps)
        
        FamilyHistoryTask.createNavigationRule(for: familyHistoryTask)
        super.init(familyHistoryTask, viewController)
    }
    
    private static func createSteps() -> [ORKStep]{
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Family History"
        instructionStep.detailText = "This survey helps us understand your family history"
        steps.append(instructionStep)
        
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        let diagnosisAnswer = ORKTextAnswerFormat(maximumLength: 99)
        let ageAnswer = ORKNumericAnswerFormat(style: .integer, unit: nil, minimum: 0, maximum: 200)
        
        //=================================
        let doesFatherHaveCancerStep = ORKQuestionStep(identifier: "doesFatherHaveCancerStep", title: "Does your father have been diagnosed with cancer or a blood disorder", answer: booleanAnswer)
        steps.append(doesFatherHaveCancerStep)
        
        let fatherDiagnosisStep = ORKQuestionStep(identifier: "fatherDiagnosisStep", title: "What was his diagnosis", answer: diagnosisAnswer)
        steps.append(fatherDiagnosisStep)
        
        let fatherDiagnosedAgeStep = ORKQuestionStep(identifier: "fatherDiagnosedAgeStep", title: "At what age were they diagnosed?", answer: ageAnswer)
        steps.append(fatherDiagnosedAgeStep)
        
        let didFatherPassAwayStep = ORKQuestionStep(identifier: "didFatherPassAwayStep", title: "Did he pass away as a result of their diagnosis?", answer: booleanAnswer)
        steps.append(didFatherPassAwayStep)
        
        let fatherDeathAgeStep = ORKQuestionStep(identifier: "fatherDeathAgeStep", title: "At what age?", answer: ageAnswer)
        steps.append(fatherDeathAgeStep)
        
        let fatherCurrentAgeStep = ORKQuestionStep(identifier: "fatherCurrentAgeStep", title: "What is his current age", answer: ageAnswer)
        steps.append(fatherCurrentAgeStep)
        //====================================
        
        let doesMotherHaveCancerStep = ORKQuestionStep(identifier: "doesMotherHaveCancerStep", title: "Does your mother have been diagnosed with cancer or a blood disorder", answer: booleanAnswer)
        steps.append(doesMotherHaveCancerStep)
        
        let motherDiagnosisStep = ORKQuestionStep(identifier: "motherDiagnosisStep", title: "What was her diagnosis", answer: diagnosisAnswer)
        steps.append(motherDiagnosisStep)
        
        let didMotherPassAwayStep = ORKQuestionStep(identifier: "didMotherPassAwayStep", title: "Did they pass away as a result of their diagnosis?", answer: booleanAnswer)
        steps.append(didMotherPassAwayStep)
        
        let motherDeathAgeStep = ORKQuestionStep(identifier: "motherDeathAgeStep", title: "At what age?", answer: ageAnswer)
        steps.append(motherDeathAgeStep)
        
        let motherCurrentAgeStep = ORKQuestionStep(identifier: "motherCurrentAgeStep", title: "What is her current age", answer: ageAnswer)
        steps.append(motherCurrentAgeStep)
        
        //====================================
        let doesBrotherHaveCancerStep = ORKQuestionStep(identifier: "doesBrotherHaveCancerStep", title: "Does your brother have been diagnosed with cancer or a blood disorder", answer: booleanAnswer)
        steps.append(doesBrotherHaveCancerStep)
        
        let brotherDiagnosisStep = ORKQuestionStep(identifier: "brotherDiagnosisStep", title: "What was his diagnosis", answer: diagnosisAnswer)
        steps.append(brotherDiagnosisStep)
        
        let didBrotherPassAwayStep = ORKQuestionStep(identifier: "didBrotherPassAwayStep", title: "Did he pass away as a result of their diagnosis?", answer: booleanAnswer)
        steps.append(didBrotherPassAwayStep)
        
        let brotherDeathAgeStep = ORKQuestionStep(identifier: "brotherDeathAgeStep", title: "At what age?", answer: ageAnswer)
        steps.append(brotherDeathAgeStep)
        
        let brotherCurrentAgeStep = ORKQuestionStep(identifier: "brotherCurrentAgeStep", title: "What is his current age", answer: ageAnswer)
        steps.append(brotherCurrentAgeStep)
        
        //===================================
        let doesSisterHaveCancerStep = ORKQuestionStep(identifier: "doesSisterHaveCancerStep", title: "Does your sister have been diagnosed with cancer or a blood disorder", answer: booleanAnswer)
        steps.append(doesSisterHaveCancerStep)
        
        let sisterDiagnosisStep = ORKQuestionStep(identifier: "sisterDiagnosisStep", title: "What was her diagnosis", answer: diagnosisAnswer)
        steps.append(sisterDiagnosisStep)
        
        let didSisterPassAwayStep = ORKQuestionStep(identifier: "didSisterPassAwayStep", title: "Did she pass away as a result of their diagnosis?", answer: booleanAnswer)
        steps.append(didSisterPassAwayStep)
        
        let sisterDeathAgeStep = ORKQuestionStep(identifier: "sisterDeathAgeStep", title: "At what age?", answer: ageAnswer)
        steps.append(sisterDeathAgeStep)
        
        let sisterCurrentAgeStep = ORKQuestionStep(identifier: "sisterCurrentAgeStep", title: "What is her current age", answer: ageAnswer)
        steps.append(sisterCurrentAgeStep)
        
        //===================================
        let doesSonHaveCancerStep = ORKQuestionStep(identifier: "doesSonHaveCancerStep", title: "Does your son have been diagnosed with cancer or a blood disorder", answer: booleanAnswer)
        steps.append(doesSonHaveCancerStep)
        
        let sonDiagnosisStep = ORKQuestionStep(identifier: "sonDiagnosisStep", title: "What was his diagnosis", answer: diagnosisAnswer)
        steps.append(sonDiagnosisStep)
        
        let didSonPassAwayStep = ORKQuestionStep(identifier: "didSonPassAwayStep", title: "Did he pass away as a result of their diagnosis?", answer: booleanAnswer)
        steps.append(didSonPassAwayStep)
        
        let sonDeathAgeStep = ORKQuestionStep(identifier: "sonDeathAgeStep", title: "At what age?", answer: ageAnswer)
        steps.append(sonDeathAgeStep)
        
        let sonCurrentAgeStep = ORKQuestionStep(identifier: "sonCurrentAgeStep", title: "What is his current age", answer: ageAnswer)
        steps.append(sonCurrentAgeStep)
        
        //===================================
        let doesDaughterHaveCancerStep = ORKQuestionStep(identifier: "doesDaughterHaveCancerStep", title: "Does your daughter have been diagnosed with cancer or a blood disorder", answer: booleanAnswer)
        steps.append(doesDaughterHaveCancerStep)
        
        let daughterDiagnosisStep = ORKQuestionStep(identifier: "daughterDiagnosisStep", title: "What was her diagnosis", answer: diagnosisAnswer)
        steps.append(daughterDiagnosisStep)
        
        let didDaughterPassAwayStep = ORKQuestionStep(identifier: "didDaughterPassAwayStep", title: "Did she pass away as a result of her diagnosis?", answer: booleanAnswer)
        steps.append(didDaughterPassAwayStep)
        
        let daughterDeathAgeStep = ORKQuestionStep(identifier: "daughterDeathAgeStep", title: "At what age?", answer: ageAnswer)
        steps.append(daughterDeathAgeStep)
        
        let daughterCurrentAgeStep = ORKQuestionStep(identifier: "daughterCurrentAgeStep", title: "What is her current age", answer: ageAnswer)
        steps.append(daughterCurrentAgeStep)
        
        //===================================
        let doesMaternalGrandmotherHaveCancerStep = ORKQuestionStep(identifier: "doesMaternalGrandmotherHaveCancerStep", title: "Does your maternal grandmother have been diagnosed with cancer or a blood disorder", answer: booleanAnswer)
        steps.append(doesMaternalGrandmotherHaveCancerStep)
        
        let maternalGrandmotherDiagnosisStep = ORKQuestionStep(identifier: "maternalGrandmotherDiagnosisStep", title: "What was her diagnosis", answer: diagnosisAnswer)
        steps.append(maternalGrandmotherDiagnosisStep)
        
        let didMaternalGrandmotherPassAwayStep = ORKQuestionStep(identifier: "didMaternalGrandmotherPassAwayStep", title: "Did she pass away as a result of her diagnosis?", answer: booleanAnswer)
        steps.append(didMaternalGrandmotherPassAwayStep)
        
        let maternalGrandmotherDeathAgeStep = ORKQuestionStep(identifier: "maternalGrandmotherDeathAgeStep", title: "At what age?", answer: ageAnswer)
        steps.append(maternalGrandmotherDeathAgeStep)
        
        let maternalGrandmotherCurrentAgeStep = ORKQuestionStep(identifier: "maternalGrandmotherCurrentAgeStep", title: "What is her current age", answer: ageAnswer)
        steps.append(maternalGrandmotherCurrentAgeStep)
        
        //===================================
        let doesMaternalGrandfatherHaveCancerStep = ORKQuestionStep(identifier: "doesMaternalGrandfatherHaveCancerStep", title: "Does your maternal grandfather have been diagnosed with cancer or a blood disorder", answer: booleanAnswer)
        steps.append(doesMaternalGrandfatherHaveCancerStep)
        
        let maternalGrandfatherDiagnosisStep = ORKQuestionStep(identifier: "maternalGrandfatherDiagnosisStep", title: "What was his diagnosis", answer: diagnosisAnswer)
        steps.append(maternalGrandfatherDiagnosisStep)
        
        let didMaternalGrandfatherPassAwayStep = ORKQuestionStep(identifier: "didMaternalGrandfatherPassAwayStep", title: "Did he pass away as a result of his diagnosis?", answer: booleanAnswer)
        steps.append(didMaternalGrandfatherPassAwayStep)
        
        let maternalGrandfatherDeathAgeStep = ORKQuestionStep(identifier: "maternalGrandfatherDeathAgeStep", title: "At what age?", answer: ageAnswer)
        steps.append(maternalGrandfatherDeathAgeStep)
        
        let maternalGrandfatherCurrentAgeStep = ORKQuestionStep(identifier: "maternalGrandfatherCurrentAgeStep", title: "What is his current age", answer: ageAnswer)
        steps.append(maternalGrandfatherCurrentAgeStep)
        
        //===================================
        let doesMaternalAuntHaveCancerStep = ORKQuestionStep(identifier: "doesMaternalAuntHaveCancerStep", title: "Does your maternal aunt have been diagnosed with cancer or a blood disorder", answer: booleanAnswer)
        steps.append(doesMaternalAuntHaveCancerStep)
        
        let maternalAuntDiagnosisStep = ORKQuestionStep(identifier: "maternalAuntDiagnosisStep", title: "What was her diagnosis", answer: diagnosisAnswer)
        steps.append(maternalAuntDiagnosisStep)
        
        let didMaternalAuntPassAwayStep = ORKQuestionStep(identifier: "didMaternalAuntPassAwayStep", title: "Did she pass away as a result of her diagnosis?", answer: booleanAnswer)
        steps.append(didMaternalAuntPassAwayStep)
        
        let maternalAuntDeathAgeStep = ORKQuestionStep(identifier: "maternalAuntDeathAgeStep", title: "At what age?", answer: ageAnswer)
        steps.append(maternalAuntDeathAgeStep)
        
        let maternalAuntCurrentAgeStep = ORKQuestionStep(identifier: "maternalAuntCurrentAgeStep", title: "What is her current age", answer: ageAnswer)
        steps.append(maternalAuntCurrentAgeStep)
        
        //===================================
        let doesMaternalUncleHaveCancerStep = ORKQuestionStep(identifier: "doesMaternalUncleHaveCancerStep", title: "Does your maternal uncle have been diagnosed with cancer or a blood disorder", answer: booleanAnswer)
        steps.append(doesMaternalUncleHaveCancerStep)
        
        let maternalUncleDiagnosisStep = ORKQuestionStep(identifier: "maternalUncleDiagnosisStep", title: "What was his diagnosis", answer: diagnosisAnswer)
        steps.append(maternalUncleDiagnosisStep)
        
        let didMaternalUnclePassAwayStep = ORKQuestionStep(identifier: "didMaternalUnclePassAwayStep", title: "Did he pass away as a result of his diagnosis?", answer: booleanAnswer)
        steps.append(didMaternalUnclePassAwayStep)
        
        let maternalUncleDeathAgeStep = ORKQuestionStep(identifier: "maternalUncleDeathAgeStep", title: "At what age?", answer: ageAnswer)
        steps.append(maternalUncleDeathAgeStep)
        
        let maternalUncleCurrentAgeStep = ORKQuestionStep(identifier: "maternalUnlceCurrentAgeStep", title: "What is his current age", answer: ageAnswer)
        steps.append(maternalUncleCurrentAgeStep)
        
        //===================================
        let doesPaternalAuntHaveCancerStep = ORKQuestionStep(identifier: "doesPaternalAuntHaveCancerStep", title: "Does your paternal aunt have been diagnosed with cancer or a blood disorder", answer: booleanAnswer)
        steps.append(doesPaternalAuntHaveCancerStep)
        
        let paternalAuntDiagnosisStep = ORKQuestionStep(identifier: "paternalAuntDiagnosisStep", title: "What was her diagnosis", answer: diagnosisAnswer)
        steps.append(paternalAuntDiagnosisStep)
        
        let didPaternalAuntPassAwayStep = ORKQuestionStep(identifier: "didPaternalAuntPassAwayStep", title: "Did she pass away as a result of her diagnosis?", answer: booleanAnswer)
        steps.append(didPaternalAuntPassAwayStep)
        
        let paternalAuntDeathAgeStep = ORKQuestionStep(identifier: "paternalAuntDeathAgeStep", title: "At what age?", answer: ageAnswer)
        steps.append(paternalAuntDeathAgeStep)
        
        let paternalAuntCurrentAgeStep = ORKQuestionStep(identifier: "paternalAuntCurrentAgeStep", title: "What is her current age", answer: ageAnswer)
        steps.append(paternalAuntCurrentAgeStep)
        
        //===========
        let doesPaternalUncleHaveCancerStep = ORKQuestionStep(identifier: "doesPaternalUncleHaveCancerStep", title: "Does your paternal uncle have been diagnosed with cancer or a blood disorder", answer: booleanAnswer)
        steps.append(doesPaternalUncleHaveCancerStep)
        
        let paternalUncleDiagnosisStep = ORKQuestionStep(identifier: "paternalUncleDiagnosisStep", title: "What was his diagnosis", answer: diagnosisAnswer)
        steps.append(paternalUncleDiagnosisStep)
        
        let didPaternalUnclePassAwayStep = ORKQuestionStep(identifier: "didPaternalUnclePassAwayStep", title: "Did he pass away as a result of his diagnosis?", answer: booleanAnswer)
        steps.append(didPaternalUnclePassAwayStep)
        
        let paternalUncleDeathAgeStep = ORKQuestionStep(identifier: "paternalUncleDeathAgeStep", title: "At what age?", answer: ageAnswer)
        steps.append(paternalUncleDeathAgeStep)
        
        let paternalUncleCurrentAgeStep = ORKQuestionStep(identifier: "paternalUnlceCurrentAgeStep", title: "What is his current age", answer: ageAnswer)
        steps.append(paternalUncleCurrentAgeStep)
        
        //====================================
        let doesHalfBrotherHaveCancerStep = ORKQuestionStep(identifier: "doesHalfBrotherHaveCancerStep", title: "Does your half brother have been diagnosed with cancer or a blood disorder", answer: booleanAnswer)
        steps.append(doesHalfBrotherHaveCancerStep)
        
        let halfBrotherDiagnosisStep = ORKQuestionStep(identifier: "halfBrotherDiagnosisStep", title: "What was his diagnosis", answer: diagnosisAnswer)
        steps.append(halfBrotherDiagnosisStep)
        
        let didHalfBrotherPassAwayStep = ORKQuestionStep(identifier: "didHalfBrotherPassAwayStep", title: "Did he pass away as a result of their diagnosis?", answer: booleanAnswer)
        steps.append(didHalfBrotherPassAwayStep)
        
        let halfBrotherDeathAgeStep = ORKQuestionStep(identifier: "halfBrotherDeathAgeStep", title: "At what age?", answer: ageAnswer)
        steps.append(halfBrotherDeathAgeStep)
        
        let halfBrotherCurrentAgeStep = ORKQuestionStep(identifier: "halfBrotherCurrentAgeStep", title: "What is his current age", answer: ageAnswer)
        steps.append(halfBrotherCurrentAgeStep)

        //====================================
        let doesHalfSisterHaveCancerStep = ORKQuestionStep(identifier: "doesHalfSisterHaveCancerStep", title: "Does your sister have been diagnosed with cancer or a blood disorder", answer: booleanAnswer)
        steps.append(doesHalfSisterHaveCancerStep)
        
        let halfSisterDiagnosisStep = ORKQuestionStep(identifier: "halfSisterDiagnosisStep", title: "What was her diagnosis", answer: diagnosisAnswer)
        steps.append(halfSisterDiagnosisStep)
        
        let didHalfSisterPassAwayStep = ORKQuestionStep(identifier: "didHalfSisterPassAwayStep", title: "Did she pass away as a result of their diagnosis?", answer: booleanAnswer)
        steps.append(didHalfSisterPassAwayStep)
        
        let halfSisterDeathAgeStep = ORKQuestionStep(identifier: "halfSisterDeathAgeStep", title: "At what age?", answer: ageAnswer)
        steps.append(halfSisterDeathAgeStep)
        
        let halfSisterCurrentAgeStep = ORKQuestionStep(identifier: "halfSisterCurrentAgeStep", title: "What is her current age", answer: ageAnswer)
        steps.append(halfSisterCurrentAgeStep)
        
        //===============================
        let doesCousinHaveCancerStep = ORKQuestionStep(identifier: "doesCousinHaveCancerStep", title: "Does your cousin have been diagnosed with cancer or a blood disorder", answer: booleanAnswer)
        steps.append(doesCousinHaveCancerStep)
        
        let cousinDiagnosisStep = ORKQuestionStep(identifier: "cousinDiagnosisStep", title: "What was his/her diagnosis", answer: diagnosisAnswer)
        steps.append(cousinDiagnosisStep)
        
        let didCousinPassAwayStep = ORKQuestionStep(identifier: "didCousinPassAwayStep", title: "Did he/she pass away as a result of their diagnosis?", answer: booleanAnswer)
        steps.append(didCousinPassAwayStep)
        
        let cousinDeathAgeStep = ORKQuestionStep(identifier: "cousinDeathAgeStep", title: "At what age?", answer: ageAnswer)
        steps.append(cousinDeathAgeStep)
        
        let cousinCurrentAgeStep = ORKQuestionStep(identifier: "cousinCurrentAgeStep", title: "What is his/her current age", answer: ageAnswer)
        steps.append(cousinCurrentAgeStep)
 
        
        Task.appendReviewStep(steps: &steps)
        return steps
    }
    
    private static func createNavigationRule(for familyHistoryTask: ORKNavigableOrderedTask){
        let doesFatherHaveCancerResult = ORKResultSelector(resultIdentifier: "doesFatherHaveCancerStep")
        let predicateNoForDoesFatherHaveCancerStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: doesFatherHaveCancerResult, expectedAnswer: false)
        let predicateNoForDoesFatherHaveCancerStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDoesFatherHaveCancerStep, "doesMotherHaveCancerStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDoesFatherHaveCancerStepRule, forTriggerStepIdentifier: "doesFatherHaveCancerStep")
        
        let didFatherPassAwayResult = ORKResultSelector(resultIdentifier: "didFatherPassAwayStep")
        let predicateNoForDidFatherPassAwayStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: didFatherPassAwayResult, expectedAnswer: false)
        
        let predicateNoForDidFatherPassAwayStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDidFatherPassAwayStep, "fatherCurrentAgeStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDidFatherPassAwayStepRule, forTriggerStepIdentifier: "didFatherPassAwayStep")
        
        familyHistoryTask.setNavigationRule(ORKDirectStepNavigationRule(destinationStepIdentifier: "doesMotherHaveCancerStep"), forTriggerStepIdentifier: "fatherDeathAgeStep")
        
        //=======================================
        let doesMotherHaveCancerResult = ORKResultSelector(resultIdentifier: "doesMotherHaveCancerStep")
        let predicateNoForDoesMotherHaveCancerStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: doesMotherHaveCancerResult, expectedAnswer: false)
        let predicateNoForDoesMotherHaveCancerStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDoesMotherHaveCancerStep, "doesBrotherHaveCancerStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDoesMotherHaveCancerStepRule, forTriggerStepIdentifier: "doesMotherHaveCancerStep")
        
        let didMotherPassAwayResult = ORKResultSelector(resultIdentifier: "didMotherPassAwayStep")
        
        let predicateNoForDidMotherPassAwayStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: didMotherPassAwayResult, expectedAnswer: false)
        
        let predicateNoForDidMotherPassAwayStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDidMotherPassAwayStep, "motherCurrentAgeStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDidFatherPassAwayStepRule, forTriggerStepIdentifier: "didMotherPassAwayStep")
        
        familyHistoryTask.setNavigationRule(ORKDirectStepNavigationRule(destinationStepIdentifier: "doesBrotherHaveCancerStep"), forTriggerStepIdentifier: "motherDeathAgeStep")
        
        //=========================================
        let doesBrotherHaveCancerResult = ORKResultSelector(resultIdentifier: "doesBrotherHaveCancerStep")
        
        let predicateNoForDoesBrotherHaveCancerStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: doesBrotherHaveCancerResult, expectedAnswer: false)
        
        let predicateNoForDoesBrotherHaveCancerStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDoesBrotherHaveCancerStep, "doesSisterHaveCancerStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDoesBrotherHaveCancerStepRule, forTriggerStepIdentifier: "doesBrotherHaveCancerStep")
        
        let didBrotherPassAwayResult = ORKResultSelector(resultIdentifier: "didBrotherPassAwayStep")
        
        let predicateNoForDidBrotherPassAwayStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: didBrotherPassAwayResult, expectedAnswer: false)
        
        let predicateNoForDidBrotherPassAwayStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDidMotherPassAwayStep, "brotherCurrentAgeStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDidFatherPassAwayStepRule, forTriggerStepIdentifier: "didBrotherPassAwayStep")
        
        familyHistoryTask.setNavigationRule(ORKDirectStepNavigationRule(destinationStepIdentifier: "doesSisterHaveCancerStep"), forTriggerStepIdentifier: "brotherDeathAgeStep")
        
        //===============
        let doesSisterHaveCancerResult = ORKResultSelector(resultIdentifier: "doesSisterHaveCancerStep")
        
        let predicateNoForDoesSisterHaveCancerStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: doesSisterHaveCancerResult, expectedAnswer: false)
        
        let predicateNoForDoesSisterHaveCancerStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDoesSisterHaveCancerStep, "doesSonHaveCancerStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDoesSisterHaveCancerStepRule, forTriggerStepIdentifier: "doesSisterHaveCancerStep")
        
        let didSisterPassAwayResult = ORKResultSelector(resultIdentifier: "didSisterPassAwayStep")
        
        let predicateNoForDidSisterPassAwayStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: didSisterPassAwayResult, expectedAnswer: false)
        
        let predicateNoForDidSisterPassAwayStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDidSisterPassAwayStep, "sisterCurrentAgeStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDidFatherPassAwayStepRule, forTriggerStepIdentifier: "didSisterPassAwayStep")
        familyHistoryTask.setNavigationRule(ORKDirectStepNavigationRule(destinationStepIdentifier: "doesSonHaveCancerStep"), forTriggerStepIdentifier: "sisterDeathAgeStep")
        
        //=========================
        let doesSonHaveCancerResult = ORKResultSelector(resultIdentifier: "doesSonHaveCancerStep")
        
        let predicateNoForDoesSonHaveCancerStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: doesSonHaveCancerResult, expectedAnswer: false)
        
        let predicateNoForDoesSonHaveCancerStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDoesSonHaveCancerStep, "doesDaughterHaveCancerStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDoesSonHaveCancerStepRule, forTriggerStepIdentifier: "doesSonHaveCancerStep")
        
        let didSonPassAwayResult = ORKResultSelector(resultIdentifier: "didSomPassAwayStep")
        
        let predicateNoForDidSonPassAwayStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: didSonPassAwayResult, expectedAnswer: false)
        
        let predicateNoForDidSonPassAwayStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDidSonPassAwayStep, "sonCurrentAgeStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDidFatherPassAwayStepRule, forTriggerStepIdentifier: "didSonPassAwayStep")
        
        familyHistoryTask.setNavigationRule(ORKDirectStepNavigationRule(destinationStepIdentifier: "doesDaughterHaveCancerStep"), forTriggerStepIdentifier: "motherDeathAgeStep")
        
        //=========================
        let doesDaughterHaveCancerResult = ORKResultSelector(resultIdentifier: "doesDaughterHaveCancerStep")
        
        let predicateNoForDoesDaughterHaveCancerStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: doesDaughterHaveCancerResult, expectedAnswer: false)
        
        let predicateNoForDoesDaughterHaveCancerStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDoesDaughterHaveCancerStep, "doesMaternalGrandmotherHaveCancerStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDoesDaughterHaveCancerStepRule, forTriggerStepIdentifier: "doesDaughterHaveCancerStep")
        
        let didDaughterPassAwayResult = ORKResultSelector(resultIdentifier: "didDaughterPassAwayStep")
        
        let predicateNoForDidDaughterPassAwayStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: didDaughterPassAwayResult, expectedAnswer: false)
        
        let predicateNoForDidDaughterPassAwayStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDidDaughterPassAwayStep, "daughterCurrentAgeStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDidDaughterPassAwayStepRule, forTriggerStepIdentifier: "didDaughterPassAwayStep")
        
        familyHistoryTask.setNavigationRule(ORKDirectStepNavigationRule(destinationStepIdentifier: "doesMaternalGrandmotherHaveCancerStep"), forTriggerStepIdentifier: "daughterDeathAgeStep")
        
        //=========================
        let doesMaternalGrandmotherHaveCancerResult = ORKResultSelector(resultIdentifier: "doesMaternalGrandmotherHaveCancerStep")
        
        let predicateNoForDoesMaternalGrandmotherHaveCancerStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: doesMaternalGrandmotherHaveCancerResult, expectedAnswer: false)
        
        let predicateNoForDoesMaternalGrandmotherHaveCancerStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDoesMaternalGrandmotherHaveCancerStep, "doesMaternalGrandfatherHaveCancerStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDoesMaternalGrandmotherHaveCancerStepRule, forTriggerStepIdentifier: "doesMaternalGrandmotherHaveCancerStep")
        
        let didMaternalGrandmotherPassAwayResult = ORKResultSelector(resultIdentifier: "didMaternalGrandmotherPassAwayStep")
        
        let predicateNoForDidMaternalGrandmotherPassAwayStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: didMaternalGrandmotherPassAwayResult, expectedAnswer: false)
        
        let predicateNoForDidMaternalGrandmotherPassAwayStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDidMaternalGrandmotherPassAwayStep, "motherCurrentAgeStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDidMaternalGrandmotherPassAwayStepRule, forTriggerStepIdentifier: "didMaternalGrandmotherPassAwayStep")
        
        familyHistoryTask.setNavigationRule(ORKDirectStepNavigationRule(destinationStepIdentifier: "doesMaternalGrandfatherHaveCancerStep"), forTriggerStepIdentifier: "maternalGrandmotherDeathAgeStep")
        
        //=========================
        let doesMaternalGrandfatherHaveCancerResult = ORKResultSelector(resultIdentifier: "doesMaternalGrandfatherHaveCancerStep")
        
        let predicateNoForDoesMaternalGrandfatherHaveCancerStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: doesMaternalGrandfatherHaveCancerResult, expectedAnswer: false)
        
        let predicateNoForDoesMaternalGrandfatherHaveCancerStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDoesMaternalGrandfatherHaveCancerStep, "doesMaternalAuntHaveCancerStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDoesMaternalGrandfatherHaveCancerStepRule, forTriggerStepIdentifier: "doesMaternalGrandfatherHaveCancerStep")
        
        let didMaternalGrandfatherPassAwayResult = ORKResultSelector(resultIdentifier: "didMaternalGrandfatherPassAwayStep")
        
        let predicateNoForDidMaternalGrandfatherPassAwayStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: didMaternalGrandfatherPassAwayResult, expectedAnswer: false)
        
        let predicateNoForDidMaternalGrandfatherPassAwayStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDidMaternalGrandfatherPassAwayStep, "maternalGrandfatherCurrentAgeStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDidMaternalGrandfatherPassAwayStepRule, forTriggerStepIdentifier: "didMaternalGrandfatherPassAwayStep")
        
        familyHistoryTask.setNavigationRule(ORKDirectStepNavigationRule(destinationStepIdentifier: "doesMaternalAuntHaveCancerStep"), forTriggerStepIdentifier: "maternalGrandfatherDeathAgeStep")
        
        //=========================
        let doesMaternalAuntHaveCancerResult = ORKResultSelector(resultIdentifier: "doesMaternalAuntHaveCancerStep")
        
        let predicateNoForDoesMaternalAuntHaveCancerStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: doesMaternalAuntHaveCancerResult, expectedAnswer: false)
        
        let predicateNoForDoesMaternalAuntHaveCancerStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDoesMaternalAuntHaveCancerStep, "doesMaternalUncleHaveCancerStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDoesMaternalAuntHaveCancerStepRule, forTriggerStepIdentifier: "doesMaternalAuntHaveCancerStep")
        
        let didMaternalAuntPassAwayResult = ORKResultSelector(resultIdentifier: "didMaternalAuntPassAwayStep")
        
        let predicateNoForDidMaternalAuntPassAwayStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: didMaternalAuntPassAwayResult, expectedAnswer: false)
        
        let predicateNoForDidMaternalAuntPassAwayStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDidMaternalAuntPassAwayStep, "maternalAuntCurrentAgeStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDidMaternalAuntPassAwayStepRule, forTriggerStepIdentifier: "didMaternalAuntPassAwayStep")
        
        familyHistoryTask.setNavigationRule(ORKDirectStepNavigationRule(destinationStepIdentifier: "doesMaternalUncleHaveCancerStep"), forTriggerStepIdentifier: "maternalAuntDeathAgeStep")
        
        //=========================
        let doesMaternalUncleHaveCancerResult = ORKResultSelector(resultIdentifier: "doesMaternalUncleHaveCancerStep")
        
        let predicateNoForDoesMaternalUncleHaveCancerStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: doesMaternalUncleHaveCancerResult, expectedAnswer: false)
        
        let predicateNoForDoesMaternalUncleHaveCancerStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDoesMaternalUncleHaveCancerStep, "doesPaternalAuntHaveCancerStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDoesMaternalUncleHaveCancerStepRule, forTriggerStepIdentifier: "doesMaternalUncleHaveCancerStep")
        
        let didMaternalUnclePassAwayResult = ORKResultSelector(resultIdentifier: "didMaternalUnclePassAwayStep")
        
        let predicateNoForDidMaternalUnclePassAwayStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: didMaternalUnclePassAwayResult, expectedAnswer: false)
        
        let predicateNoForDidMaternalUnclePassAwayStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDidMotherPassAwayStep, "maternalUncleCurrentAgeStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDidMaternalUnclePassAwayStepRule, forTriggerStepIdentifier: "didMaternalUnclePassAwayStep")
        
        familyHistoryTask.setNavigationRule(ORKDirectStepNavigationRule(destinationStepIdentifier: "doesdoesPaternalAuntHaveCancerStepHaveCancerStep"), forTriggerStepIdentifier: "maternalUncleDeathAgeStep")
        
        //=========================
        let doesPaternalAuntHaveCancerResult = ORKResultSelector(resultIdentifier: "doesPaternalAuntHaveCancerStep")
        
        let predicateNoForDoesPaternalAuntHaveCancerStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: doesPaternalAuntHaveCancerResult, expectedAnswer: false)
        
        let predicateNoForDoesPaternalAuntHaveCancerStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDoesPaternalAuntHaveCancerStep, "doesPaternalUncleHaveCancerStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDoesPaternalAuntHaveCancerStepRule, forTriggerStepIdentifier: "doesMaternalAuntHaveCancerStep")
        
        let didPaternalAuntPassAwayResult = ORKResultSelector(resultIdentifier: "didPaternalAuntPassAwayStep")
        
        let predicateNoForDidPaternalAuntPassAwayStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: didPaternalAuntPassAwayResult, expectedAnswer: false)
        
        let predicateNoForDidPaternalAuntPassAwayStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDidPaternalAuntPassAwayStep, "paternalAuntCurrentAgeStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDidFatherPassAwayStepRule, forTriggerStepIdentifier: "didPaternalAuntPassAwayStep")
        
        familyHistoryTask.setNavigationRule(ORKDirectStepNavigationRule(destinationStepIdentifier: "doesPaternalUncleHaveCancerStep"), forTriggerStepIdentifier: "paternalAuntDeathAgeStep")
        
        //=========================
        let doesPaternalUncleHaveCancerResult = ORKResultSelector(resultIdentifier: "doesPaternalUncleHaveCancerStep")
        
        let predicateNoForDoesPaternalUncleHaveCancerStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: doesPaternalUncleHaveCancerResult, expectedAnswer: false)
        
        let predicateNoForDoesPaternalUncleHaveCancerStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDoesPaternalUncleHaveCancerStep, "doesHalfBrotherHaveCancerStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDoesPaternalUncleHaveCancerStepRule, forTriggerStepIdentifier: "doesPaternalUncleHaveCancerStep")
        
        let didMotherPassAwayResult = ORKResultSelector(resultIdentifier: "didMotherPassAwayStep")
        
        let predicateNoForDidMotherPassAwayStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: didMotherPassAwayResult, expectedAnswer: false)
        
        let predicateNoForDidMotherPassAwayStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDidMotherPassAwayStep, "motherCurrentAgeStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDidFatherPassAwayStepRule, forTriggerStepIdentifier: "didMotherPassAwayStep")
        
        familyHistoryTask.setNavigationRule(ORKDirectStepNavigationRule(destinationStepIdentifier: "doesBrotherHaveCancerStep"), forTriggerStepIdentifier: "motherDeathAgeStep")
        
        //=========================
        let doesHalfBrotherHaveCancerResult = ORKResultSelector(resultIdentifier: "doesHalfBrotherHaveCancerStep")
        
        let predicateNoForDoesHalfBrotherHaveCancerStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: doesHalfBrotherHaveCancerResult, expectedAnswer: false)
        
        let predicateNoForDoesHalfBrotherHaveCancerStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDoesHalfBrotherHaveCancerStep, "doesHalfSisterHaveCancerStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDoesHalfBrotherHaveCancerStepRule, forTriggerStepIdentifier: "doesHalfBrotherHaveCancerStep")
        
        //=========================
        let doesHalfSisterHaveCancerResult = ORKResultSelector(resultIdentifier: "doesHalfSisterHaveCancerStep")
        
        let predicateNoForDoesHalfSisterHaveCancerStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: doesHalfSisterHaveCancerResult, expectedAnswer: false)
        
        let predicateNoForDoesHalfSisterHaveCancerStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDoesHalfSisterHaveCancerStep, "doesCousinHaveCancerStep")])
        familyHistoryTask.setNavigationRule(predicateNoForDoesHalfSisterHaveCancerStepRule, forTriggerStepIdentifier: "doesHalfSisterHaveCancerStep")
        
        //=========================
        let doesCousinHaveCancerResult = ORKResultSelector(resultIdentifier: "doesCousinHaveCancerStep")
        
        let predicateNoForDoesCousinHaveCancerStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: doesCousinHaveCancerResult, expectedAnswer: false)
        
        let predicateNoForDoesCousinHaveCancerStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForDoesCousinHaveCancerStep, "reviewStep")])
        
        familyHistoryTask.setNavigationRule(predicateNoForDoesCousinHaveCancerStepRule, forTriggerStepIdentifier: "doesCousinHaveCancerStep")
    }
}
