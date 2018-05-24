//
//  Server+updateSurvey.swift
//  TestMedKit
//
//  Created by Student on 2018-05-10.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import ResearchKit

extension Server {
    func asyncSendJsonData(endpoint: String, jsonData: Data, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let sessionID = sessionID else {
            
            //responseHandler(nil, nil, error)
            return
        }
        
        let endpointURL = URL(string: "\(base)/\(endpoint)")!
        
        var request = URLRequest(url: endpointURL)
        request.httpMethod = "POST"
        request.addValue("Bear \(sessionID)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        session.dataTask(with: request, completionHandler: completionHandler).resume()
    }
}
