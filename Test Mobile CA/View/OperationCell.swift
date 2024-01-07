//
//  OperationCell.swift
//  Test Mobile CA
//
//  Created by Mouadh Hmila on 4/1/2024.
//

import UIKit

class OperationCell: UITableViewCell {

    @IBOutlet weak var _operationtitle: UILabel!
    @IBOutlet weak var _operationBalance: UILabel!
    @IBOutlet weak var _operationDate: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25))
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
