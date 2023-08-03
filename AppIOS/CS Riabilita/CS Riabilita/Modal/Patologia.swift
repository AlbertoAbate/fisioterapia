//
//  Patologia.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 01/09/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import Foundation


class Patologia: NSObject {
    
    var IDPatologia: String!
    var Nome: String!
    var Testo: String!
    var ImageUrl: String!
    var IDArticolazione: String!
    
    init?(from jsonObject: AnyObject) {
        guard let bCode: String = jsonObject.object(forKey: "IDPatologia") as? String,
            let bTest: String = jsonObject.object(forKey: "Testo") as? String,
            let bArt: String = jsonObject.object(forKey: "IDArticolazione") as? String,
            let bImage: String = jsonObject.object(forKey: "ImageUrl") as? String,
            let bValue: String = jsonObject.object(forKey: "Nome") as? String else {
                print("Error: (Creating Label Object)")
                return nil
        }
        IDPatologia = bCode
        Nome = bValue
        Testo = bTest
        ImageUrl = bImage
        IDArticolazione = bArt
        super.init()
    }
    
}
