//
//  StepTerapia.swift
//  CS Riabilita
//
//  Created by Mac Coobi on 16/05/23.
//  Copyright © 2023 Rubik srls. All rights reserved.
//

import Foundation


class StepTerapia: NSObject {
    
    var NomeTerapia: String!
    var TipoTerapia: String!
     var fasi = [FasiStepProtocollo]()
    
    init?(from jsonObject: AnyObject) {
        guard let bNomeTerapia: String = jsonObject.object(forKey: "Nome") as? String,
            let bTipoTerapia: String = jsonObject.object(forKey: "Testo") as? String else {
                print("Error: (Creating Step Object)")
                return nil
        }
        NomeTerapia = bNomeTerapia
        TipoTerapia = bTipoTerapia
        
        super.init()
    }
    
    
}

