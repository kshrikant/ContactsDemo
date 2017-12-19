//
//  ContactTableViewCell.swift
//  InnoplexusContactsAssignment
//
//  Created by webwerks on 19/12/17.
//  Copyright © 2017 Shrikant Kanakatti. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    
    
    @IBOutlet weak var labelEmail: UILabel!
    
    @IBOutlet weak var labelAddress: UILabel!
    
    @IBOutlet weak var labelComapny: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
