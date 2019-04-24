//
//  ViewController.swift
//  URBuddy
//
//  Created by Liuyubao on 4/4/19.
//  Copyright © 2019 xinghaiwulian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var userNameTF = DKAnimationTextField()
    var pswTF = DKAnimationTextField()

    @IBAction func loginBtnClicked(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LookingInfoVC")
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func registerBtnClicked(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTF = DKAnimationTextField (frame: CGRect(x: UIScreen.main.bounds.width/2 - 150, y: 400, width: 300, height: 40))
        userNameTF.placeHoderColor = UIColor.lightGray
        userNameTF.placeStr = " Please input your email:"
        userNameTF.textField.delegate = self as? UITextFieldDelegate
        userNameTF.animationType = DKAnimationType.DKAnimationUp
        
        userNameTF.textColor = UIColor.red
        
        pswTF = DKAnimationTextField (frame: CGRect(x: UIScreen.main.bounds.width/2 - 150, y: 500, width: 300, height: 40))
        pswTF.placeHoderColor = UIColor.lightGray
        pswTF.placeStr = " Please input your password:"
        pswTF.textField.delegate = self as? UITextFieldDelegate
        pswTF.animationType = DKAnimationType.DKAnimationSnake
        
        pswTF.textColor = UIColor.red
        
        self.view.addSubview(userNameTF)
        self.view.addSubview(pswTF)
        
        
    }
    
    //点击其他地方  收回键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}

