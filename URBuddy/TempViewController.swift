//
//  TempViewController.swift
//  URBuddy
//
//  Created by Liuyubao on 4/5/19.
//  Copyright © 2019 xinghaiwulian. All rights reserved.
//

import UIKit

class TempViewController: UIViewController {
    @IBOutlet weak var cancelBtn: UIButton!
    @IBAction func cancelBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
