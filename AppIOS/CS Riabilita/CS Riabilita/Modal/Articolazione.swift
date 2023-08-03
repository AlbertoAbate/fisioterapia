//
//  Articolazione.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 31/08/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import Foundation



class Articolazione: NSObject {
    
    var IDArticolazione: String!
    var Nome: String!
    var Testo: String!
    var ImageUrl: String!
    var side:String!
    init?(from jsonObject: AnyObject) {
        guard let bCode: String = jsonObject.object(forKey: "IDArticolazione") as? String,
            let bTest: String = jsonObject.object(forKey: "Testo") as? String,
            let bImage: String = jsonObject.object(forKey: "ImageUrl") as? String,
            let bValue: String = jsonObject.object(forKey: "Nome") as? String else {
                print("Error: (Creating Label Object)")
                return nil
        }
        IDArticolazione = bCode
        Nome = bValue
        Testo = bTest
        ImageUrl = bImage
        if (bCode == "10" || bCode == "11" || bCode == "12")
        {
            side = "RETRO";
        }
        else
        {
            side = "FRONTE";
        }
        super.init()
    }
    
}

