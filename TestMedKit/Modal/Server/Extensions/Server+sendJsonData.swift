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
    func asyncSendJsonData(endpoint: String, jsonData: Data, responseHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let endpointURL = URL(string: "\(base)/\(endpoint)") else { fatalError() }
        
        var request = URLRequest(url: endpointURL)
        request.httpMethod = "PUT"
        request.addValue("Bear \(sessionID)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        session.dataTask(with: request, completionHandler: responseHandler).resume()
    }
}
