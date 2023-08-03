//
//  Elemento.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 02/09/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import Foundation

class Elemento: NSObject {
    
    var IDElemento: String!
    var Titolo: String!
    var mediaItems = [MediaItem]()


    init?(from jsonObject: AnyObject) {
        guard let bCode: String = jsonObject.object(forKey: "IDElemento") as? String,
            let bNome: String = jsonObject.object(forKey: "Titolo") as? String,
            let bMedia: NSArray = jsonObject.object(forKey: "Media") as? NSArray else {
                print("Error: (Creating Elemento Object)")
                return nil
        }
        IDElemento = bCode
        Titolo = bNome
        
        for jo in bMedia { //riempiamo l'array.
                                             if let dataArr = MediaItem(from: jo as AnyObject) {
                                                  mediaItems.append(dataArr);
                                             }
                                         }
        
        super.init()
    }
    
}
