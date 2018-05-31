//
//  BasicInfo.swift
//  TestMedKit
//
//  Created by Student on 2018-04-03.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

struct BasicInfo: Codable {
    var firstName: String
    var lastName: String
    var gender: String
    var dateOfBirth: String
    var phone: String?
    var email: String
    var dateFormatterString: String
    
    init(firstName: String, lastName: String, gender: String, dateOfBirth: String, dateFormatterString: String, phone: String?, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.phone = phone
        self.email = email
        self.dateFormatterString = dateFormatterString
    }
    
    var dateOfBirthInDate: Date {
        
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormatterString
            return dateFormatter.date(from: dateOfBirth)!
        }
        set {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormatterString
            dateOfBirth = dateFormatter.string(from: newValue)
        }
    }
    
    var fullName: String {
        get {
            return firstName + " \(lastName)"
        }
    }
    
    var age: Int {
        get {
            let currentDate = Date()
            
            let birthday = dateOfBirthInDate
            let timeInterval = currentDate.timeIntervalSince(birthday)
            return Int(timeInterval / (3600*24*365))
        }
    }
}
