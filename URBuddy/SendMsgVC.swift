//
//  SendMsgVC.swift
//  URBuddy
//
//  Created by Liuyubao on 4/24/19.
//  Copyright © 2019 xinghaiwulian. All rights reserved.
//

import UIKit

class SendMsgVC: UIViewController, URBNetworkDelegate {
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var sendToTF: UITextField!
    @IBOutlet weak var sendContentTV: UITextView!
    
    
    
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnClicked(_ sender: UIButton) {
        let toTelephone = UserDefaults.standard.string(forKey: "toTelephone")
        let fromTelephone = UserDefaults.standard.dictionary(forKey: "result")!["telephone"] as! String
        let msg = "To " + sendToTF.text! + ": " + sendContentTV.text!
        var params = [String: String]()
        
        params["from_telephone"] = fromTelephone
        params["to_telephone"] = toTelephone
        params["msg"] = msg
        print("paras", params)
        URBNetwork.sharedManager().postSend(params as NSDictionary, self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.sendToTF.text = UserDefaults.standard.string(forKey: "toName")
        self.sendToTF.allowsEditingTextAttributes = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    //发送信息返回参数处理
    func onSendBtnCLicked(_ response:[String : AnyObject]){
        if response["state"] as! Bool == true{
            let result = response["result"] as! NSDictionary
            // save messages to the Userdefaults
            let messages = result["messages"] as! NSArray
            UserDefaults.standard.set(messages, forKey: "messages")
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyMsgVC") as! MyMsgVC
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
            ("Successfully send message").ext_debugPrintAndHint()
     
        }else{
            (response["message"] as! String).ext_debugPrintAndHint()
        }
    }
    
    func requestSuccess(_ requestKey: NSInteger, _ response: [String : AnyObject]) {
        switch requestKey {
        case URBRequestKeyID.URB_SENDMSG.rawValue:
            onSendBtnCLicked(response)
            break
        default:
            break
        }
    }
    
    func requestFail(_ requestKey: NSInteger, _ error: NSError) {
        "something wrong".ext_debugPrintAndHint()
    }

}
