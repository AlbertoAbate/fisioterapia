//
//  Terapia.swift
//  CS Riabilita
//
//  Created by Mac Coobi on 16/05/23.
//  Copyright © 2023 Rubik srls. All rights reserved.
//

import Foundation

class Terapia: NSObject {
    
    var laTerapia: String!
    var stepTera = [StepTerapia]()
    var nome: String!
    var testo: String!
    var terapiaTipo: String!
    var dataInizioIt: String!
    var dataFineIt: String!
    var nomeTer: String!
    var dataFine: Date?
    var nominativo: String!
    var parteCorpo: String!
    var note: String!
    
    init?(from jsonObject: AnyObject) {
        print("COSA CE DENTRO")
        print(jsonObject)
        
        guard let nomeTera: String = jsonObject.object(forKey: "Terapia") as? String,
              let terapieArray = jsonObject.object(forKey: "Terapie") as? [[String: Any]],
              let terapiaDict = terapieArray.first,
              let nomeTerapia = terapiaDict["Nome"] as? String else {
            print("Error: Failed to parse Terapie array")
            return nil
        }
        
        nomeTer = nomeTera
        nome = nomeTerapia
        
        if let nominativo = jsonObject.object(forKey: "Nominativo") as? String {
            self.nominativo = nominativo
        }
        
        if let note = jsonObject.object(forKey: "note") as? String {
            self.note = note
        }
        
        if let dataFineIt = jsonObject.object(forKey: "DataFineIT") as? String {
            self.dataFineIt = dataFineIt
        }
        
        if let dataInizioIt = jsonObject.object(forKey: "DataInizioIT") as? String {
            self.dataInizioIt = dataInizioIt
        }
        
        if let parteCorpo = terapiaDict["Nome"] as? String {
            self.parteCorpo = parteCorpo
        }
        
        if let terapiaTipo = terapiaDict["TerapiaTipo"] as? String {
            self.terapiaTipo = terapiaTipo
        }
        
        if let testoTerapia = terapiaDict["Testo"] as? String {
            self.testo = testoTerapia
        }
        
        if let dataFineString = terapiaDict["DataFine"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Formato della data nel JSON
            if let dataFine = dateFormatter.date(from: dataFineString) {
                self.dataFine = dataFine
            }
        }
        
        super.init()
    }
    
}

