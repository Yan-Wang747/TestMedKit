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

    @objc func doneButtonAction(_ sender: UIBarButtonItem){
        var newBasicInfo = patient.basicInfo
        
        let newValue = newValueTextField.text!
        
        if newValue == "" {
            self.navigationController?.popViewController(animated: true)
            
            return
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
        
        let encoder = JSONEncoder()
        
        let jsonData = try! encoder.encode(newBasicInfo)
        
        server.asyncSendJsonData(endpoint: Server.Endpoints.BasicInfo.rawValue, jsonData: jsonData) { [weak self] _, response, error in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                //prompt server error: server returned error code
                return
            }
            
            self?.patient.basicInfo = newBasicInfo
            
            DispatchQueue.main.async {
                self?.navigationController?.popViewController(animated: true)
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
