//
//  File.swift
//  TestMedKit
//
//  Created by Student on 2018-02-21.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Patient{
    var firstName: String
    var lastName: String
    var gender: String
    var dateOfBirth: String
    var phoneNumber: String
    var email: String
    
    init(firstName: String, lastName: String, gender: String, dateOfBirth: String, phoneNumber: String, email: String){
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.phoneNumber = phoneNumber
        self.email = email
    }
}
