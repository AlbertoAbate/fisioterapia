//
//  ProtocolloTableViewCell.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 01/09/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import UIKit

class ProtocolloTableViewCell: UITableViewCell {

    @IBOutlet var lblNome: UILabel!
    @IBOutlet var mainView: UIView!
    @IBOutlet var imgLock: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
