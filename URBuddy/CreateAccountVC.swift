//
//  CreateAccountVC.swift
//  URBuddy
//
//  Created by Liuyubao on 4/24/19.
//  Copyright © 2019 xinghaiwulian. All rights reserved.
//

import UIKit
import DropDown

class CreateAccountVC: UIViewController {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var genderBtn: UIButton!
    let genderDD = DropDown()
    //configure sex drop down
    func setupSexDropDown() {
        genderDD.anchorView = genderBtn
        
        genderDD.bottomOffset = CGPoint(x: 0, y: genderBtn.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        genderDD.dataSource = [
            "Male",
            "Female",
            "Secret"
        ]
        
        // Action triggered on selection
        genderDD.selectionAction = { [unowned self] (index, item) in
            self.genderBtn.setTitle(item, for: .normal)
        }
        
    }
    @IBAction func genderBtnClicked(_ sender: UIButton) {
        genderDD.show()
    }
    
    @IBOutlet weak var birthBtn: UIButton!
    @IBAction func birthBtnClicked(_ sender: UIButton) {
        let calendarView: ZHFCalendarView = ZHFCalendarView()
        calendarView.pointColor = ZHFColor.zhf_color(withHex: 0x42D2BE)//size and color
        calendarView.bigGreenPoints = [5,10] //Big points
        calendarView.smallGreenPoints = [3,7,8,25] //small points
        calendarView.addAnimate()
        
        calendarView.clickValueClosure { (text) in
            self.birthBtn.setTitle(text, for: .normal)
        }
    }
    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSexDropDown()

        // Do any additional setup after loading the view.
    }
    
    //点击其他地方  收回键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
