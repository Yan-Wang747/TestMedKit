//
//  Server.swift
//  TestMedKit
//
//  Created by Student on 2018-05-03.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Server {
    let serverAddr: String
    let serverPort: Int?
    let rootURL = "MyCCMB"
    let conf = URLSessionConfiguration.default
    var session: URLSession
    var sessionID: String?
    
    init(serverAddr: String, serverPort: Int?) {
        self.serverAddr = serverAddr
        self.serverPort = serverPort
        conf.allowsCellularAccess = true
        conf.waitsForConnectivity = true
        conf.timeoutIntervalForResource = 10
        session = URLSession(configuration: conf)
    }
    
    var base: String {
        get {
            if serverPort == nil {
                return "\(serverAddr)/\(rootURL)"
            } else {
                return "\(serverAddr):\(serverPort!)/\(rootURL)"
            }
        }
    }
    
    func asyncAuthenticate(userID: String, password: String, responseHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let endpoint = Server.Endpoints.Login.rawValue
        let loginString = "\(userID):\(password)"
        let loginBase64 = loginString.data(using: .utf8)!.base64EncodedString()
        let loginURL = URL(string: "\(base)/\(endpoint)")!
        
        var loginRequest = URLRequest(url: loginURL)
        loginRequest.addValue("Basic \(loginBase64)", forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: loginRequest, completionHandler: responseHandler).resume()
    }
    
    func asyncSignOut(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let sessionID = sessionID else {
            
            //responseHandler(nil, nil, error)
            return
        }
        
        let endpoint = Server.Endpoints.Logout.rawValue
        let endpointURL = URL(string: "\(base)/\(endpoint)")!
        
        var request = URLRequest(url: endpointURL)
        request.addValue("Bear \(sessionID)", forHTTPHeaderField: "Authorization")
        session.dataTask(with: request, completionHandler: completionHandler).resume()
    }
    
    var maxConnections: Int {
        get {
            return session.configuration.httpMaximumConnectionsPerHost
        }
        set {
            let conf = session.configuration
            conf.httpMaximumConnectionsPerHost = newValue
            session = URLSession(configuration: conf)
        }
    }
}
