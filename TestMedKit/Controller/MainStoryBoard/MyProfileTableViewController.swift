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
    
    @IBOutlet var activityIndicators: [UIActivityIndicatorView]!
    @IBOutlet weak var nameLabel: UILabel!
    
    var patient: Patient!
    var server: Server!
    
    let rowToFactoryDict: [Int: SurveyFactory.Type] = [0: TobaccoFactory.self,
                                                       1: AlcoholFactory.self,
                                                       2: PersonalFactory.self,
                                                       3: FamilyHistoryFactory.self,
                                                       4: AllergyFactory.self,
                                                       5: MedicationFactory.self,
                                                       6: MedicalConditionFactory.self,
                                                       7: SurgeryFactory.self,
                                                       8: GynecologyFactory.self]
    
    var locks: [Bool]! //global survey result lock, is it thread safe?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        let footerView = UIView()
        self.tableView.tableFooterView = footerView
        self.tableView.backgroundColor = UIColor.groupTableViewBackground
        
        locks = [Bool](repeating: false, count: self.tableView.numberOfRows(inSection: 1))
        
        let basicInfo = (self.navigationController!.tabBarController! as! MyTabBarController).basicInfo!
        let surveyResults = [Data?](repeating: nil, count: self.tableView.numberOfRows(inSection: 1))
        
        server = (self.navigationController!.tabBarController! as! MyTabBarController).server
        patient = Patient(basicInfo: basicInfo, surveyResults: surveyResults)
        
        retrieveSurveyStatus()
    }
    
    private func retrieveSurveyStatus() {

        server.maxConnections = self.tableView.numberOfRows(inSection: 1)
            
        patient.surveyResults.enumerated().forEach { index, res in
            
            //check the lock status
            if locks[index] {
                return //don't lock, allows user to perform this survey
            }
            
            activityIndicators[index].startAnimating()
            
            //self doens't maintain a reference to the closure but may be unloaded from the memory
            server.asyncGetJsonData(endpoint: rowToFactoryDict[index]!.getEndpoint()) { [weak self] data, response, error in
                
                guard error == nil, let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    DispatchQueue.main.async {
                        self?.activityIndicators[index].stopAnimating()
                    }
                    
                    return
                }
                
                let indexPath = IndexPath(row: index, section: 1)
                
                guard let isLocked = self?.locks[index], isLocked == false else {
                    DispatchQueue.main.async {
                        self?.activityIndicators[index].stopAnimating()
                    }
                    
                    return //discard the result
                }
                
                self?.patient.surveyResults[index] = data
                
                DispatchQueue.main.async {
                    self?.activityIndicators[index].stopAnimating()
                    
                    let cell = self?.tableView.cellForRow(at: indexPath)
                    cell?.accessoryType = .checkmark
                }
            }
        }
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
        
        let surveyViewController = rowToFactoryDict[row]?.create(delegate: self)
        locks[selectedSurveyIndex!] = true //lock the result to prevent being updated by the retrieveSurveyStatus()
        
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
