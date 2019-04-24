//
//  SendMsgVC.swift
//  URBuddy
//
//  Created by Liuyubao on 4/24/19.
//  Copyright © 2019 xinghaiwulian. All rights reserved.
//

import UIKit

class SendMsgVC: UIViewController {
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var sendBtn: UIButton!
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnClicked(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
