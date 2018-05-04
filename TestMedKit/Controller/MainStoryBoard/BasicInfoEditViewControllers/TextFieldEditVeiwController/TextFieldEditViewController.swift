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
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneButtonAction(_:)))
        self.navigationItem.rightBarButtonItem = doneBarButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        promptMessageLabel.text = defaultPromptMessage + editingField
        
        switch editingField{
        case "FirstName":
            newValueTextField.text = patient.basicInfo.firstName
        case "LastName":
            newValueTextField.text = patient.basicInfo.lastName
        case "Phone":
            newValueTextField.text = patient.basicInfo.phone
        case "Email":
            newValueTextField.text = patient.basicInfo.email
        default:
            fatalError()
        }
        
        newValueTextField.becomeFirstResponder()
    }

    @objc func doneButtonAction(_ sender: UIBarButtonItem){
        if let newValue = newValueTextField.text{
            updateField(field: editingField, newValue: newValue)

        }
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

}
