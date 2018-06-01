//
//  Global.swift
//  TestMedKit
//
//  Created by Student on 2018-05-31.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

let alertController = UIAlertController(title: "Oops", message: nil, preferredStyle: .alert)

struct Configure {
    static let serverAddr: String? = "localhost"
    static let httpProtocol: String? = "http"
    static let port: Int? = 8084
    static let rootURL: String? = "MyCCMB"
}
