//
//  AppuntamentoTableViewCell.swift
//  CS Riabilita
//
//  Created by Mac Coobi on 12/05/23.
//  Copyright © 2023 Rubik srls. All rights reserved.
//

import UIKit

class AppuntamentoTableViewCell: UITableViewCell {

    @IBOutlet weak var spazioAppu: UIView!
    @IBOutlet weak var appuntamentoLabel: UILabel!
    @IBOutlet weak var AppunntamentoView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        spazioAppu.backgroundColor = UIColor.white
        AppunntamentoView.backgroundColor = UIColor.white

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
