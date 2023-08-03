//
//  MessaggiViewController.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 17/11/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import UIKit
import Alamofire

class MessaggiViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var bttClose: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    var msgList = [Messaggio]();
    @IBOutlet var tableMessaggi: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizerEntra = UITapGestureRecognizer(target: self, action:  #selector(chiudi))
        bttClose.isUserInteractionEnabled = true
        bttClose.addGestureRecognizer(tapGestureRecognizerEntra)
        
        lblTitle.text = Utility.getLbl(code: "ELENCOMESSAGGI")
        
        tableMessaggi.register(UINib(nibName: "MessaggiViewCell", bundle: nil), forCellReuseIdentifier: "MessaggiViewCell")
        tableMessaggi.dataSource = self
        tableMessaggi.delegate = self
        tableMessaggi.separatorColor = UIColor.clear

        if #available(iOS 13.0, *) {
            tableMessaggi.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        loadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (msgList.isEmpty)
        {
            return 0;
        }
        else
        {
            return msgList.count;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item: MessaggiViewCell = tableMessaggi.dequeueReusableCell(withIdentifier: "MessaggiViewCell", for: indexPath) as! MessaggiViewCell
        let o = msgList[indexPath.row]
         item.txtDataOra.text = o.dataora
         item.txtTitle.text = Utility.getLbl(code:o.title);
         item.txtDescr.text = o.descr
     
        return item;
    }
    
    private func loadData()
    {
       
        
       
        if (ConnectionCheck.isConnectedToNetwork() == false){return;}
               
               let parameters: Parameters = [
                   "action": "getNotificationList",
                   "token": GeneralUtil.shared.user.token!,
                   "IDLocation": GeneralUtil.shared.idLocation,
                   "IDLang": GeneralUtil.shared.idlang,
                   "start":"0",
                   "limit":"100"
               ]
                print(parameters);
               Alamofire.request(Utility.getBaseUrl(), method: .post, parameters: parameters)
                   .responseString { response in
                       print("DETTAGLI ORDINI")
                       print(response);
                   }
                   .responseJSON {response in
                       
                       print(response);
                       do {
                         self.msgList.removeAll();
                           let jsonArray = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! NSArray
                           // Looping through jsonArray
                           for jsonObject in jsonArray { //riempiamo l'array.
                                if let dataArr = Messaggio(from: jsonObject as AnyObject) {
                                   self.msgList.append(dataArr);
                               }
                           }
                           
                         if (jsonArray.count == 0)
                             {
                                                                    TableViewHelper.EmptyMessage(message: Utility.getLbl(code: "EMPTYMESSAGGI"), viewController: self.tableMessaggi)
                             }
                         else
                          {
                                      TableViewHelper.EmptyMessage(message: "", viewController: self.tableMessaggi)
                          }
                         
                           self.tableMessaggi.reloadData();
                           
                           
                       }
                       catch {
                           print("Error: (Retrieving Data)")
                       }
                       
                       
                       
               }
        
        //calcolaInCorso();
    }

    @objc func chiudi()
             {
               self.dismiss(animated: false, completion: nil)
             }

   
}
