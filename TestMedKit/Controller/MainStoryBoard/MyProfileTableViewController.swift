//
//  MeTableViewController.swift
//  TestMedKit
//
//  Created by Student on 2018-02-20.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import ResearchKit

class MyProfileTableViewController: UITableViewController {
    var patient: Patient!
    var server: Server!
    var selectedSurveyIndex: Int? = nil
    
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
        super.viewWillAppear(animated)
        
        nameLabel.text = patient.basicInfo.fullName
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
    func performSurvey(forRow row: Int){
        var id: String = ""
        
        var surveyViewController: SurveyViewController?
        switch row{
        case 0:
            id = "TobaccoSurvey"
            surveyViewController = TobaccoFactory.create(with: id, delegate: self, uploadEndpoint: Endpoints.updateTobacco.rawValue)
        case 1:
            id = "AlcoholSurvey"
            surveyViewController = AlcoholFactory.create(with: id, delegate: self, uploadEndpoint: Endpoints.updateAlcohol.rawValue)
        case 2:
            id = "PersonalSurvey"
            surveyViewController = PersonalFactory.create(with: id, delegate: self, uploadEndpoint: Endpoints.updatePersonal.rawValue)
        case 3:
            id = "FamilyHistorySurvey"
            surveyViewController = FamilyHistoryFactory.create(with: id, delegate: self, uploadEndpoint: Endpoints.updateFamily.rawValue)
        case 4:
            id = "AllergySurvey"
            surveyViewController = AllergyFactory.create(with: id, delegate: self, uploadEndpoint: Endpoints.updateAllergy.rawValue)
        case 5:
            id = "MedicationSurvey"
            surveyViewController = MedicationFactory.create(with: id, delegate: self, uploadEndpoint: Endpoints.updateMedication.rawValue)
        case 6:
            id = "MedicalConditionSurvey"
            surveyViewController = MedicalConditionFactory.create(with: id, delegate: self, uploadEndpoint: Endpoints.updateMedicationCondition.rawValue)
        case 7:
            id = "SurgerySurvey"
            surveyViewController = SurgeryFactory.create(with: id, delegate: self, uploadEndpoint: Endpoints.updateSurgery.rawValue)
        case 8:
            id = "GynecologySurvey"
            surveyViewController = GynecologyFactory.create(with: id, delegate: self, uploadEndpoint: Endpoints.updateGynecology.rawValue)
        default:
            fatalError()
        }
        
        if surveyViewController != nil {
            present(surveyViewController!, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            performSurvey(forRow: indexPath.row)
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
        guard let segueID = segue.identifier, segueID == "showDetailInfo" else { fatalError() }
        
        guard let destination = segue.destination as? DetailProfileTableViewController else { fatalError() }
        
        destination.patient = self.patient
        destination.server = server
    }
}
