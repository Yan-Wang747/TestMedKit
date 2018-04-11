//
//  FamilyInfo.swift
//  TestMedKit
//
//  Created by Student on 2018-04-11.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class FamilyInfo: TaskInfo {
    var haveAnyCancer: Bool = false
    var familiesWithCancer: [String]? = nil
    var diagnosedCancers: [String]? = nil
    var diagnosisAges: [Int]? = nil
    var isPassedAway: [Bool]? = nil
    var passeAwayAges: [Int]? = nil
    var currentAges: [Int]? = nil
}
