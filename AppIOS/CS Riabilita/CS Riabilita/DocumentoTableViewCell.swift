//
//  DocumentoTableViewCell.swift
//  CS Riabilita
//
//  Created by Mac Coobi on 11/05/23.
//  Copyright © 2023 Rubik srls. All rights reserved.
//

import UIKit

class DocumentoTableViewCell: UITableViewCell {

    @IBOutlet weak var pdfImage: UIImageView!
    @IBOutlet weak var DocLabel: UILabel!
    @IBOutlet weak var DocView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
