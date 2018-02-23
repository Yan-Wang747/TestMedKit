//
//  EditNameViewController.swift
//  TestMedKit
//
//  Created by Student on 2018-02-21.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    var which: EditType!
    var patient: Patient!
    
    @IBOutlet weak var promptMessageLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!

    private let defaultPromptMessage = "Please enter your "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneButtonAction(_:)))
        self.navigationItem.rightBarButtonItem = doneBarButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        promptMessageLabel.text = defaultPromptMessage + which.rawValue
        switch which{
        case .FirstName:
            nameTextField.text = patient.firstName
        case .LastName:
            nameTextField.text = patient.lastName
        case .Phone:
            nameTextField.text = patient.phoneNumber
        case .Email:
            nameTextField.text = patient.email
        default:
            fatalError()
        }
        nameTextField.becomeFirstResponder()
    }

    @objc func doneButtonAction(_ sender: UIBarButtonItem){
        if let newValue = nameTextField.text{
            switch which{
            case .FirstName:
                patient.firstName = newValue
            case .LastName:
                patient.lastName = newValue
            case .Phone:
                patient.phoneNumber = newValue
            case .Email:
                patient.email = newValue
            default:
                fatalError()
            }
        }
        
        self.navigationController?.popViewController(animated: true)
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
