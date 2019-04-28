//
//  URBuddyNetwork.swift
//  URBuddy
//
//  Created by Liuyubao on 4/27/19.
//  Copyright © 2019 xinghaiwulian. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

// create a protocol
@objc protocol URBNetworkDelegate:NSObjectProtocol {
    
    @objc func requestSuccess(_ requestKey:NSInteger, _ response:[String : AnyObject])
    @objc func requestFail(_ requestKey:NSInteger, _ error:NSError)
    @objc optional func requestCancel(_ requestKey:NSInteger)
    @objc optional func requestError(_ requestKey:NSInteger, _ message:String)
    //请求成功返回错误字段为  Type = E
    @objc optional func requestSuccessWithTypeE(_ requestKey:NSInteger)
}

class URBNetwork: NSObject, URBHttpToolDelegate {
    weak var delegate:URBNetworkDelegate?
    
    // 单例
    static func sharedManager() -> URBNetwork {
        return URBNetwork()
    }
    
    func superWithLoadData(_ parameters:Any, _ requestKey:URBRequestKeyID, _ method:HTTPMethod) {
        changeStatus({ (isReach) in
            if isReach == false {
                "网络不可用".ext_debugPrintAndHint()
            } else {
                let request = URBHttpTool()
                request.initWithKey(requestKey, self)
                request.validTime = 1200
                if method == .get {
                    request.getHttpTool(parameters as! NSArray)
                } else {
                    request.postHttpTool(parameters as! Parameters)
                }
            }
        })
    }
    
    func superWithUploadImage(_ requestKey:URBRequestKeyID, _ data:[Data]) {
        changeStatus({ (isReach) in
            //            XHMLProgressHUD.shared.show()
            if isReach == false {
                "网络不可用".ext_debugPrintAndHint()
            } else {
                let request = URBHttpTool()
                request.initWithKey(requestKey, self)
                request.uploadHttpTool(data)
            }
        })
        
    }
    
    
    // 1.register
    func postRegister(_ parameters:NSDictionary, _ delegate:URBNetworkDelegate){
        //        user_name     string     是
        //        gender     int     是
        //        birthday     date     是
        //        passcode     string     是
        //        major     string     是
        //        email     string     是
        //        looking_for     string     是
        //        photo     string     是
        //        telephone     string     是

        self.delegate = delegate
        superWithLoadData(parameters, .URB_REGISTER, .post)
    }
    
    // 2.login
    func postLogin(_ parameters:NSDictionary, _ delegate:URBNetworkDelegate){
        //        email     string     是
        //        password     string     是
        
        self.delegate = delegate
        superWithLoadData(parameters, .URB_LOGIN, .post)
    }
    
    // 3.send
    func postSend(_ parameters:NSDictionary, _ delegate:URBNetworkDelegate){
        //        from_telephone     string     是
        //        to_telephone     string     是
        //        msg     date     是
        self.delegate = delegate
        superWithLoadData(parameters, .URB_SENDMSG, .post)
    }
    
    // 4.search
    func postSearch(_ parameters:NSDictionary, _ delegate:URBNetworkDelegate){
        //        telephone     string     是
        //        infos     int     是
        self.delegate = delegate
        superWithLoadData(parameters, .URB_SEARCHMSG, .post)
    }
    
    // 5.veri_code
    func postVeriCode(_ parameters:NSDictionary, _ delegate:URBNetworkDelegate){
        //        telephone     string     是
        self.delegate = delegate
        superWithLoadData(parameters, .URB_GETVERICODE, .post)
    }
    
    // 6.check_veri_code
    func postCheckVeriCode(_ parameters:NSDictionary, _ delegate:URBNetworkDelegate){
        //        telephone     string     是
        //        veri_code     string     是
        self.delegate = delegate
        superWithLoadData(parameters, .URB_CHECKVERICODE, .post)
    }
    
    // 7.update_psw
    func postUpdatePsw(_ parameters:NSDictionary, _ delegate:URBNetworkDelegate){
        //        telephone     string     是
        //        new_psw     string     是
        self.delegate = delegate
        superWithLoadData(parameters, .URB_UPDATEPSW, .post)
    }
    
    // 8.check_email
    func postCheckEmail(_ parameters:NSDictionary, _ delegate:URBNetworkDelegate){
        //        email     string     是
        self.delegate = delegate
        superWithLoadData(parameters, .URB_CHECKEMAIL, .post)
    }
    
    // 9.check_telephone
    func postCheckTelephone(_ parameters:NSDictionary, _ delegate:URBNetworkDelegate){
        //        email     string     是
        self.delegate = delegate
        superWithLoadData(parameters, .URB_CHECKTELEPHONE, .post)
    }
    
    // 10.delete_msg
    func postDeleteMsg(_ parameters:NSDictionary, _ delegate:URBNetworkDelegate){
        //        message_id     string     是
        self.delegate = delegate
        superWithLoadData(parameters, .URB_DELETEMSG, .post)
    }
    
    // 11.upload image and get corresponding url
    func uploadImg( _ imageData:[Data], _ delegate:URBNetworkDelegate) {
        //data  data    头像数据
        self.delegate = delegate
        superWithUploadImage(.URB_GETIMGURL, imageData)
        
    }
    
    
    
    
    // MARK: - URBHttpToolDelegate
    func requestSuccess(_ requestKey:NSInteger, result request:Any) {
        self.delegate?.requestSuccess(requestKey, request as! [String : AnyObject])
    }
    
    func requestFail(_ requestKey:NSInteger, _ error:NSError) {
        self.delegate?.requestFail(requestKey, error)
    }
    
    func changeStatus(_ block:@escaping ((Bool)->())) {
        let networkManager:NetworkReachabilityManager = NetworkReachabilityManager(host: "www.baidu.com")!
        // 开始监听
        networkManager.startListening()
        // 检测网络连接状态
        if networkManager.isReachable {
            print("网络连接：可用")
        } else {
            "网络不可用".ext_debugPrintAndHint()
            print("网络连接：不可用")
        }
        
        // 检测网络类型
        networkManager.listener = { status in
            switch status {
            case .notReachable:
                print("无网络连接")
                block(false)
                break
            case .unknown:
                print("未知网络")
                block(false)
                break
            case .reachable(.ethernetOrWiFi):
                print("WIFI")
                block(true)
                break
            case .reachable(.wwan):
                print("手机自带网络")
                block(true)
                break
            }
        }
    }
    
    
    
    
}



