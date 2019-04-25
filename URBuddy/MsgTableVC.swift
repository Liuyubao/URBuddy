//
//  MsgTableVC.swift
//  URBuddy
//
//  Created by Liuyubao on 4/24/19.
//  Copyright © 2019 xinghaiwulian. All rights reserved.
//

import UIKit

class MsgTableVC: UITableViewController {
    
    let tempMsgArray = [
        ["userName":"Yubao Liu","age":"22","major":"Computer Science", "msg": "I also have data mining this semester. Are you interested in completing the course project together?"],
        ["userName":"Xue Li","age":"22","major":"Computer Science", "msg": "I also have data mining this semester. Are you interested in completing the course project together?"],
        ["userName":"Sining Qu","age":"22","major":"Computer Science", "msg": "I also have data mining this semester. Are you interested in completing the course project together?"]
        
    ]


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.tempMsgArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MsgTableCell", for: indexPath) as! MsgTableCell
        cell.userNameL.text = self.tempMsgArray[indexPath.row]["userName"]
        cell.ageL.text = self.tempMsgArray[indexPath.row]["age"]
        cell.majorL.text = self.tempMsgArray[indexPath.row]["major"]
        cell.msgTV.text = self.tempMsgArray[indexPath.row]["msg"]

        // Configure the cell...

        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
