//
//  VideoElementoViewCell.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 03/11/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import UIKit
import WebKit

class VideoElementoViewCell: UITableViewCell {

    @IBOutlet var webView: WKWebView!
    @IBOutlet var heightConstant: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
