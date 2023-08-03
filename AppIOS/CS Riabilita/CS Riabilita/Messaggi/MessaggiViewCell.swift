//
//  MessaggiViewCell.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 17/11/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import UIKit

class MessaggiViewCell: UITableViewCell {

    @IBOutlet var txtDataOra: UILabel!
    @IBOutlet var txtTitle: UILabel!
    @IBOutlet var txtDescr: UILabel!
    @IBOutlet var cntView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        cntView.layer.cornerRadius = 5;
        // Configure the view for the selected state
    }
    
}
