//
//  Domanda.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 22/10/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import Foundation

class Domanda: NSObject {
    
    var IDDomanda: String!
    var risposteList = [Risposta]()
    var Testo:String!
    var rispostaData:Risposta!;

    init?(from jsonObject: AnyObject) {
        guard let bCode: String = jsonObject.object(forKey: "IDDomanda") as? String,
            let bTesto: String = jsonObject.object(forKey: "Testo") as? String,
            let bRisposte: NSArray = jsonObject.object(forKey: "Risposte") as? NSArray else {
                print("Error: (Creating Domanda Object)")
                return nil
        }
        IDDomanda = bCode
        Testo = bTesto
        for jsonObject in bRisposte { //riempiamo l'array.
            if let dataArr = Risposta(from: jsonObject as AnyObject) {
                risposteList.append(dataArr)
            }
        }
        super.init()
    }
    
    func getRisposteSelezionate() -> [Risposta]
    {
        var rSel = [Risposta]();
        for r in risposteList
        {
            if (r.selezionato == true)
            {
                rSel.append(r);
            }
        }
        return rSel;
    }
    
   
    
}
