//
//  FasiStepProtocollo.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 02/09/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import Foundation

class FasiStepProtocollo: NSObject {
    
    var IDTipoFase: String!
    var Nome: String!
    var elementi = [Elemento]()
 
    init?(from jsonObject: AnyObject) {
        guard let bCode: String = jsonObject.object(forKey: "IDTipoFase") as? String,
            let bNome: String = jsonObject.object(forKey: "Nome") as? String,
            let bElementi: NSArray = jsonObject.object(forKey: "Elementi") as? NSArray else {
                print("Error: (Creating FasiStepProtocollo Object)")
                return nil
        }
        IDTipoFase = bCode
        Nome = bNome
        
        for jo in bElementi { //riempiamo l'array.
                                      if let dataArr = Elemento(from: jo as AnyObject) {
                                           elementi.append(dataArr);
                                      }
                                  }
        
        super.init()
    }
    
}
