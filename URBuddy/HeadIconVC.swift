//
//  HeadIconVC.swift
//  URBuddy
//
//  Created by Liuyubao on 4/24/19.
//  Copyright © 2019 xinghaiwulian. All rights reserved.
//

import UIKit
import Photos
import Alamofire

class HeadIconVC: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, URBNetworkDelegate {
    
    var imagePickerController: UIImagePickerController!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var photoBtn: UIButton!
    @IBOutlet weak var lookingForTF: UITextField!
    @IBAction func photoBtnClicked(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.present(selectorController, animated: true, completion: nil)
        } else {
            print("can't find camera")
        }
    }
    
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        
        
        let jpgImg:Data = (self.photoBtn.currentImage?.jpegData(compressionQuality: 0.2))!
        FreeAnimate.startAnimating()
        URBNetwork.sharedManager().uploadImg([jpgImg], self)
        
    }
    
    
    
    
    
    
    // MARK: 用于弹出选择的对话框界面
    var selectorController: UIAlertController {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil)) // 取消按钮
        controller.addAction(UIAlertAction(title: "camera", style: .default) { action in
            self.selectorSourceType(.camera)
        }) // 拍照选择
        controller.addAction(UIAlertAction(title: "photo library", style: .default) { action in
            self.selectorSourceType(.photoLibrary)
        }) // 相册选择
        return controller
    }
    
    func selectorSourceType(_ type: UIImagePickerController.SourceType) {
        //选择完类型直接打开图片或者相机选择VC
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = type
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    // MARK: 当图片选择器选择了一张图片之后回调
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        dismiss(animated: true, completion: nil) // 选中图片, 关闭选择器...这里你也可以 picker.dismissViewControllerAnimated 这样调用...但是效果都是一样的...
        
        let img = info[.originalImage] as? UIImage // 显示图片
        
        print("img", img)
        photoBtn.contentMode = .scaleAspectFit // 缩放显示, 便于查看全部的图片
        photoBtn.setImage(img, for: .normal)
        
    }
    
    // MARK: 当点击图片选择器中的取消按钮时回调
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil) // 效果一样的...
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkPermission()
    }
    
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
    }
    
    //点击其他地方  收回键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    //上传图片获取url
    func onUploadImg(_ response:[String : AnyObject]){
        if response["code"] as! String == "success"{
            let data = response["data"] as! NSDictionary
            let regImgUrl = data["url"] as! String
            // call register api
            var params = [String: Any]()
            params["user_name"] = UserDefaults.standard.string(forKey: "regName")
            params["gender"] = UserDefaults.standard.integer(forKey: "regGender")
            params["birthday"] = UserDefaults.standard.string(forKey: "regBirthday")
            params["passcode"] = UserDefaults.standard.string(forKey: "regPsw")
            params["major"] = UserDefaults.standard.string(forKey: "regMajor")
            params["email"] = UserDefaults.standard.string(forKey: "regEmail")
            params["looking_for"] = self.lookingForTF.text
            params["photo"] = regImgUrl
            params["telephone"] = UserDefaults.standard.string(forKey: "regTelephone")
            
            
            URBNetwork.sharedManager().postRegister(params as! NSDictionary, self)
            
        }else{
            (response["msg"] as! String).ext_debugPrintAndHint()
        }
    }
    
    //注册
    func onRegister(_ response:[String : AnyObject]){
        if response["code"] as! String == "success"{
            let result = response["result"] as! NSDictionary
            //获取有用信息保存到沙盒
            UserDefaults.standard.set(result, forKey: "result")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LookingInfoVC") as! HistoryDemoViewController
            vc.modalTransitionStyle = .crossDissolve
            FreeAnimate.stopAnimating()
            self.present(vc, animated: true, completion: nil)
            ("Successfully login").ext_debugPrintAndHint()
            
        }else{
            (response["msg"] as! String).ext_debugPrintAndHint()
        }
    }
    
    
    
    
    func requestSuccess(_ requestKey: NSInteger, _ response: [String : AnyObject]) {
        switch requestKey {
        case URBRequestKeyID.URB_GETIMGURL.rawValue:
            onUploadImg(response)
            break
        case URBRequestKeyID.URB_REGISTER.rawValue:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LookingInfoVC") as! HistoryDemoViewController
            vc.modalTransitionStyle = .crossDissolve
            FreeAnimate.stopAnimating()
            self.present(vc, animated: true, completion: nil)
            ("Successfully login").ext_debugPrintAndHint()
            break
        default:
            break
        }
    }
    
    func requestFail(_ requestKey: NSInteger, _ error: NSError) {
        "something wrong".ext_debugPrintAndHint()
    }

}
