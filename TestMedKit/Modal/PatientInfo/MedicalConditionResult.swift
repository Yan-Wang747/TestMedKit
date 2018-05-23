//
//  MedicationConditionInfo.swift
//  TestMedKit
//
//  Created by Student on 2018-04-17.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class MedicalConditionResult: SurveyResult, Codable {
    var haveAnyMedicalCondition: Bool = false
    var medicalConditions: [String]? = nil
    var onsetDates: [Date]? = nil
    var isTreated: [Bool]? = nil
    var howIsTreated: [String]? = nil
    
//    enum MedicationConditionResultKeys: String, CodingKey {
//        case haveAnyMedicalCondition
//        case medicalConditions
//        case onsetDates
//        case isTreated
//        case howIsTreated
//    }
//    
//    override func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: MedicationConditionResultKeys.self)
//        try container.encode(haveAnyMedicalCondition, forKey: MedicationConditionResultKeys.haveAnyMedicalCondition)
//        try container.encode(medicalConditions, forKey: MedicationConditionResultKeys.medicalConditions)
//        try container.encode(onsetDates, forKey: MedicationConditionResultKeys.onsetDates)
//        try container.encode(isTreated, forKey: MedicationConditionResultKeys.isTreated)
//        try container.encode(howIsTreated, forKey: MedicationConditionResultKeys.howIsTreated)
//    }
}
