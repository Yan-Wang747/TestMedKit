//
//  BasicResultProcessor.swift
//  TestMedKit
//
//  Created by Student on 2018-05-30.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

class BasicResultProcessor: SurveyResultProcessor {
    func startProcessResult(_ result: ORKTaskResult) -> Data? {
        let firstName = getFirstName(result)
        let lastName = getLastName(result)
        let gender = getGender(result)
        let DOB = getDateOfBirth(result)
        let phoneNumber = getPhoneNumber(result)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd"
        let dateString = dateFormatter.string(from: DOB)
        let email = getEmail(result)
        
        let basicInfo = BasicInfo(firstName: firstName, lastName: lastName, gender: gender, dateOfBirth: dateString, dateFormatterString: dateFormatter.dateFormat, phone: phoneNumber, email: email)
        
        let jsonData = try! JSONEncoder().encode(basicInfo)
        
        return jsonData
    }
    
    func getFirstName(_ result: ORKTaskResult) -> String {
        return (result.stepResult(forStepIdentifier: "SignUpStep")!.result(forIdentifier: "FirstNameItem") as! ORKTextQuestionResult).textAnswer!
    }
    
    func getLastName(_ result: ORKTaskResult) -> String {
        return (result.stepResult(forStepIdentifier: "SignUpStep")!.result(forIdentifier: "LastNameItem") as! ORKTextQuestionResult).textAnswer!
    }
    
    func getGender(_ result: ORKTaskResult) -> String {
        return (result.stepResult(forStepIdentifier: "SignUpStep")!.result(forIdentifier: "GenderItem") as! ORKChoiceQuestionResult).choiceAnswers!.first! as! String
    }
    
    func getDateOfBirth(_ result: ORKTaskResult) -> Date {
        return (result.stepResult(forStepIdentifier: "SignUpStep")!.result(forIdentifier: "DateOfBirthItem") as! ORKDateQuestionResult).dateAnswer!
    }
    
    func getPhoneNumber(_ result: ORKTaskResult) -> String? {
        return (result.stepResult(forStepIdentifier: "SignUpStep")!.result(forIdentifier: "PhoneItem") as? ORKTextQuestionResult)?.textAnswer
    }
    
    func getEmail(_ result: ORKTaskResult) -> String? {
        return (result.stepResult(forStepIdentifier: "SignUpStep")!.result(forIdentifier: "PhoneItem") as? ORKTextQuestionResult)?.textAnswer
    }
}
