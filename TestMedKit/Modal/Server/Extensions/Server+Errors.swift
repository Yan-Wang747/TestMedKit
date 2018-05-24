//
//  Server+Errors.swift
//  TestMedKit
//
//  Created by Student on 2018-05-24.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

extension Server {
    enum Errors: LocalizedError {
        case errorCode(Int)
        case noCookieReturned
        case invalidCookie
        case invalidResponse
        case noDataReturned
        case invalidData
        
        var errorDescription: String? {
            get {
                switch self {
                case .errorCode(let code):
                    if code == 403 {
                        return "Wrong ID/Password combination"
                    } else {
                        return "Server returned error code: \(code)"
                    }
                case .noCookieReturned:
                    return "No cookies returned from the server"
                case .invalidCookie:
                    return "Server returned invalid cookie"
                case .invalidResponse:
                    return "Server returned invalid response"
                case .noDataReturned:
                    return "No data returned from the server"
                case .invalidData:
                    return "Server returned invalid data"
                }
            }
        }
    }
}
