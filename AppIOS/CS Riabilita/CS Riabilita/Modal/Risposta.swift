//
//  Risposta.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 22/10/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import Foundation

class Risposta: NSObject {
    
    var IDRisposta: String!
    var Lettera: String!
    var Tipo:String!
    var Titolo:String!
    var TestoDato:String!
    var selezionato: Bool = false
    
    init?(from jsonObject: AnyObject) {
        guard let bCode: String = jsonObject.object(forKey: "IDRisposta") as? String,
            let bTipo: String = jsonObject.object(forKey: "Tipo") as? String,
             let bTitolo: String = jsonObject.object(forKey: "Titolo") as? String,
            let bLettera: String = jsonObject.object(forKey: "Lettera") as? String else {
                print("Error: (Creating Risposta Object)")
                return nil
        }
        IDRisposta = bCode
        Lettera = bLettera
        Tipo = bTipo
        Titolo = bTitolo;
        
        super.init()
    }
    
}
