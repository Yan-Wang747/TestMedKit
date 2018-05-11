//
//  GynecologyInfo.swift
//  TestMedKit
//
//  Created by Student on 2018-04-19.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class GynecologyResult: SurveyResult {
    var haveEverBeenPregnant = false
    var numberOfFullTimePregnancies: Int? = nil
    var fullTimePregnancyAge: Int? = nil
    var numberOfMiscarriages: Int? = nil
    var miscarriageAge: Int? = nil
    var numberOfTerminatedPregnancies: Int? = nil
    var terminatedPregnancyAge: Int? = nil
    
    var menstrualCycle = false
    var menstruateStartAge: Int? = nil
    var lastMenstrualPeriod: Date? = nil
    var menstrualCycleLength: Int? = nil
    
    var isMenopauseBegun = false
    var menopauseStatusSelections: [String]? = nil
    var postmenopausalAge: Int? = nil
    var menopauseReasons: [String]? = nil
    
    var haveEverUsedHormones = false
    var hormoneSelections: [String]? = nil
    var hormoneYears: [Int]? = nil
    
    var lastPAPSmearDate: Date? = nil
    var lastMammogramDate: Date? = nil
}
