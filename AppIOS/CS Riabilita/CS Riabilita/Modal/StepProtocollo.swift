//
//  StepProtocollo.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 02/09/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import Foundation


class StepProtocollo: NSObject {
    
    var IDStep: String!
    var Titolo: String!
    var Sottotitolo:String!
     var fasi = [FasiStepProtocollo]()
    
    init?(from jsonObject: AnyObject) {
        guard let bCode: String = jsonObject.object(forKey: "IDStep") as? String,
            let bSot: String = jsonObject.object(forKey: "Sottotitolo") as? String,
            let bFasi: NSArray = jsonObject.object(forKey: "Fasi") as? NSArray,
            let bTest: String = jsonObject.object(forKey: "Titolo") as? String else {
                print("Error: (Creating Step Object)")
                return nil
        }
        IDStep = bCode
        Titolo = bTest
        Sottotitolo = bSot;
        
        for jo in bFasi { //riempiamo l'array.
                                if let dataArr = FasiStepProtocollo(from: jo as AnyObject) {
                                    if (dataArr.elementi != nil && dataArr.elementi.count > 0)
                                    {
                                        fasi.append(dataArr);
                                    }
                                }
                            }
        
        super.init()
    }
    
    
}
