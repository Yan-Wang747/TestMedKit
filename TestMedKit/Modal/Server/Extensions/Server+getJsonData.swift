//
//  Server+getBasicInfo.swift
//  TestMedKit
//
//  Created by Student on 2018-05-03.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

extension Server {
    
    func asyncGetJsonData(endpoint: String, responseHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {

        let endpointURL = URL(string: "\(base)/\(endpoint)")!
        
        var request = URLRequest(url: endpointURL)
        request.addValue("Bear \(sessionID)", forHTTPHeaderField: "Authorization")
        session.dataTask(with: request, completionHandler: responseHandler).resume()
    }
}
