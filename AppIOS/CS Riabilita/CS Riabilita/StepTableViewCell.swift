//
//  StepTableViewCell.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 02/09/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import UIKit

class StepTableViewCell: UITableViewCell {

    @IBOutlet var mainView: UIView!
    @IBOutlet var title: UILabel!
    @IBOutlet var subtitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
