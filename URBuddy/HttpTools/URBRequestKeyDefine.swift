//
//  URBRequestKeyDefine.swift
//  URBuddy
//
//  Created by Liuyubao on 4/27/19.
//  Copyright © 2019 xinghaiwulian. All rights reserved.
//

import Foundation
import UIKit

enum URBRequestKeyID: NSInteger{
    case URB_NONE = 0
    case URB_REGISTER
    case URB_LOGIN
    case URB_SENDMSG
    case URB_SEARCHMSG
    case URB_GETVERICODE
    case URB_CHECKVERICODE
    case URB_UPDATEPSW
    case URB_CHECKEMAIL
    case URB_CHECKTELEPHONE
    case URB_DELETEMSG
    case URB_GETIMGURL
}

class URBRequestKeyDefine: NSObject{
    
    var trandIdDict:NSDictionary!
    
    // 单例
    class var shared: URBRequestKeyDefine {
        struct Static {
            static let instance = URBRequestKeyDefine()
        }
        return Static.instance
    }
    
    override init() {
        super.init()
        initWebServiceDomain()
    }
    
    func initWebServiceDomain() {
        self.trandIdDict = [
            URBRequestKeyID.URB_NONE: "",
            URBRequestKeyID.URB_REGISTER: "/user/register",
            URBRequestKeyID.URB_LOGIN: "/user/login",
            URBRequestKeyID.URB_SENDMSG: "/msg/send",
            URBRequestKeyID.URB_SEARCHMSG: "/msg/search",
            URBRequestKeyID.URB_GETVERICODE: "/msg/veri_code",
            URBRequestKeyID.URB_CHECKVERICODE: "/msg/check_veri_code",
            URBRequestKeyID.URB_UPDATEPSW: "/msg/update_psw",
            URBRequestKeyID.URB_CHECKEMAIL: "/user/check_email",
            URBRequestKeyID.URB_CHECKTELEPHONE: "/user/check_telephone",
            URBRequestKeyID.URB_DELETEMSG: "/msg/delete",
            URBRequestKeyID.URB_GETIMGURL: "https://sm.ms/api/upload"
        ]
    }
}
