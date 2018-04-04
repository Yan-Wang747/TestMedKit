//
//  BasicInfo.swift
//  TestMedKit
//
//  Created by Student on 2018-04-03.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class BasicInfo {
    var firstName: String
    var lastName: String
    var gender: String
    var dateOfBirth: Date
    var phone: String?
    var email: String?
    
    init(firstName: String, lastName: String, gender: String, dateOfBirth: Date,phone: String?, email: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.phone = phone
        self.email = email
    }
    
    var fullName: String {
        get {
            return firstName + " \(lastName)"
        }
    }
    
    var age: Int {
        get {
            let currentDate = Date()
            let timeInterval = currentDate.timeIntervalSince(dateOfBirth)
            return Int(timeInterval / (3600*24*365))
        }
    }
}
