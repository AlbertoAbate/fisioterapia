//
//  Appuntamento.swift
//  CS Riabilita
//
//  Created by Mac Coobi on 18/05/23.
//  Copyright © 2023 Rubik srls. All rights reserved.
//

import Foundation

class Appuntamento: NSObject {
    
    var ggFormat: String!
    var ora: String!
    var date: Date!
    var nome: String!
    var cognome: String!
    var stato: String!
    var tag: String!
    var durata: String!
    
    init?(from jsonObject: AnyObject) {
        guard let bData = jsonObject.object(forKey: "ggFormat") as? String,
            let bora = jsonObject.object(forKey: "ora") as? String,
              let bnome = jsonObject.object(forKey: "Nome") as? String,
              let bcognome = jsonObject.object(forKey: "Cognome") as? String,
              let bstato = jsonObject.object(forKey: "Stato") as? String,
              let btag = jsonObject.object(forKey: "Tag") as? String,
              let bdurata = jsonObject.object(forKey: "Durata") as? String,
            let bdateString = jsonObject.object(forKey: "DataOra") as? String else {
                print("Error: Creating Appuntamento Object")
                return nil
        }
        
        ggFormat = bData
        ora = bora
        nome = bnome
        cognome = bcognome
        stato = bstato
        tag = btag
        durata = bdurata
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Assuming the format is "yyyy-MM-dd HH:mm:ss"
        if let bdate = dateFormatter.date(from: bdateString) {
            date = bdate
        } else {
            print("Error: Invalid date format")
            return nil
        }
        
        super.init()
    }

}

