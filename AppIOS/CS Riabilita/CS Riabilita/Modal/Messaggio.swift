//
//  Messaggio.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 17/11/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import Foundation


class Messaggio: NSObject {

    var id: String!
    var title: String!
    var descr: String!
    var img:String!
    var dataora:String!
    var actionType:String!
    var dataAction:String!

    override init(){}

    init?(from jsonObject: AnyObject) {
        guard let bCode: String = jsonObject.object(forKey: "IDNotification") as? String,
            let bTitle: String = jsonObject.object(forKey: "Title") as? String,
            let bDescr: String = jsonObject.object(forKey: "Description") as? String,
            let bImg: String = jsonObject.object(forKey: "Image") as? String,
            let bDataOra: String = jsonObject.object(forKey: "DateTime") as? String,
            let bAction: String = jsonObject.object(forKey: "ActionType") as? String,
            let bData: String = jsonObject.object(forKey: "DataAction") as? String else {
                print("Error: (Creating Messaggio Object)")
                return nil
        }
        id = bCode
        title = bTitle
        descr = bDescr
        img = bImg
        dataora = bDataOra
        actionType = bAction
        dataAction = bData
        super.init()
    }

}


