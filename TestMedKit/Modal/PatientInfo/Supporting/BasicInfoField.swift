//
//  UpdateField.swift
//  TestMedKit
//
//  Created by Student on 2018-05-04.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class BasicInfoField: Encodable {
    let field: String
    let newValue: String
    
    init(field: String, newValue: String) {
        self.field = field
        self.newValue = newValue
    }
}
