//
//  ResponseLogin.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 03/11/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import Foundation

class ResponseLogin: NSObject {
    
    var message: String!
    var status: String!
    var utente: Utente!
    
    init?(from jsonObject: AnyObject) {
        guard let bStatus: String = jsonObject.object(forKey: "status") as? String,
            let bMessage: String = jsonObject.object(forKey: "message") as? String else {
                print("Error: (Creating ResponseLogin Object)")
                return nil
        }
        
        status = bStatus
        message = bMessage
        let valStatus = status!.components(separatedBy: "|")
        status = valStatus[0] ;
        
        if (status == "OK")
        {
            if (jsonObject.object(forKey: "user") != nil)
            {
                guard let bUser: NSArray = jsonObject.object(forKey: "user") as? NSArray else {
                    print("Error: (Creating ResponseLogin UserObject)")
                    return nil
                    print("arrivo qui1")
                }
                print("arrivo qui2")

                for jsonObject in bUser { //riempiamo l'array.
                    if let dataArr = Utente(from: jsonObject as AnyObject) {
                        utente = dataArr;
                        utente.token = valStatus[1];
                        print("arrivo qui3")
                    }
                }
            }
            
            
        }
        
        super.init()
    }
    
}

