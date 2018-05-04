//
//  Server+updateField.swift
//  TestMedKit
//
//  Created by Student on 2018-05-04.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

extension Server {
    
    func asyncUpdateField(field: String, newValue: String, responseHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let updateBasicInfoEndpoint = "UpdateBasicInfo"
        let updateBasicInfoURL = URL(string: "\(baseURL)/\(updateBasicInfoEndpoint)")!
        
        var updateBasicInfoRequest = URLRequest(url: updateBasicInfoURL)
        updateBasicInfoRequest.httpMethod = "PUT"
        updateBasicInfoRequest.addValue("Bear \(sessionID)", forHTTPHeaderField: "Authorization")
        
        let update = UpdateField(field: field, newValue: newValue)
        let encoder = JSONEncoder()
        let bodyData = try! encoder.encode(update)
        
        updateBasicInfoRequest.httpBody = bodyData
        
        session.dataTask(with: updateBasicInfoRequest, completionHandler: responseHandler).resume()
    }
}
