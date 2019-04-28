//
//  ViewController.swift
//  URBuddy
//
//  Created by Liuyubao on 4/4/19.
//  Copyright © 2019 xinghaiwulian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URBNetworkDelegate {
    
    

    var userNameTF = DKAnimationTextField()
    var pswTF = DKAnimationTextField()
    @IBAction func forgetBtnClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        var params = [String: String]()
        params["email"] = self.userNameTF.textField.text!
        params["password"] = self.pswTF.textField.text!
        
        if Validation.email(userNameTF.textField.text!).isRight{
            URBNetwork.sharedManager().postLogin(params as NSDictionary, self)
        }else{
            "Your input email format is wrong".ext_debugPrintAndHint()
        }
        
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LookingInfoVC")
//        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func registerBtnClicked(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTF = DKAnimationTextField (frame: CGRect(x: UIScreen.main.bounds.width/2 - 150, y: 400, width: 300, height: 40))
        userNameTF.placeHoderColor = UIColor.lightGray
        userNameTF.placeStr = " Please input your email:"
        userNameTF.textField.delegate = self as? UITextFieldDelegate
        userNameTF.textField.keyboardType = .emailAddress
        userNameTF.animationType = DKAnimationType.DKAnimationUp
        
        userNameTF.textColor = UIColor.red
        
        pswTF = DKAnimationTextField (frame: CGRect(x: UIScreen.main.bounds.width/2 - 150, y: 500, width: 300, height: 40))
        pswTF.placeHoderColor = UIColor.lightGray
        pswTF.placeStr = " Please input your password:"
        pswTF.textField.delegate = self as? UITextFieldDelegate
        pswTF.textField.isSecureTextEntry = true
        pswTF.animationType = DKAnimationType.DKAnimationSnake
        
        pswTF.textColor = UIColor.red
        
        self.view.addSubview(userNameTF)
        self.view.addSubview(pswTF)
        
        
    }
    
    //点击其他地方  收回键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //登录返回参数处理
    func onLoginBtnCLicked(_ response:[String : AnyObject]){
        if response["state"] as! Bool == true{
            let result = response["result"] as! NSDictionary
            //获取有用信息保存到沙盒
            UserDefaults.standard.set(result, forKey: "result")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LookingInfoVC") as! HistoryDemoViewController
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
            ("Successfully login").ext_debugPrintAndHint()
            
           
        }else{
            (response["message"] as! String).ext_debugPrintAndHint()
        }
    }


    
    
    func requestSuccess(_ requestKey: NSInteger, _ response: [String : AnyObject]) {
        switch requestKey {
        case URBRequestKeyID.URB_LOGIN.rawValue:
            onLoginBtnCLicked(response)
            break
        default:
            break
        }
    }
    
    func requestFail(_ requestKey: NSInteger, _ error: NSError) {
        "something wrong".ext_debugPrintAndHint()
    }

}

