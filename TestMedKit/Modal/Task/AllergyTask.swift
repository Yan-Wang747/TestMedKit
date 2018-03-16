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
    init(_ viewController: UIViewController) {
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Personal Information"
        instructionStep.detailText = "This survey helps us understand your allergy background"
        steps.append(instructionStep)
        
        let allergyTask = ORKAllergyTask(identifier: "allergyTask", steps: steps)
        
        super.init(allergyTask, viewController)
    }
}
