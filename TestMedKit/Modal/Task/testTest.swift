//
//  testTest.swift
//  TestMedKit
//
//  Created by Student on 2018-03-14.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class TestTask: Task {
    init(_ viewController: UIViewController) {
        let steps = TestTask.createSteps()
        
        let testTask = ORKNavigableOrderedTask(identifier: "testTask", steps: steps)

        //TestTask.createNavigationRule(for: testTask)
        
        super.init(testTask, viewController)
    }
    
    private static func createSteps() -> [ORKStep]{
        var steps: [ORKStep] = []
        
        let tableStep = ORKTableStep(identifier: "tt")
        let items: [NSString] = ["aa", "bb"]
        tableStep.items = items
        
        steps.append(tableStep)
        
        
        return steps
    }
}
