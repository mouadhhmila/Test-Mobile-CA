//
//  BankAccount.swift
//  Test Mobile CA
//
//  Created by Mouadh Hmila on 4/1/2024.
//

import UIKit


class BankAccount: UITableViewHeaderFooterView {

    @IBOutlet weak var BankAccountTitle: UILabel!
    @IBOutlet weak var TotalBalance: UILabel!
    @IBOutlet weak var chevron: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
