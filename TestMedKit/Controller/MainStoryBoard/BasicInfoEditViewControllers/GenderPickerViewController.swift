//
//  GenderPickerViewController.swift
//  TestMedKit
//
//  Created by Student on 2018-02-22.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class GenderPickerViewController: BasicInfoEditViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var genderPicker: UIPickerView!
    private let genders = ["Male", "Female", "Unspecified"]
    
    private var genderSelected: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.genderPicker.dataSource = self
        self.genderPicker.delegate = self
        
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneButtonAction(_:)))
        self.navigationItem.rightBarButtonItem = doneBarButton
        genderSelected = genders.first
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        genderSelected = genders[row]
    }
    
    override func getNewBasicInfo() -> BasicInfo? {
        var newBasicInfo = patient.basicInfo
        newBasicInfo.gender = genderSelected
        
        return newBasicInfo
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
