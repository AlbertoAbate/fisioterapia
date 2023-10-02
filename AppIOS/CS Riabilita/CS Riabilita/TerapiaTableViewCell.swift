//
//  TerapiaTableViewCell.swift
//  CS Riabilita
//
//  Created by Mac Coobi on 12/05/23.
//  Copyright © 2023 Rubik srls. All rights reserved.
//

import UIKit

class TerapiaTableViewCell: UITableViewCell {


    @IBOutlet weak var spazioTer: UIView!
    @IBOutlet weak var infoTerapia: UIImageView!
    @IBOutlet weak var terapiaLabel: UILabel!
    @IBOutlet weak var terapiaView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        spazioTer.backgroundColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
