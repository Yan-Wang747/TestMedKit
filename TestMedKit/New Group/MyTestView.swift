//
//  MyTestView.swift
//  TestMedKit
//
//  Created by Student on 2018-05-07.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class MyTestView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func draw(_ rect: CGRect) {
        
        let text = NSAttributedString(string: "aa")
        text.draw(at: CGPoint(x: 80, y: 200))
    }
}
