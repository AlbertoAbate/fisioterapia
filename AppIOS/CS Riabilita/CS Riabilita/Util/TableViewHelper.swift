//
//  TableViewHelper.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 03/11/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import Foundation
import UIKit

class TableViewHelper {

    class func EmptyMessage(message:String, viewController:UITableView) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: viewController.bounds.size.width, height: viewController.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = UIColor.white
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        //messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        viewController.backgroundView = messageLabel;
        viewController.separatorStyle = .none;
    }
}

