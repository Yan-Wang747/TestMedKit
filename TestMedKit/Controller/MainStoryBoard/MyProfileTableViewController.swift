//
//  MeTableViewController.swift
//  TestMedKit
//
//  Created by Student on 2018-02-20.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import ResearchKit

class MyProfileTableViewController: UITableViewController, ORKTaskViewControllerDelegate{
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        taskViewController.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var nameLabel: UILabel!
    var patient: Patient = Patient(firstName: "Jong-un", lastName: "Kim", gender: "Male", dateOfBirth: "January 8, 1984", phoneNumber: "001-204-123-4567", email: "imyoursun@KWP.nkr")
    
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
        nameLabel.text = patient.firstName + " " + patient.lastName
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
    func appendReviewStep(steps: inout [ORKStep]) {
        let reviewStep = ORKReviewStep(identifier: "reviewStep")
        reviewStep.title = "Answer review"
        steps.append(reviewStep)
        
        for step in steps{
            step.isOptional = false
        }
    }
    
    func createTobaccoSteps() -> [ORKStep]{
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Tobacco history"
        instructionStep.detailText = "This survey helps us understand your tobacco history"
        steps.append(instructionStep)
        
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        let numericAnswer = ORKNumericAnswerFormat(style: .integer, unit: nil, minimum: 1, maximum: nil)
        let dateAnswer = ORKDateAnswerFormat(style: .date)
        
        let tobaccoUseStep = ORKQuestionStep(identifier: "tobaccoUseStep", title: "Do you use tobacco products? This includes cigarettes, pipe, cigars, cigarrillos", answer: booleanAnswer)
        steps.append(tobaccoUseStep)
        
        let everSmokeStep = ORKQuestionStep(identifier: "everSmokeStep", title: "Have you ever smoked", answer: booleanAnswer)
        steps.append(everSmokeStep)
        
        //==============================
        let useCigaretteStep = ORKQuestionStep(identifier: "useCigaretteStep", title: "Using/used cigarette?", answer: booleanAnswer)
        steps.append(useCigaretteStep)
        
        let cigaretteStartDateStep = ORKQuestionStep(identifier: "cigaretteStartDateStep", title: "When did you start cigarette?", answer: dateAnswer)
        steps.append(cigaretteStartDateStep)
        
        let cigaretteNumberStep = ORKQuestionStep(identifier: "cigaretteNumberStep", title: "How many cigarettes per day did you smoke", answer: numericAnswer)
        steps.append(cigaretteNumberStep)
        
        //=========================================================
        let useCigarStep = ORKQuestionStep(identifier: "useCigarStep", title: "Using/used cigar?", answer: booleanAnswer)
        steps.append(useCigarStep)
        
        let cigarStartDateStep = ORKQuestionStep(identifier: "cigarStartDateStep", title: "When did you start cigar?", answer: dateAnswer)
        steps.append(cigarStartDateStep)
        
        let cigarNumberStep = ORKQuestionStep(identifier: "cigarNumberStep", title: "How many cigars per day did you smoke", answer: numericAnswer)
        steps.append(cigarNumberStep)
        
        //=====================================================
        let usePipeStep = ORKQuestionStep(identifier: "usePipeStep", title: "Using/used Pipe?", answer: booleanAnswer)
        steps.append(usePipeStep)
        
        let pipeStartDateStep = ORKQuestionStep(identifier: "pipeStartDateStep", title: "When did you start pipe?", answer: dateAnswer)
        steps.append(pipeStartDateStep)
        
        let pipeNumberStep = ORKQuestionStep(identifier: "pipeNumberStep", title: "How many pipes per day did you smoke", answer: numericAnswer)
        steps.append(pipeNumberStep)
        
        //=====================================================
        appendReviewStep(steps: &steps)
        
        return steps
    }
    
    func createAlcoholSteps() -> [ORKStep]{
        var steps: [ORKStep] = []
        
        let instructionStep = ORKInstructionStep(identifier: "instructionStep")
        instructionStep.title = "Alcohol history"
        instructionStep.detailText = "This survey helps us understand your alcohol history"
        steps.append(instructionStep)
        
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        let numericAnswer = ORKNumericAnswerFormat(style: .integer, unit: "cups", minimum: 1, maximum: nil)
        let hazardChoiceAnswer = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices:
            [ORKTextChoice(text: "Asbestors", value: "Asbestors" as NSString),
             ORKTextChoice(text: "Benzene", value: "Benzene" as NSString),
             ORKTextChoice(text: "Lead", value: "Lead" as NSString),
             ORKTextChoice(text: "Mercury", value: "Mercury" as NSString),
             ORKTextChoice(text: "Radiation", value: "Radiation" as NSString),
             ORKTextChoice(text: "Other Petroleum Products", value: "Other Petroleum Products" as NSString),
             ORKTextChoice(text: "Snuff", value: "Snuff" as NSString),
             ORKTextChoice(text: "Recreational Drug Use", value: "Recreational Drug Use" as NSString),
             ORKTextChoice(text: "Illicit Drug Use", value: "Illicit Drug Use" as NSString)])
        
        let alcoholUseStep = ORKQuestionStep(identifier: "alcoholUseStep", title: "Do you drink alcohol", answer: booleanAnswer)
        steps.append(alcoholUseStep)
        
        let quitStep = ORKQuestionStep(identifier: "quitStep", title: "Did you quit", answer: booleanAnswer)
        steps.append(quitStep)
        
