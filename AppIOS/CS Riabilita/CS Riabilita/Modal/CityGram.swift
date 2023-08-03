//
//  CityGram.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 31/08/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import Foundation
import Alamofire

class Citygram: NSObject {

   
    
    public override init() { }
    
    
    
    
    
    func loadLabels(vc:ViewController)
    {
        
        if (ConnectionCheck.isConnectedToNetwork() == false){return;}
        
        let parameters: Parameters = [
            "action": "getAllLabel",
            "IDLocation": GeneralUtil.shared.idLocation,
            "IDLang" :GeneralUtil.shared.idlang
        ]
        
        Alamofire.request(Utility.getBaseUrl(), method: .post, parameters: parameters)
            .responseString { response in
              
                print(response);
                
              
                
            }
            .responseJSON {response in
                
                do {
                    //GeneralUtil.shared.labelsArray = [Label](); //instanziamo nuovo array
                    let jsonArray = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! NSMutableArray //parse del data.
                    // Looping through jsonArray
                    for jsonObject in jsonArray { //riempiamo l'array.
                        if let dataArr = Label(from: jsonObject as AnyObject) {
                            GeneralUtil.shared.labelsArray.append(dataArr)
                        }
                    }
                    
                    vc.startAll();
                   
                    //loaded.
                    
                }
                catch {
                    print("Error: (Retrieving Data LABLE)")
                }
                
                
                //var l = mainArray[0] //SAMPLE
                //print(l.code as! String);
              
                
        }
  
    }
    
   
}

