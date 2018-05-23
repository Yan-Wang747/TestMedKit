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
        var newBasicInfo = patient.basicInfo
        
        guard let newValue = newValueTextField.text else { fatalError() }
        
        if newValue == "" {
            self.navigationController?.popViewController(animated: true)
            
            return
        }
        
        switch editingField {
        case "FirstName":
            newBasicInfo.firstName = newValue
        case "LastName":
            newBasicInfo.lastName = newValue
        case "Phone":
            newBasicInfo.phone = newValue
        case "Email":
            newBasicInfo.email = newValue
        default:
            fatalError()
        }
        
        let encoder = JSONEncoder()
        
        guard let jsonData = try? encoder.encode(newBasicInfo) else { fatalError() }
        
        //self will not be unloaded from the memory
        server.asyncSendJsonData(endpoint: Server.Endpoints.BasicInfo.rawValue, jsonData: jsonData) { (_, response, _) in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            self.patient.basicInfo = newBasicInfo
            
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
            
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
