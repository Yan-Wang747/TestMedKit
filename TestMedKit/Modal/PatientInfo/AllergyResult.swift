//
//  AllergyInfo.swift
//  TestMedKit
//
//  Created by Student on 2018-04-12.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class AllergyResult: SurveyResult, Codable {
    var haveAnyAllergy: Bool = false
    var allergyTypes: [String]? = nil
    var allergyNames: [String]? = nil
    var reactions: [[String]]? = nil
    var severities: [[String]]? = nil
    var datesOfOccurrence: [[Date]]? = nil
}
