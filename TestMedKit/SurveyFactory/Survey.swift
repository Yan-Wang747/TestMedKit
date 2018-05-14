//
//  Survey.swift
//  TestMedKit
//
//  Created by Student on 2018-05-14.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class Survey {
    let identifier: String
    let orkTaskViewController: ORKTaskViewController
    let uploadEndpoint: String
    let resultProcessor: SurveyResultProcessor
    
    init(identifier: String, orkTaskViewController: ORKTaskViewController, uploadEndpoint: String, resultProcessor: SurveyResultProcessor) {
        self.identifier = identifier
        self.orkTaskViewController = orkTaskViewController
        self.uploadEndpoint = uploadEndpoint
        self.resultProcessor = resultProcessor
    }
}
