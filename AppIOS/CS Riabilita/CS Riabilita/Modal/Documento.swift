//
//  Documento.swift
//  CS Riabilita
//
//  Created by Mac Coobi on 16/05/23.
//  Copyright © 2023 Rubik srls. All rights reserved.
//

import Foundation

class Documento: NSObject {
    
    var UrlDoc: String!
    var UrlDocCompleto: String!
    var nomeDoc: String!
    var dataIT: String!
    var docTipo: String!
    
    
    init?(from jsonObject: AnyObject)
    {
        print("COSA CE DENTRO")
        print(jsonObject);
        
        guard let bUrlDoc: String = jsonObject.object(forKey: "Url") as? String,
              let bnomeDoc: String = jsonObject.object(forKey: "Nome") as? String,
              let bdocTipo: String = jsonObject.object(forKey: "DocumentoTipo") as? String,
              let bdataIT: String = jsonObject.object(forKey: "DataIT") as? String,
            let bUrlDocCompleto: String = jsonObject.object(forKey: "UrlCompleto") as? String else {
                print("Error: (Creating Protocollo Object)")
                return nil
        }
        UrlDoc = bUrlDoc
        UrlDocCompleto = bUrlDocCompleto
        nomeDoc = bnomeDoc
        docTipo = bdocTipo
        dataIT = bdataIT
        
        super.init()
    }
    
}
