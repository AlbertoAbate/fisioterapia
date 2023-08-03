//
//  Protocollo.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 01/09/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import Foundation


class Protocollo: NSObject {
    
    var IDProtocollo: String!
    var Nome: String!
    var Testo: String!
    var ImageUrl: String!
    var Visibilita: String!
    var IDPatologia:String!
    var Patologia:String!
    var Prezzo: String!
    var step = [StepProtocollo]()
    
    init?(from jsonObject: AnyObject)
    {
        print("COSA CE DENTRO")
        print(jsonObject);
        
        guard let bCode: String = jsonObject.object(forKey: "IDProtocollo") as? String,
            let bTest: String = jsonObject.object(forKey: "Testo") as? String,
            let bPat: String = jsonObject.object(forKey: "IDPatologia") as? String,
            let bImage: String = jsonObject.object(forKey: "ImageUrl") as? String,
            let bVisb: String = jsonObject.object(forKey: "Visibilita") as? String,
            let bPatNome: String = jsonObject.object(forKey: "Patologia") as? String,
            let bPrezzo: String = jsonObject.object(forKey: "Prezzo") as? String,
            let bStep: NSArray = jsonObject.object(forKey: "Steps") as? NSArray,
            let bValue: String = jsonObject.object(forKey: "Nome") as? String else {
                print("Error: (Creating Protocollo Object)")
                return nil
        }
        IDProtocollo = bCode
        Nome = bValue
        Testo = bTest
        ImageUrl = bImage
        Visibilita = bVisb;
        IDPatologia = bPat
        Patologia = bPatNome
        Prezzo = bPrezzo;
        print(bStep)
        for jsonObject in bStep { //riempiamo l'array.
                         if let dataArr = StepProtocollo(from: jsonObject as AnyObject) {
                              step.append(dataArr);
                         }
                     }
        
        super.init()
    }
    
}

