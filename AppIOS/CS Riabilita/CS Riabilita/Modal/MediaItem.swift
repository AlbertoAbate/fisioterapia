//
//  MediaItem.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 02/09/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import Foundation

class MediaItem: NSObject {
    
    var IDMedia: String!
    var Descrizione: String!
    var Tipo:String!
    var Url:String!
    

    init?(from jsonObject: AnyObject) {
        guard let bCode: String = jsonObject.object(forKey: "IDMedia") as? String,
            let bTipo: String = jsonObject.object(forKey: "Tipo") as? String,
             let bUrl: String = jsonObject.object(forKey: "Url") as? String,
            let bNome: String = jsonObject.object(forKey: "Descrizione") as? String else {
                print("Error: (Creating Media Object)")
                return nil
        }
        IDMedia = bCode
        Tipo = bTipo
        Url = bUrl
        Descrizione = bNome;
        
        super.init()
    }
    
}
