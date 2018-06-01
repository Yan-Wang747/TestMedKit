//
//  SurgicalInfo.swift
//  TestMedKit
//
//  Created by Student on 2018-04-18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class SurgeryResult: SurveyResult, Codable {
    var takeSurgery: Bool = false
    var surgeries: [String]? = nil
    var dates: [Date]? = nil
}
