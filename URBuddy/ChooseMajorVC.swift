//
//  ChooseMajorVC.swift
//  URBuddy
//
//  Created by Liuyubao on 4/24/19.
//  Copyright © 2019 xinghaiwulian. All rights reserved.
//

import UIKit
import DropDown

class ChooseMajorVC: UIViewController {
    @IBOutlet weak var chooseMajorBtn: UIButton!
    let chooseMajorDD = DropDown()
    //configure chooseMajor drop down
    func setupChooseMajorDD() {
        chooseMajorDD.anchorView = chooseMajorBtn
        
        chooseMajorDD.bottomOffset = CGPoint(x: 0, y: chooseMajorDD.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        chooseMajorDD.dataSource = [
            "Computer Science",
            "Economics",
            "Accounting",
            "Electronic Computer Engineering",
            "Chemicals",
            "Education"
        ]
        
        // Action triggered on selection
        chooseMajorDD.selectionAction = { [unowned self] (index, item) in
            self.chooseMajorBtn.setTitle(item, for: .normal)
        }
        
    }
    @IBAction func chooseMajorBtnClicked(_ sender: UIButton) {
        chooseMajorDD.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChooseMajorDD()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
