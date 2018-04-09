//
//  AlcoholInfo.swift
//  TestMedKit
//
//  Created by Student on 2018-04-09.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class AlcoholInfo: TaskInfo{
    var drinkAlcohol: Bool = false
    var amountOfCups: Int? = 0
    var everDrinkAlcohol: Bool = false
    var hasQuitDrinking: Bool? = false
    var amountOfCupsForEverDrinking: Int? = 0
    var exposedToHazardousInstances: Bool = false
    var hazardousInstances: [String]? = nil
    var usedProducts: Bool = false
    var products: [String]? = nil
}
