//
//  Label.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 31/08/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//


import Foundation


class Label: NSObject {
    
    var code: String!
    var value: String!
    
    init?(from jsonObject: AnyObject) {
        guard let bCode: String = jsonObject.object(forKey: "code") as? String,
            let bValue: String = jsonObject.object(forKey: "value") as? String else {
                print("Error: (Creating Label Object)")
                return nil
        }
        code = bCode
        value = bValue
        super.init()
    }
    
}

