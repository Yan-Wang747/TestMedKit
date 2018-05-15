//
//  PersonalInfo.swift
//  TestMedKit
//
//  Created by Student on 2018-04-10.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class PersonalResult: SurveyResult{
    var isMarried: Bool = false
    var livingWith: [String]? = nil
    var supportFamilies: [String]? = nil
    var accessToTransportation: Bool? = nil
    var resideLocations: [String] = []
    var occupation: String = ""
    var isActivePerson: Bool = false
    var activies: [String]? = nil
    var regularMeal: Bool = false
    var nutritionalSupplement: Bool = false
    var liquidDiet: Bool = false
    
    enum PersonalResultKeys: String, CodingKey {
        case isMarried
        case livingWith
        case supportFamilies
        case accessToTransportation
        case resideLocations
        case occupation
        case isActivePerson
        case activies
        case regularMeal
        case nutritionalSupplement
        case liquidDiet
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: PersonalResultKeys.self)
        try container.encode(isMarried, forKey: PersonalResultKeys.isMarried)
        try container.encode(livingWith, forKey: PersonalResultKeys.livingWith)
        try container.encode(supportFamilies, forKey: PersonalResultKeys.supportFamilies)
        try container.encode(accessToTransportation, forKey: PersonalResultKeys.accessToTransportation)
        try container.encode(resideLocations, forKey: PersonalResultKeys.resideLocations)
        try container.encode(occupation, forKey: PersonalResultKeys.occupation)
        try container.encode(isActivePerson, forKey: PersonalResultKeys.isActivePerson)
        try container.encode(activies, forKey: PersonalResultKeys.activies)
        try container.encode(regularMeal, forKey: PersonalResultKeys.regularMeal)
        try container.encode(nutritionalSupplement, forKey: PersonalResultKeys.nutritionalSupplement)
        try container.encode(liquidDiet, forKey: PersonalResultKeys.liquidDiet)
    }
}
