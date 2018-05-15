//
//  Medication.swift
//  TestMedKit
//
//  Created by Student on 2018-04-12.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class MedicationResult: SurveyResult {
    var takeMedication = [false, false, false]
    var names: [String] = []
    var units: [String] = []
    var doses: [Int] = []
    var frequencies: [String] = []
    var intakeWays: [String] = []
    var startDates: [Date] = []
    
    enum MedicationResultKeys: String, CodingKey {
        case takeMedication
        case names
        case units
        case doses
        case frequencies
        case intakeWays
        case startDates
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: MedicationResultKeys.self)
        try container.encode(takeMedication, forKey: MedicationResultKeys.takeMedication)
        try container.encode(names, forKey: MedicationResultKeys.names)
        try container.encode(units, forKey: MedicationResultKeys.units)
        try container.encode(doses, forKey: MedicationResultKeys.doses)
        try container.encode(frequencies, forKey: MedicationResultKeys.frequencies)
        try container.encode(intakeWays, forKey: MedicationResultKeys.intakeWays)
        try container.encode(startDates, forKey: MedicationResultKeys.startDates)
    }
}
