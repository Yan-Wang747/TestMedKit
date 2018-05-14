//
//  TextFieldEditViewController+updateFirstName.swift
//  TestMedKit
//
//  Created by Student on 2018-05-04.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

extension TextFieldEditViewController {
    
    func updateField(field: String, newValue: String) {
        let encoder = JSONEncoder()
        
        guard let jsonData = try? encoder.encode(BasicInfoField(field: field, newValue: newValue)) else { fatalError() }
        
        server.asyncSendJsonData(endpoint: Endpoints.updateBasicInfo.rawValue, jsonData: jsonData) { (_, response, _) in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            switch field {
            case "FirstName":
                self.patient.basicInfo.firstName = newValue
            case "LastName":
                self.patient.basicInfo.lastName = newValue
            case "Phone":
                self.patient.basicInfo.phone = newValue
            case "Email":
                self.patient.basicInfo.email = newValue
            default:
                fatalError()
            }
            
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
