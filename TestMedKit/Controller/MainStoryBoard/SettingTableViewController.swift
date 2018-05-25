//
//  MoreTableViewController.swift
//  TestMedKit
//
//  Created by Student on 2018-05-24.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
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
        
        server = (self.navigationController!.tabBarController as! MyTabBarController).server
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                signOut()
            default:
                fatalError()
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func signOut() {
        
        let alertController = UIAlertController(title: "Oops", message: nil, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        server.asyncSignOut() { [weak self] _, response, error in
            do {
                if error != nil{
                    throw error!
                }
                
                guard let response = response as? HTTPURLResponse else {
                    throw Server.Errors.invalidResponse
                }
                
                if response.statusCode != 200 {
                    throw Server.Errors.errorCode(response.statusCode)
                }
            } catch let e {
                alertController.message = e.localizedDescription
                
                DispatchQueue.main.async {
                    self?.present(alertController, animated: true, completion: nil)
                }
                
                return
            }
            
            DispatchQueue.main.async {
                self?.navigationController!.tabBarController!.dismiss(animated: true)
            }
        }
        
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
