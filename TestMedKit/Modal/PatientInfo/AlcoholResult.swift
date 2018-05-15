//
//  AlcoholInfo.swift
//  TestMedKit
//
//  Created by Student on 2018-04-09.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class AlcoholResult: SurveyResult {
    var drinkAlcohol: Bool = false
    var amountOfCups: Int? = nil
    var everDrinkAlcohol: Bool = false
    var hasQuitDrinking: Bool? = nil
    var amountOfCupsForEverDrinking: Int? = nil
    var exposedToHazardousInstances: Bool = false
    var hazardousInstances: [String]? = nil
    var usedProducts: Bool = false
    var products: [String]? = nil
    
    enum AlcoholResultKeys: String, CodingKey {
        case drinkAlcohol
        case amountOfCups
        case everDrinkAlcohol
        case hasQuitDrinking
        case amountOfCupsForEverDrinking
        case exposedToHazardousInstances
        case hazardousInstances
        case usedProducts
        case products
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlcoholResultKeys.self)
        try container.encode(drinkAlcohol, forKey: AlcoholResultKeys.drinkAlcohol)
        try container.encode(amountOfCups, forKey: AlcoholResultKeys.amountOfCups)
        try container.encode(everDrinkAlcohol, forKey: AlcoholResultKeys.everDrinkAlcohol)
        try container.encode(hasQuitDrinking, forKey: AlcoholResultKeys.hasQuitDrinking)
        try container.encode(amountOfCupsForEverDrinking, forKey: AlcoholResultKeys.amountOfCupsForEverDrinking)
        try container.encode(exposedToHazardousInstances, forKey: AlcoholResultKeys.exposedToHazardousInstances)
        try container.encode(hazardousInstances, forKey: AlcoholResultKeys.hazardousInstances)
        try container.encode(usedProducts, forKey: AlcoholResultKeys.usedProducts)
        try container.encode(products, forKey: AlcoholResultKeys.products)
    }
}
