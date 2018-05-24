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
    var selectedSurveyIndex: Int?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var patient: Patient!
    var server: Server!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        let footerView = UIView()
        self.tableView.tableFooterView = footerView
        self.tableView.backgroundColor = UIColor.groupTableViewBackground
        
        patient = (self.navigationController!.tabBarController! as! MyTabBarController).patient
        server = (self.navigationController!.tabBarController! as! MyTabBarController).server
    }
    
    private func retrieveSurveyStatus() {
        
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
    func performSurvey(forRow row: Int) {
        
        var surveyViewController: SurveyViewController?
        switch row{
        case 0:
            surveyViewController = TobaccoFactory.create(with: "TobaccoSurvey", delegate: self, uploadEndpoint: Server.Endpoints.AccessTobaccoInfo.rawValue)
        case 1:
            surveyViewController = AlcoholFactory.create(with: "AlcoholSurvey", delegate: self, uploadEndpoint: Server.Endpoints.UpdateAlcohol.rawValue)
        case 2:
            surveyViewController = PersonalFactory.create(with: "PersonalSurvey", delegate: self, uploadEndpoint: Server.Endpoints.UpdatePersonal.rawValue)
        case 3:
            surveyViewController = FamilyHistoryFactory.create(with: "FamilyHistorySurvey", delegate: self, uploadEndpoint: Server.Endpoints.UpdateFamily.rawValue)
        case 4:
            surveyViewController = AllergyFactory.create(with: "AllergySurvey", delegate: self, uploadEndpoint: Server.Endpoints.UpdateAllergy.rawValue)
        case 5:
            surveyViewController = MedicationFactory.create(with: "MedicationSurvey", delegate: self, uploadEndpoint: Server.Endpoints.UpdateMedication.rawValue)
        case 6:
            surveyViewController = MedicalConditionFactory.create(with: "MedicalConditionSurvey", delegate: self, uploadEndpoint: Server.Endpoints.UpdateMedicationCondition.rawValue)
        case 7:
            surveyViewController = SurgeryFactory.create(with: "SurgerySurvey", delegate: self, uploadEndpoint: Server.Endpoints.UpdateSurgery.rawValue)
        case 8:
            surveyViewController = GynecologyFactory.create(with: "GynecologySurvey", delegate: self, uploadEndpoint: Server.Endpoints.UpdateGynecology.rawValue)
        default:
            fatalError()
        }
    
        present(surveyViewController!, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            selectedSurveyIndex = indexPath.row
            performSurvey(forRow: selectedSurveyIndex!)
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showDetailInfo":
            let destination = segue.destination as! DetailProfileTableViewController
            
            destination.patient = self.patient
            destination.server = server
        default:
            fatalError()
        }
    }
}
