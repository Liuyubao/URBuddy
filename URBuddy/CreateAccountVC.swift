//
//  CreateAccountVC.swift
//  URBuddy
//
//  Created by Liuyubao on 4/24/19.
//  Copyright © 2019 xinghaiwulian. All rights reserved.
//

import UIKit
import DropDown

class CreateAccountVC: UIViewController, URBNetworkDelegate {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var genderBtn: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    let genderNumDict = [
        "Male": 0,
        "Female": 1,
        "Secret": 2
    ]
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
    
    // next step
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        var params = [String: String]()
        params["email"] = self.emailTF.text!
        
        if Validation.email(emailTF.text!).isRight{
            URBNetwork.sharedManager().postCheckEmail(params as NSDictionary, self)
        }else{
            "Your input email format is wrong".ext_debugPrintAndHint()
        }
    }
    
    @IBOutlet weak var birthBtn: UIButton!
    @IBAction func birthBtnClicked(_ sender: UIButton) {
        self.view.endEditing(true)
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
    
    //登录返回参数处理
    func onNextBtnCLicked(_ response:[String : AnyObject]){
        if response["state"] as! Bool == true{
            // save register params to UserDefaults
            UserDefaults.standard.set(self.emailTF.text, forKey: "regEmail")
            UserDefaults.standard.set(self.nameTF.text, forKey: "regName")
            let genderNum = self.genderNumDict[self.genderBtn.currentTitle!]
            UserDefaults.standard.set(genderNum, forKey: "regGender")
            UserDefaults.standard.set(self.birthBtn.currentTitle, forKey: "regBirthday")
            
            
            
            let result = response["result"] as! NSDictionary
            let majors = result["majors"] as! NSArray
            UserDefaults.standard.set(majors, forKey: "majors")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChooseMajorVC") as! ChooseMajorVC
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
            ("next step").ext_debugPrintAndHint()
            
            
        }else{
            (response["message"] as! String).ext_debugPrintAndHint()
        }
    }
    
    func requestSuccess(_ requestKey: NSInteger, _ response: [String : AnyObject]) {
        switch requestKey {
        case URBRequestKeyID.URB_CHECKEMAIL.rawValue:
            onNextBtnCLicked(response)
            break
        default:
            break
        }
    }
    
    func requestFail(_ requestKey: NSInteger, _ error: NSError) {
        "something wrong".ext_debugPrintAndHint()
    }
    

}
