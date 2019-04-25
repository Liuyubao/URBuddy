

import UIKit

class HistoryDemoViewController: ZLSwipeableViewController {
    @IBOutlet weak var historyBtn: UIButton!
    @IBOutlet weak var msgBtn: UIButton!
    @IBAction func backToMsgBtnClciked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
        self.swipeableView.rewind()
        // updateRightBarButtonItem()
    }

}
