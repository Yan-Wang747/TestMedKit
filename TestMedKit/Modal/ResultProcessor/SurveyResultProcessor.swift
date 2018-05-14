//
//  SurveyResultProcessor.swift
//  TestMedKit
//
//  Created by Student on 2018-05-11.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

protocol SurveyResultProcessor{
    func startProcessResult(_ result: ORKTaskResult) -> SurveyResult?
}
