//
//  Server.swift
//  TestMedKit
//
//  Created by Student on 2018-05-03.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Server {
    let serverAddr = Configure.serverAddr ?? "localhost"
    let serverPort = Configure.port ?? 8084
    let rootURL = Configure.rootURL ?? "MyCCMB"
    let httpProtocol = Configure.httpProtocol ?? "http"
    let conf = URLSessionConfiguration.default
    var session: URLSession
    var sessionID: String!
    
    init() {
        conf.allowsCellularAccess = true
        conf.waitsForConnectivity = true
        
        if Configure.timeout != nil {
            conf.timeoutIntervalForResource = Configure.timeout!
        }
        
        session = URLSession(configuration: conf)
    }
    
    var base: String {
        return "\(httpProtocol)://\(serverAddr):\(serverPort)/\(rootURL)"
    }
    
    func asyncAuthenticate(userID: String, password: String, responseHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let endpoint = Server.Endpoints.Login.rawValue
        let loginString = "\(userID):\(password)"
        let loginBase64 = loginString.data(using: .utf8)!.base64EncodedString()
        let loginURL = URL(string: "\(base)/\(endpoint)")!
        
        var request = URLRequest(url: loginURL)
        request.addValue("Basic \(loginBase64)", forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request, completionHandler: responseHandler).resume()
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
    
    func asyncSignUp(endpoint: String, userID: String, password: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let registrationString = "\(userID):\(password)"
        
        let registrationBase64 = registrationString.data(using: .utf8)!.base64EncodedString()
        
        let registrationURL = URL(string: "\(base)/\(endpoint)")!
        
        var request = URLRequest(url: registrationURL)
        request.addValue("\(registrationBase64)", forHTTPHeaderField: "Registration")
        
        session.dataTask(with: request, completionHandler: completionHandler).resume()
    }
}
