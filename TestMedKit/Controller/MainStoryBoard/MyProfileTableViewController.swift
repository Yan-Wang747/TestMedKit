//
//  MeTableViewController.swift
//  TestMedKit
//
//  Created by Student on 2018-02-20.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import ResearchKit

class MyProfileTableViewController: UITableViewController{
    var task: Task?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var patient: Patient!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        let footerView = UIView()
        self.tableView.tableFooterView = footerView
        self.tableView.backgroundColor = UIColor.groupTableViewBackground
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = patient.basicInfo.fullName
        
        checkTobaccoStatus()
        checkAlcoholStatus()
        checkPersonalStatus()
        checkFamilyStatus()
        checkAllergyStatus()
        checkMedicationStatus()
        checkMedicalConditionStatus()
        checkSurgicalStatus()
        checkGynecologyStatus()
    }
    
    func checkTobaccoStatus() {
        if let isCompleted = patient.tobaccoInfo?.isCompleted {
            if isCompleted {
                if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)){
                    cell.accessoryType = .checkmark
                }
            }
        }
    }
    
    func checkAlcoholStatus() {
        if let isCompleted = patient.alcoholInfo?.isCompleted {
            if isCompleted {
                if let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 1)){
                    cell.accessoryType = .checkmark
                }
            }
        }
    }
    
    func checkPersonalStatus() {
        if let isCompleted = patient.personalInfo?.isCompleted {
            if isCompleted {
                if let cell = tableView.cellForRow(at: IndexPath(row: 2, section: 1)){
                    cell.accessoryType = .checkmark
                }
            }
        }
    }
    
    func checkFamilyStatus() {
        if let isCompleted = patient.familyInfo?.isCompleted {
            if isCompleted {
                if let cell = tableView.cellForRow(at: IndexPath(row: 3, section: 1)){
                    cell.accessoryType = .checkmark
                }
            }
        }
    }
    
    func checkAllergyStatus() {
        if let isCompleted = patient.allergyInfo?.isCompleted {
            if isCompleted {
                if let cell = tableView.cellForRow(at: IndexPath(row: 4, section: 1)){
                    cell.accessoryType = .checkmark
                }
            }
        }
    }
    
    func checkMedicationStatus() {
        if let isCompleted = patient.medicationInfo?.isCompleted {
            if isCompleted {
                if let cell = tableView.cellForRow(at: IndexPath(row: 5, section: 1)){
                    cell.accessoryType = .checkmark
                }
            }
        }
    }
    
    func checkMedicalConditionStatus() {
        if let isCompleted = patient.medicalConditionInfo?.isCompleted {
            if isCompleted {
                if let cell = tableView.cellForRow(at: IndexPath(row: 6, section: 1)){
                    cell.accessoryType = .checkmark
                }
            }
        }
    }
    
    func checkSurgicalStatus() {
        if let isCompleted = patient.surgicalInfo?.isCompleted {
            if isCompleted {
                if let cell = tableView.cellForRow(at: IndexPath(row: 7, section: 1)){
                    cell.accessoryType = .checkmark
                }
            }
        }
    }
    
    func checkGynecologyStatus() {
        if let isCompleted = patient.gynecologyInfo?.isCompleted {
            if isCompleted {
                if let cell = tableView.cellForRow(at: IndexPath(row: 8, section: 1)){
                    cell.accessoryType = .checkmark
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
    }
 */
    func performTask(forRow row: Int){
        switch row{
        case 0:
            task = TobaccoTask(self, patient: patient)
        case 1:
            task = AlcoholTask(self, patient: patient)
        case 2:
            task = PersonalTask(self, patient: patient)
        case 3:
            task = FamilyHistoryTask(self, patient: patient)
        case 4:
            task = AllergyTask(self, patient: patient)
        case 5:
            task = MedicationTask(self, patient: patient)
        case 6:
            task = MedicalConditionTask(self, patient: patient)
        case 7:
            task = SurgicalTask(self, patient: patient)
        case 8:
            task = GynecologyTask(self, patient: patient)
        default:
            task = nil
        }
        
        task?.performTask()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            performTask(forRow: indexPath.row)
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return CGFloat(20)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueID = segue.identifier{
            switch segueID{
            case "showDetailInfo":
                let destination = segue.destination as! DetailProfileTableViewController
                destination.patient = self.patient
            default:
                fatalError("what happened?")
            }
        }
    }
}
