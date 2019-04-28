//
//  URBMassageModel.swift
//  URBuddy
//
//  Created by Liuyubao on 4/28/19.
//  Copyright © 2019 xinghaiwulian. All rights reserved.
//

import Foundation

class URBMassageModel: NSObject{
    var massageId:String = ""
    var fromUser:URBUserModel = URBUserModel()
    var toUser:URBUserModel = URBUserModel()
    var sendTime:String = ""
    var content:String = ""
    
    
    
    func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["fromUser":URBUserModel.self, "toUser":URBUserModel.self] // [JZMJewelryCategoryModel class]
    }
}
