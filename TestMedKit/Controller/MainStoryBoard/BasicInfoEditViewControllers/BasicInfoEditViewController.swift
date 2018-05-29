//
//  BasicInfoEditViewController.swift
//  TestMedKit
//
//  Created by Student on 2018-04-30.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class BasicInfoEditViewController: UIViewController {
    var patient: Patient!
    var server: Server!
    var editingField: String!
    
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneButtonAction(_:)))
        self.navigationItem.rightBarButtonItem = doneBarButton
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
    
    @objc func doneButtonAction(_ sender: UIBarButtonItem){
        
        let newBasicInfo = getNewBasicInfo()
        
        updateBasicInfo(newBasicInfo)
    }

    func getNewBasicInfo() -> BasicInfo? {
        return nil
    }
    
    func updateBasicInfo(_ newBasicInfo: BasicInfo?) {
        updateStart()
        
        if newBasicInfo == nil {
            navigationController?.popViewController(animated: true)
            return
        }
        
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(newBasicInfo)
        
        //self doesn't maintain a pointer to this closure but self may be unloaded from the memory by clicking "Back"
        server.asyncSendJsonData(endpoint: Server.Endpoints.BasicInfo.rawValue, jsonData: jsonData) { [weak self] _, response, error in
            do {
                if error != nil {
                    throw error!
                }
            
                guard let response = response as? HTTPURLResponse else {
                    throw Server.Errors.invalidResponse
                }
                
                if response.statusCode != 200 {
                    throw Server.Errors.errorCode(response.statusCode)
                }
                
                DispatchQueue.main.async {
                    self?.navigationController?.popViewController(animated: true)
                    self?.patient.basicInfo = newBasicInfo!
                }
                
            } catch let e {
                let alertController = UIAlertController(title: "Oops", message: e.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                DispatchQueue.main.async {
                    self?.present(alertController, animated: true, completion: nil)
                    self?.updateComplete()
                }
                
                return
            }
        }
    }
    
    func updateStart() {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.coverView.alpha = 0.5
        }, completion: nil)
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        activityIndicator.startAnimating()
    }
    
    func updateComplete() {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.coverView.alpha = 0
        }, completion: nil)
        
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        activityIndicator.stopAnimating()
    }
}
