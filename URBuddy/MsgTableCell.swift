//
//  MsgTableCell.swift
//  URBuddy
//
//  Created by Liuyubao on 4/24/19.
//  Copyright © 2019 xinghaiwulian. All rights reserved.
//

import UIKit

class MsgTableCell: UITableViewCell {
    @IBOutlet weak var headIconIV: UIImageView!
    @IBOutlet weak var msgTV: UITextView!
    @IBOutlet weak var userNameL: UILabel!
    @IBOutlet weak var majorL: UILabel!
    @IBOutlet weak var ageL: UILabel!
    @IBOutlet weak var replyBtn: UIButton!
    @IBOutlet weak var sendTimeL: UILabel!
    var telephone: String = ""
    var messageID: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
