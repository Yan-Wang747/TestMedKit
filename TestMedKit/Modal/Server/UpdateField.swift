//
//  UpdateField.swift
//  TestMedKit
//
//  Created by Student on 2018-05-04.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class UpdateField<T: Codable>: Codable {
    let field: String
    let newValue: T
    
    init(field: String, newValue: T) {
        self.field = field
        self.newValue = newValue
    }
}
