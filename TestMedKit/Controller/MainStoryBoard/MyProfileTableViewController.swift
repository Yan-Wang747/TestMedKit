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
    var task: PatientSurvey?
    var patient: Patient!
    var server: Server!
    var surveyToRowNum: [String : Int] = [:]
    
    @IBOutlet weak var nameLabel: UILabel!
    
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
        
        checkStatus()
    }
    
    func checkStatus() {
        
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
            task = TobaccoSurvey(viewController: self, patient: patient, server: server)
        case 1:
            task = AlcoholSurvey(viewController: self, patient: patient, server: server)
        case 2:
            task = PersonalSurvey(viewController: self, patient: patient, server: server)
        case 3:
            task = FamilyHistorySurvey(viewController: self, patient: patient, server: server)
        case 4:
            task = AllergySurvey(viewController: self, patient: patient, server: server)
        case 5:
            task = MedicationSurvey(viewController: self, patient: patient, server: server)
        case 6:
            task = MedicalConditionSurvey(viewController: self, patient: patient, server: server)
        case 7:
            task = SurgicalSurvey(viewController: self, patient: patient, server: server)
        case 8:
            task = GynecologySurvey(viewController: self, patient: patient, server: server)
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
                destination.server = server
            default:
                fatalError("what happened?")
            }
        }
    }
}
