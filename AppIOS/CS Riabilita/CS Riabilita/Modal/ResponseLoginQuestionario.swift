//
//  ResponseLoginQuestionario.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 17/11/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import Foundation

class ResponseLoginQuestionario: NSObject {
    
    var message: String!
    var status: String!
    
    init?(from jsonObject: AnyObject) {
        guard let bStatus: String = jsonObject.object(forKey: "data") as? String,
            let bMessage: String = jsonObject.object(forKey: "res") as? String else {
                print("Error: (Creating ResponseLogin Object)")
                return nil
        }
        
        status = bStatus
        message = bMessage
        
        super.init()
    }
    
}
