//
//  HeadIconVC.swift
//  URBuddy
//
//  Created by Liuyubao on 4/24/19.
//  Copyright © 2019 xinghaiwulian. All rights reserved.
//

import UIKit
import Photos

class HeadIconVC: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var imagePickerController: UIImagePickerController!

    @IBOutlet weak var photoBtn: UIButton!
    @IBAction func photoBtnClicked(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.present(selectorController, animated: true, completion: nil)
        } else {
            print("can't find camera")
        }
    }
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LookingInfoVC")
        self.present(vc!, animated: true, completion: nil)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
