//
//  Survey.swift
//  TestMedKit
//
//  Created by Student on 2018-05-14.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class SurveyViewController: ORKTaskViewController {

    var uploadEndpoint: String!
    var resultProcessor: SurveyResultProcessor!
    
    static func createSurveyViewController(orkTask: ORKTask, uploadEndpoint: String, resultProcessor: SurveyResultProcessor) -> SurveyViewController {
        
        let selfInstance = SurveyViewController(task: orkTask, taskRun: nil)
        selfInstance.uploadEndpoint = uploadEndpoint
        selfInstance.resultProcessor = resultProcessor
        
        return selfInstance
    }
}
