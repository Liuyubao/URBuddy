//
//  MsgTableVC.swift
//  URBuddy
//
//  Created by Liuyubao on 4/24/19.
//  Copyright © 2019 xinghaiwulian. All rights reserved.
//

import UIKit

class MsgTableVC: UITableViewController, URBNetworkDelegate, UISearchBarDelegate {
    var messages = [[String: Any]]()
    var msgResult = [[String: Any]]()
//    var messages = [
//        ["name":    "Yubao Liu",
//         "age":         "22",
//         "major":       "Computer Science",
//         "time":        "2019-04-17 13:20:20",
//         "photo_url":   "https://media.licdn.com/dms/image/C4D03AQGL-yK6zQRpNQ/profile-displayphoto-shrink_800_800/0?e=1559779200&v=beta&t=tZ8iglw9X5WPq0Pc2618qnBpboV3W8cMmHaKqFgeFbU",
//         "msg":         "I also have data mining this semester. Are you interested in completing the course project together?"
//        ]
//
//    ]
    @IBOutlet weak var searchBar: UISearchBar!
    
    let tempMsgArray = [
        ["userName":"Yubao Liu","age":"22","major":"Computer Science", "msg": "I also have data mining this semester. Are you interested in completing the course project together?"],
        ["userName":"Xue Li","age":"22","major":"Computer Science", "msg": "I also have data mining this semester. Are you interested in completing the course project together?"],
        ["userName":"Sining Qu","age":"22","major":"Computer Science", "msg": "I also have data mining this semester. Are you interested in completing the course project together?"]
        
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.messages = UserDefaults.standard.array(forKey: "messages") as! [[String : Any]]
        self.msgResult = self.messages
        self.searchBar.delegate = self
        self.searchBar.placeholder = "search messages"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    // MARK: - Searchbar delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 沒有搜索內容時顯示全部內容
        if searchText == "" {
            self.msgResult = self.messages
        } else {
            
            // 匹配用戶輸入的前綴，不區分大小寫
            self.msgResult = []
            
            for msg in self.messages {
                
                if (msg["msg"] as! String).lowercased().contains(searchText.lowercased()){
                    self.msgResult.append(msg)
                }
            }
        }
        
        // 刷新tableView 數據顯示
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("search history")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.msgResult = self.messages
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.msgResult.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MsgTableCell", for: indexPath) as! MsgTableCell
        cell.messageID = "\(self.msgResult[indexPath.row]["message_id"] as! Int)"
        cell.telephone = self.msgResult[indexPath.row]["telephone"]! as! String
        cell.replyBtn.tag = indexPath.row
        cell.replyBtn.addTarget(self, action: #selector(replyBtnClicked), for: .touchUpInside)
        cell.userNameL.text = self.msgResult[indexPath.row]["name"] as! String
        cell.ageL.text = "\(self.msgResult[indexPath.row]["age"] as! Int)"
        cell.majorL.text = self.msgResult[indexPath.row]["major"] as! String
        cell.msgTV.text = self.msgResult[indexPath.row]["msg"] as! String
        cell.sendTimeL.text = self.msgResult[indexPath.row]["time"] as! String
        
        let photoUrlString = self.msgResult[indexPath.row]["photo_url"] as! String
        var photoUrl : NSURL = NSURL(string: photoUrlString)!
        var photoData : NSData = NSData(contentsOf:photoUrl as URL)!
        var photoImage = UIImage(data:photoData as Data, scale: 1.0)
        cell.headIconIV.image = photoImage
        
        let myTelephone = UserDefaults.standard.dictionary(forKey: "result")!["telephone"] as! String
        if myTelephone == self.msgResult[indexPath.row]["telephone"]! as! String{
            "mytelephone:\(myTelephone)".ext_debugPrintAndHint()
            "celltelephone:\(cell.telephone)".ext_debugPrintAndHint()
            cell.replyBtn.isEnabled = false
        }
        cell.msgTV.allowsEditingTextAttributes = false

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            
            
            
            var params = [String: String]()
            params["message_id"] = "\(self.msgResult[indexPath.row]["message_id"] as! Int)"
            "message_id: \(params["message_id"])".ext_debugPrintAndHint()
            URBNetwork.sharedManager().postDeleteMsg(params as NSDictionary, self)
            self.messages.remove(at: indexPath.row)
            self.msgResult.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    
    //点击其他地方  收回键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func replyBtnClicked(sender: UIButton?){
        let tag = sender?.tag
        let toName = self.msgResult[tag!]["name"] as! String
        let toTelephone = self.msgResult[tag!]["telephone"] as! String
        UserDefaults.standard.setValue(toTelephone, forKey: "toTelephone")
        UserDefaults.standard.setValue(toName, forKey: "toName")
//        toName.ext_debugPrintAndHint()
//        toTelephone.ext_debugPrintAndHint()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SendMsgVC") as! SendMsgVC
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    func requestSuccess(_ requestKey: NSInteger, _ response: [String : AnyObject]) {
        switch requestKey {
        case URBRequestKeyID.URB_DELETEMSG.rawValue:
//            self.tableView.reloadData()
            break
        default:
            break
        }
    }
    
    func requestFail(_ requestKey: NSInteger, _ error: NSError) {
        "something wrong".ext_debugPrintAndHint()
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
