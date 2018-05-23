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
    
//    enum SurgeryResultKeys: String, CodingKey {
//        case takeSurgery
//        case surgeries
//        case dates
//    }
//    
//    override func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: SurgeryResultKeys.self)
//        try container.encode(takeSurgery, forKey: SurgeryResultKeys.takeSurgery)
//        try container.encode(surgeries, forKey: SurgeryResultKeys.surgeries)
//        try container.encode(dates, forKey: SurgeryResultKeys.dates)
//    }
}
