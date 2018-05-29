//
//  EditNameViewController.swift
//  TestMedKit
//
//  Created by Student on 2018-02-21.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class TextFieldEditViewController: BasicInfoEditViewController {
    
    @IBOutlet weak var promptMessageLabel: UILabel!
    @IBOutlet weak var newValueTextField: UITextField!
    
    private let defaultPromptMessage = "Please enter your "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        switch editingField{
        case "EditFirstName":
            newValueTextField.text = patient.basicInfo.firstName
            promptMessageLabel.text = defaultPromptMessage + "first name"
        case "EditLastName":
            newValueTextField.text = patient.basicInfo.lastName
            promptMessageLabel.text = defaultPromptMessage + "last name"
        case "EditPhone":
            newValueTextField.text = patient.basicInfo.phone
            promptMessageLabel.text = defaultPromptMessage + "phone number"
        case "EditEmail":
            newValueTextField.text = patient.basicInfo.email
            promptMessageLabel.text = defaultPromptMessage + "email address"
        default:
            fatalError()
        }
        
        newValueTextField.becomeFirstResponder()
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func getNewBasicInfo() -> BasicInfo? {
        var newBasicInfo = patient.basicInfo
        
        let newValue = newValueTextField.text!
        
        if newValue == "" {
            return nil
        }
        
        switch editingField {
        case "EditFirstName":
            newBasicInfo.firstName = newValue
        case "EditLastName":
            newBasicInfo.lastName = newValue
        case "EditPhone":
            newBasicInfo.phone = newValue
        case "EditEmail":
            newBasicInfo.email = newValue
        default:
            fatalError()
        }
        
        return newBasicInfo
    }
    
    override func updateStart() {
        super.updateStart()
        
        newValueTextField.isEnabled = false
    }
    
    override func updateComplete() {
        super.updateComplete()
        
        newValueTextField.isEnabled = true
    }
}
