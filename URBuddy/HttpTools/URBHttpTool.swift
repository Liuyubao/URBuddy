//
//  URBHttpTool.swift
//  URBuddy
//
//  Created by Liuyubao on 4/27/19.
//  Copyright © 2019 xinghaiwulian. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

let URBHttpURL: String = "http://10.4.7.137:8080"

// create a protocol
@objc protocol URBHttpToolDelegate:NSObjectProtocol {
    
    @objc func requestSuccess(_ requestKey:NSInteger, result request:Any)
    @objc func requestFail(_ requestKey:NSInteger, _ error:NSError)
    @objc optional func requestCancel(_ requestKey:NSInteger)
    
}


class URBHttpTool: NSObject {
    /**
     *  超时时间
     */
    var validTime:NSInteger? = 10 // 默认超时时间为10妙
    var delegate:URBHttpToolDelegate?
    var requestKey:URBRequestKeyID?
    var _isCancelled:Bool = false
    func initWithKey(_ requestKey:URBRequestKeyID, _ delegate:URBHttpToolDelegate) {
        self.requestKey = requestKey
        self.delegate = delegate
    }
    
    // 获取请求的URL
    func requestWithKey() -> String {
        let transId = URBRequestKeyDefine.shared.trandIdDict.object(forKey: self.requestKey ?? 0) as! String
        
        if self.requestKey == URBRequestKeyID.URB_GETIMGURL{
            return transId
        }
        
        if transId.isEmpty {
            return URBHttpURL
        } else {
            return "\(URBHttpURL)\(transId)"
        }
    }
    
    // GET 请求方式
    func getHttpTool(_ parameters: NSArray) {
        let paramStr:String = parameters.componentsJoined(by: "/") as String
        var requestUrl:String = requestWithKey()
        if !paramStr.isEmpty {
            requestUrl = "\(requestUrl)/\(paramStr)"
        }
        print("requestUrl = \(requestUrl) \n")
        Alamofire.request(requestUrl, method: .get, parameters: [:], encoding: URLEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("success:\(value)")
                    let errorCode = (value as! NSDictionary)["errorCode"] as! Int
                    switch errorCode{
                    case 200:
                        self.delegate?.requestSuccess(self.requestKey!.rawValue, result:value as! [String : AnyObject])
                        break
                    case 201:
                        "系统异常，操作失败".ext_debugPrintAndHint()
                        break
                    case -1,-2,-3:
                        if ((value as! NSDictionary).object(forKey: "message") != nil) {
                            ((value as! NSDictionary)["message"] as! String).ext_debugPrintAndHint()
                        }
                        break
                    default:
                        break
                    }
                case .failure(let error):
                    print("error:\(error)")
                    "请求失败！".ext_debugPrintAndHint()
                    self.delegate?.requestFail(self.requestKey!.rawValue, error as NSError)
                }
        }
    }
    
    // POST 请求方式
    func postHttpTool(_ parameters: Parameters) {
        
        let requestUrl:String = requestWithKey()
        print("requestUrl = \(requestUrl) \n param = \(parameters)")
        
        Alamofire.request(requestUrl, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .responseJSON { response in
                //XHMLProgressHUD.shared.hide()
                //当请求后response是我们自定义的，这个变量用于接受服务器响应的信息
                //使用switch判断请求是否成功，也就是response的result
                switch response.result {
                case .success(let value):
                    print("success:\(value)")
                    let errorCode = (value as! NSDictionary)["errorCode"] as! Int
                    switch errorCode{
                    case 201:
                        "系统异常，操作失败".ext_debugPrintAndHint()
                        break
                    default:
                        self.delegate?.requestSuccess(self.requestKey!.rawValue, result:value as! [String : AnyObject])
                        break
                    }
                case .failure(let error):
                    print("error:\(error)")
                    
                    "请求失败！".ext_debugPrintAndHint()
                    self.delegate?.requestFail(self.requestKey!.rawValue, error as NSError)
                }
        }
    }
    
    // 上传头像
    func uploadHttpTool(_ data: [Data]){
        
        let headers = ["content-type":"multipart/form-data"]
        let requestUrl:String = requestWithKey()
        print("requestUrl = \(requestUrl) \n")
        
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for i in 0..<data.count { // "image.png"  "appPhoto"
                    multipartFormData.append(data[i], withName:"smfile", fileName: "files.png", mimeType: "image/png")
                }
        },
            to: requestUrl,
            method:.post,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        
                        if let value = response.result.value as? [String: AnyObject]{
                            
                            print("success:\(value)")
                            self.delegate?.requestSuccess(self.requestKey!.rawValue, result:value)
                        }
                    }
                case .failure(let encodingError):
                    print("error:\(encodingError)")
                    "请求失败！".ext_debugPrintAndHint()
                    self.delegate?.requestFail(self.requestKey!.rawValue, encodingError as NSError)
                }
        }
        )
    }
    
    
    
}
