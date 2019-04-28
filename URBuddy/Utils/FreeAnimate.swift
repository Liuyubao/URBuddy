//
//  FreeAnimation.swift
//  URBuddy
//
//  Created by Liuyubao on 4/28/19.
//  Copyright © 2019 xinghaiwulian. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import UIKit

class FreeAnimate: NSObject {
    
    static func startAnimating() {
        let activityData = ActivityData.init(size: nil, message: "loading", messageFont: UIFont.systemFont(ofSize: 15), messageSpacing: nil, type: nil, color: UIColor(rgb: 0xFFE80D), padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: UIColor.clear, textColor: UIColor(rgb: 0xFFE80D))
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+15.0) {
            self.stopAnimating()
        }
    }
    
    static func stopAnimating() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
}
