//
//  Server+getBasicInfo.swift
//  TestMedKit
//
//  Created by Student on 2018-05-03.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

extension Server {
    
    func getBasicInfo(responseHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {

        let getBasicInfoEndPoint = "GetBasicInfo"
        let getBasicInfoURL = URL(string: "\(baseURL)/\(getBasicInfoEndPoint)")!
        
        var basicInfoRequest = URLRequest(url: getBasicInfoURL)
        basicInfoRequest.addValue("Bear \(sessionID)", forHTTPHeaderField: "Authorization")
        session.dataTask(with: basicInfoRequest, completionHandler: responseHandler).resume()
    }
}
