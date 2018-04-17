//
//  MedicationConditionInfo.swift
//  TestMedKit
//
//  Created by Student on 2018-04-17.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class MedicalConditionInfo: TaskInfo {
    var haveAnyMedicalCondition: Bool = false
    var medicalConditions: [String]? = nil
    var onsetDates: [Date]? = nil
    var isTreated: [Bool]? = nil
    var howIsTreated: [String]? = nil
}
