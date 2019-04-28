//
//  URUserModel.swift
//  URBuddy
//
//  Created by Liuyubao on 4/27/19.
//  Copyright © 2019 xinghaiwulian. All rights reserved.
//

import Foundation

class URBUserModel: NSObject{
    var userId:String = ""
    var userName:String = ""
    var gender:String = ""
    var birthday:String = ""
    var passcode:String = ""
    var major:URBMajorModel = URBMajorModel()
    var role:URBRoleModel = URBRoleModel()
    var email:String = ""
    var telephone:String = ""
    var veriCode:String = ""
    var lookingFor:String = ""
    var photo:String = ""
    var loginCount = ""

    
    
    func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["major":URBMajorModel.self, "role":URBRoleModel.self] // [JZMJewelryCategoryModel class]
    }
}
