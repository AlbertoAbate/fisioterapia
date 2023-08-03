//
//  Profilo.swift
//  CS Riabilita
//
//  Created by Mac Coobi on 19/05/23.
//  Copyright © 2023 Rubik srls. All rights reserved.
//

import Foundation

class Profilo: NSObject {
    
    var ilNome: String!
    var cognome: String!
    var mail: String!
    var tel: String!
    var indirizzo: String!
    var cf: String!
    var comune: String!
    var provincia: String!
    var dataNascita: String!

    
    init?(from jsonObject: AnyObject)
    {
        print("COSA CE DENTRO")
        print(jsonObject);
        
        guard let bilNome: String = jsonObject.object(forKey: "Name") as? String,
              let bcognome: String = jsonObject.object(forKey: "Surname") as? String,
              let bmail: String = jsonObject.object(forKey: "Email") as? String,
              let btel: String = jsonObject.object(forKey: "Phone") as? String,
              let bindirizzo: String = jsonObject.object(forKey: "Address") as? String,
                   let bcf: String = jsonObject.object(forKey: "Cf") as? String,
                   let bcomune: String = jsonObject.object(forKey: "Comune") as? String,
                   let bprovincia: String = jsonObject.object(forKey: "Prov") as? String,
            let bdataNascita: String = jsonObject.object(forKey: "DataNascita") as? String else {
                print("Error: (Creating Protocollo Object)")
                return nil
        }
        
        ilNome = bilNome
        cognome = bcognome
        mail = bmail
        tel = btel
        indirizzo = bindirizzo
        cf = bcf
        comune = bcomune
        provincia = bprovincia
        dataNascita = bdataNascita

        
        super.init()
    }
    
}
