//
//  Medication.swift
//  TestMedKit
//
//  Created by Student on 2018-04-12.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class MedicationResult: SurveyResult, Codable {
    var takeMedication = [false, false, false]
    var names: [String] = []
    var units: [String] = []
    var doses: [Int] = []
    var frequencies: [String] = []
    var intakeWays: [String] = []
    var startDates: [Date] = []
}
