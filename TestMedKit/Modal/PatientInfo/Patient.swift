//
//  File.swift
//  TestMedKit
//
//  Created by Student on 2018-02-21.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Patient{
    var sessionID: String
    var basicInfo: BasicInfo
    var tobaccoInfo: TobaccoInfo?
    var alcoholInfo: AlcoholInfo?
    var personalInfo: PersonalInfo?
    var familyInfo: FamilyInfo?
    var allergyInfo: AllergyInfo?
    var medicationInfo: MedicationInfo?
    var medicalConditionInfo: MedicalConditionInfo?
    var surgicalInfo: SurgicalInfo?
    var gynecologyInfo: GynecologyInfo?
    
    init(sessionID: String, basicInfo: BasicInfo) {
        self.sessionID = sessionID
        self.basicInfo = basicInfo
    }
}
