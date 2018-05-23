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
    
//    enum AllergyResultKeys: String, CodingKey {
//        case haveAnyAllergy
//        case allergyTypes
//        case allergyNames
//        case reactions
//        case severities
//        case datesOfOccurrence
//    }
//    
//    override func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: AllergyResultKeys.self)
//        try container.encode(haveAnyAllergy, forKey: AllergyResultKeys.haveAnyAllergy)
//        try container.encode(allergyTypes, forKey: AllergyResultKeys.allergyTypes)
//        try container.encode(allergyNames, forKey: AllergyResultKeys.allergyNames)
//        try container.encode(reactions, forKey: AllergyResultKeys.reactions)
//        try container.encode(severities, forKey: AllergyResultKeys.severities)
//        try container.encode(datesOfOccurrence, forKey: AllergyResultKeys.datesOfOccurrence)
//    }
}
