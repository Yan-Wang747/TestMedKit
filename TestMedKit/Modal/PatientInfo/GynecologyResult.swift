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
    
    enum GynecologyResultKeys: String, CodingKey {
        case haveEverBeenPregnant
        case numberOfFullTimePregnancies
        case fullTimePregnancyAge
        case numberOfMiscarriages
        case miscarriageAge
        case numberOfTerminatedPregnancies
        case terminatedPregnancyAge
        
        case menstrualCycle
        case menstruateStartAge
        case lastMenstrualPeriod
        case menstrualCycleLength
        
        case isMenopauseBegun
        case menopauseStatusSelections
        case postmenopausalAge
        case menopauseReasons
        
        case haveEverUsedHormones
        case hormoneSelections
        case hormoneYears

        case lastPAPSmearDate
        case lastMammogramDate
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: GynecologyResultKeys.self)
        try container.encode(haveEverBeenPregnant, forKey: GynecologyResultKeys.haveEverBeenPregnant)
        try container.encode(numberOfFullTimePregnancies, forKey: GynecologyResultKeys.numberOfFullTimePregnancies)
        try container.encode(fullTimePregnancyAge, forKey: GynecologyResultKeys.fullTimePregnancyAge)
        try container.encode(numberOfMiscarriages, forKey: GynecologyResultKeys.numberOfMiscarriages)
        try container.encode(miscarriageAge, forKey: GynecologyResultKeys.miscarriageAge)
        try container.encode(numberOfTerminatedPregnancies, forKey: GynecologyResultKeys.numberOfTerminatedPregnancies)
        try container.encode(terminatedPregnancyAge, forKey: GynecologyResultKeys.terminatedPregnancyAge)
        
        try container.encode(menstrualCycle, forKey: GynecologyResultKeys.menstrualCycle)
        try container.encode(menstruateStartAge, forKey: GynecologyResultKeys.menstruateStartAge)
        try container.encode(lastMenstrualPeriod, forKey: GynecologyResultKeys.lastMenstrualPeriod)
        try container.encode(menstrualCycleLength, forKey: GynecologyResultKeys.menstrualCycleLength)
        
        try container.encode(isMenopauseBegun, forKey: GynecologyResultKeys.isMenopauseBegun)
        try container.encode(menopauseStatusSelections, forKey: GynecologyResultKeys.menopauseStatusSelections)
        try container.encode(postmenopausalAge, forKey: GynecologyResultKeys.postmenopausalAge)
        try container.encode(menopauseReasons, forKey: GynecologyResultKeys.menopauseReasons)
        
        try container.encode(haveEverUsedHormones, forKey: GynecologyResultKeys.haveEverUsedHormones)
        try container.encode(hormoneSelections, forKey: GynecologyResultKeys.hormoneSelections)
        try container.encode(hormoneYears, forKey: GynecologyResultKeys.hormoneYears)
        
        try container.encode(lastPAPSmearDate, forKey: GynecologyResultKeys.lastPAPSmearDate)
        try container.encode(lastMammogramDate, forKey: GynecologyResultKeys.lastMammogramDate)
        
    }
}
