

import UIKit

class HistoryDemoViewController: ZLSwipeableViewController {
    @IBOutlet weak var historyBtn: UIButton!
    @IBOutlet weak var msgBtn: UIButton!
    @IBAction func backToMsgBtnClciked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func msgBtnClicked(_ sender: UIButton) {
        let toName = self.userInfos[self.infoIndex - 3]["name"] as! String
        let toTelephone = self.userInfos[self.infoIndex - 3]["telephone"] as! String
        UserDefaults.standard.setValue(toTelephone, forKey: "toTelephone")
        UserDefaults.standard.setValue(toName, forKey: "toName")
//        toName.ext_debugPrintAndHint()
//        toTelephone.ext_debugPrintAndHint()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SendMsgVC") as! SendMsgVC
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let role = UserDefaults.standard.dictionary(forKey: "result")!["role"] as! Int
        if role == 2001{
            self.historyBtn.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.init(red: 255, green: 232, blue: 13, alpha: 0.0)
        
        
        swipeableView.numberOfHistoryItem = UInt.max
        swipeableView.allowedDirection = Direction.All

        let rightBarButtonItemTitle = "Rewind"

        func updateRightBarButtonItem() {
            let historyLength = self.swipeableView.history.count
            let enabled = historyLength != 0
            self.navigationItem.rightBarButtonItem?.isEnabled = enabled
            self.historyBtn.isEnabled = enabled
            if !enabled {
                self.navigationItem.rightBarButtonItem?.title = rightBarButtonItemTitle
                self.historyBtn.setTitle(rightBarButtonItemTitle, for: .normal)
                return
            }
            let suffix = " (\(historyLength))"
            self.navigationItem.rightBarButtonItem?.title = "\(rightBarButtonItemTitle)\(suffix)"
            
            self.historyBtn.setTitle("\(rightBarButtonItemTitle)\(suffix)", for: .normal)
            
            //store the data
            
            
        }

        swipeableView.didSwipe = {view, direction, vector in
            print("Did swipe view in direction: \(direction)")
            updateRightBarButtonItem()
        }
        
        self.historyBtn.addTarget(self, action: #selector(rightButtonClicked), for: .touchUpInside)
        
        // ↺
        let rightButton = UIBarButtonItem(title: rightBarButtonItemTitle, style: .plain, target: self, action: #selector(rightButtonClicked))
        navigationItem.rightBarButtonItem = rightButton

        updateRightBarButtonItem()
    }
    
    // MARK: - Actions
    
    @objc func rightButtonClicked() {
        self.infoIndex -= 1
        self.colorIndex -= 1
        self.swipeableView.rewind()
        // updateRightBarButtonItem()
    }

}
