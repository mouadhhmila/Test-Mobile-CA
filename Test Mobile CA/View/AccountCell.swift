//
//  AccountCell.swift
//  Test Mobile CA
//
//  Created by Mouadh Hmila on 4/1/2024.
//

import UIKit

class AccountCell: UITableViewCell {

    @IBOutlet weak var AccountName: UILabel!
    @IBOutlet weak var AccountBalance: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0))
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