        let alcoholAmountStep = ORKQuestionStep(identifier: "alcoholAmountStep", title: "How many cups a week?", answer: numericAnswer)
        steps.append(alcoholAmountStep)
        
        let hazardExposureStep = ORKQuestionStep(identifier: "hazardExposureStep", title: "Have you been exposed to Hazardous substances", answer: booleanAnswer)
        steps.append(hazardExposureStep)
        
        let hazardSelectStep = ORKQuestionStep(identifier: "hazardSelectStep", title: "Select all that apply", answer: hazardChoiceAnswer)
        steps.append(hazardSelectStep)
        
        appendReviewStep(steps: &steps)
        
        
        
        return steps
    }
    
    func createTobaccoNavigationRule(tobaccoTask: ORKNavigableOrderedTask){
        //========================
        let tobaccoUseStepResult = ORKResultSelector(resultIdentifier: "tobaccoUseStep")
        let predicateYesForTobaccoUseStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: tobaccoUseStepResult, expectedAnswer: true)
        let predicateYesForTobaccoUseStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateYesForTobaccoUseStep, "useCigaretteStep")])
        tobaccoTask.setNavigationRule(predicateYesForTobaccoUseStepRule, forTriggerStepIdentifier: "tobaccoUseStep")
        
        //=======================
        let everSmokeStepResult = ORKResultSelector(resultIdentifier: "everSmokeStep")
        let predicateNoForEverSmokeStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: everSmokeStepResult, expectedAnswer: false)
        let predicateNoForEverSmokeStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForEverSmokeStep, "reviewStep")])
        tobaccoTask.setNavigationRule(predicateNoForEverSmokeStepRule, forTriggerStepIdentifier: "everSmokeStep")
        
        //======================
        let useCigaretteStepResult = ORKResultSelector(resultIdentifier: "useCigaretteStep")
        let predicateNoForUseCigaretteStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: useCigaretteStepResult, expectedAnswer: false)
        let predicateNoForUseCigaretteStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForUseCigaretteStep, "useCigarStep")])
        tobaccoTask.setNavigationRule(predicateNoForUseCigaretteStepRule, forTriggerStepIdentifier: "useCigaretteStep")
        
        //=======================
        let useCigarStepResult = ORKResultSelector(resultIdentifier: "useCigarStep")
        let predicateNoForUseCigarStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: useCigarStepResult, expectedAnswer: false)
        let predicateNoForUseCigarStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForUseCigarStep, "usePipeStep")])
        tobaccoTask.setNavigationRule(predicateNoForUseCigarStepRule, forTriggerStepIdentifier: "useCigarStep")
        
        //===========================
        let usePipeStepResult = ORKResultSelector(resultIdentifier: "usePipeStep")
        let predicateNoForUsePipeStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: usePipeStepResult, expectedAnswer: false)
        let predicateNoForUsePipeStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForUsePipeStep, "reviewStep")])
        tobaccoTask.setNavigationRule(predicateNoForUsePipeStepRule, forTriggerStepIdentifier: "usePipeStep")
    }
    
    func createAlcoholNavigationRule(alcoholTask: ORKNavigableOrderedTask){
        let alcoholUseStepResult = ORKResultSelector(resultIdentifier: "alcoholUseStep")
        let predicateNoForAlcoholUseStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: alcoholUseStepResult, expectedAnswer: false)
        let predicateNoForAlcoholUseStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForAlcoholUseStep, "hazardExposureStep")])
        alcoholTask.setNavigationRule(predicateNoForAlcoholUseStepRule, forTriggerStepIdentifier: "alcoholUseStep")
        
        let hazardExposureStepResult = ORKResultSelector(resultIdentifier: "hazardExposureStep")
        let predicateNoForHazardExposureStep = ORKResultPredicate.predicateForBooleanQuestionResult(with: hazardExposureStepResult, expectedAnswer: false)
        let predicateNoForHazardExposureStepRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicateNoForHazardExposureStep, "reviewStep")])
        alcoholTask.setNavigationRule(predicateNoForHazardExposureStepRule, forTriggerStepIdentifier: "hazardExposureStep")
    }
    
    func createTobaccoTask() -> ORKNavigableOrderedTask{
        let steps = createTobaccoSteps()
        
        let tobaccoTask = ORKNavigableOrderedTask(identifier: "tobaccoTask", steps: steps)
        
        createTobaccoNavigationRule(tobaccoTask: tobaccoTask)
        
        return tobaccoTask
    }
    
    func createAlcoholTask() -> ORKNavigableOrderedTask{
        let steps = createAlcoholSteps()
        
        let alcoholTask = ORKNavigableOrderedTask(identifier: "alcoholTask", steps: steps)
        
        createAlcoholNavigationRule(alcoholTask: alcoholTask)
        
        return alcoholTask
    }
    
    func performTask(forRow row: Int){
        var task: ORKNavigableOrderedTask? = nil
        
        switch row{
        case 0:
            task = createTobaccoTask()
        case 1:
            task = createAlcoholTask()
        default:
            task = nil
        }
        
        let taskViewController = ORKTaskViewController(task: task, taskRun: nil)
        taskViewController.delegate = self
        taskViewController.navigationBar.tintColor = UIColor.darkText
        present(taskViewController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            performTask(forRow: indexPath.row)
        }
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
