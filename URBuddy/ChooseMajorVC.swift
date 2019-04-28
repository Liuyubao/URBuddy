//
//  ChooseMajorVC.swift
//  URBuddy
//
//  Created by Liuyubao on 4/24/19.
//  Copyright © 2019 xinghaiwulian. All rights reserved.
//

import UIKit
import DropDown

class ChooseMajorVC: UIViewController, URBNetworkDelegate {
    @IBOutlet weak var chooseMajorBtn: UIButton!
    @IBOutlet weak var telephoneTF: UITextField!
    @IBOutlet weak var pswTF: UITextField!
    
    let chooseMajorDD = DropDown()
    //configure chooseMajor drop down
    func setupChooseMajorDD() {
        chooseMajorDD.anchorView = chooseMajorBtn
        
        chooseMajorDD.bottomOffset = CGPoint(x: 0, y: chooseMajorDD.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        var majorsArray = [String]()
        for m in UserDefaults.standard.array(forKey: "majors")!{
            let mDic = m as! NSDictionary
            majorsArray.append(mDic["major_name"] as! String)
        }
        chooseMajorDD.dataSource = majorsArray
        
        // Action triggered on selection
        chooseMajorDD.selectionAction = { [unowned self] (index, item) in
            self.chooseMajorBtn.setTitle(item, for: .normal)
        }
        
    }
    @IBAction func chooseMajorBtnClicked(_ sender: UIButton) {
        chooseMajorDD.show()
    }
    
    // next step
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        var params = [String: String]()
        params["telephone"] = self.telephoneTF.text!
        
        if Validation.phoneNum(telephoneTF.text!).isRight{
            URBNetwork.sharedManager().postCheckTelephone(params as NSDictionary, self)
        }else{
            "Your input telephone number format is wrong".ext_debugPrintAndHint()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChooseMajorDD()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //点击其他地方  收回键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //next step
    func onNextBtnCLicked(_ response:[String : AnyObject]){
        if response["state"] as! Bool == true{
            let regTelephone = self.telephoneTF.text
            let regMajor = self.chooseMajorBtn.currentTitle
            let regPsw = self.pswTF.text
            UserDefaults.standard.set(regTelephone, forKey: "regTelephone")
            UserDefaults.standard.set(regMajor, forKey: "regMajor")
            UserDefaults.standard.set(regPsw, forKey: "regPsw")

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HeadIconVC") as! HeadIconVC
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
            ("next step").ext_debugPrintAndHint()
            
            
        }else{
            (response["message"] as! String).ext_debugPrintAndHint()
        }
    }
    
    
    
    
    func requestSuccess(_ requestKey: NSInteger, _ response: [String : AnyObject]) {
        switch requestKey {
        case URBRequestKeyID.URB_CHECKTELEPHONE.rawValue:
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
