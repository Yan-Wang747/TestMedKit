//
//  TabaccoInfo.swift
//  TestMedKit
//
//  Created by Student on 2018-04-03.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class TobaccoResult: SurveyResult, Codable {
    var useTobacco: Bool = false
    var everUseTobacco: Bool = false
    var selectedTobaccoProducts: [String]? = nil
    var startDates: [String]? = nil
    var amounts: [Int]? = nil
    
    var selectedTobaccoProductsForEverSmoke: [String]? = nil
    var startDatesForEverSmoke: [String]? = nil
    var amountsForEverSmoke: [Int]? = nil
}
