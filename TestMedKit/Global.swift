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
    static let serverAddr: String? = "ccmblxws0002.cancercare.mb.ca"
    static let httpProtocol: String? = "https"
    static let port: Int? = 443
    static let rootURL: String? = "MyCCMB"
    static let timeout: Double? = 10
}
