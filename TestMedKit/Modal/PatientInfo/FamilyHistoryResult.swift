//
//  FamilyInfo.swift
//  TestMedKit
//
//  Created by Student on 2018-04-11.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class FamilyHistoryResult: SurveyResult, Codable {
    var haveAnyCancer: Bool = false
    var familiesWithCancer: [String]? = nil
    var diagnosedCancers: [String]? = nil
    var diagnosisAges: [Int]? = nil
    var isPassedAway: [Bool]? = nil
    var passeAwayAges: [Int]? = nil
    var currentAges: [Int]? = nil
    
//    enum FamilyResultKeys: String, CodingKey {
//        case haveAnyCancer
//        case familiesWithCancer
//        case diagnosedCancers
//        case diagnosisAges
//        case isPassedAway
//        case passeAwayAges
//        case currentAges
//    }
//    
//    override func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: FamilyResultKeys.self)
//        try container.encode(haveAnyCancer, forKey: FamilyResultKeys.haveAnyCancer)
//        try container.encode(familiesWithCancer, forKey: FamilyResultKeys.familiesWithCancer)
//        try container.encode(diagnosedCancers, forKey: FamilyResultKeys.diagnosedCancers)
//        try container.encode(diagnosisAges, forKey: FamilyResultKeys.diagnosisAges)
//        try container.encode(isPassedAway, forKey: FamilyResultKeys.isPassedAway)
//        try container.encode(passeAwayAges, forKey: FamilyResultKeys.passeAwayAges)
//        try container.encode(currentAges, forKey: FamilyResultKeys.currentAges)
//    }
}
