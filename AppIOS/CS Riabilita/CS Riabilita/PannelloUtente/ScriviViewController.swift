//
//  ScriviViewController.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 03/11/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import UIKit
import SwiftMessages
import Alamofire
import PMAlertController

class ScriviViewController: UIViewController {

    @IBOutlet var lblDa: UILabel!
    @IBOutlet var bttSendMessage: UIButton!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgCLose: UIImageView!
    @IBOutlet var lblDescr: UILabel!
    @IBOutlet var txtBodyMessage: UITextView!
    @IBOutlet var txtNome: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = Utility.getLbl(code: "SCRIVIMESSAGGIO")
        /*lblDescr.text = Utility.getLbl(code: "SCRIVIMESSAGGIOBODY").replacingOccurrences(of: "[TERAPISTA]", with: GeneralUtil.shared.user.terapista)*/
        // Do any additional setup after loading the view.
        bttSendMessage.setTitle(Utility.getLbl(code: "INVIAMESSAGGIO"), for: .normal)
        txtBodyMessage.layer.cornerRadius = 5;
        bttSendMessage.layer.cornerRadius = 5;
        
        lblDa.text = "Da"
        let tapGestureRecognizerEntra = UITapGestureRecognizer(target: self, action:  #selector(chiudi))
        imgCLose.isUserInteractionEnabled = true
        imgCLose.addGestureRecognizer(tapGestureRecognizerEntra)
        txtNome.text = GeneralUtil.shared.user.cognome + " " + GeneralUtil.shared.user.nome
    }


    @objc func chiudi()
             {
               self.dismiss(animated: false, completion: nil)
             }

    @IBAction func doSendMsg(_ sender: UIButton) {
        if (txtBodyMessage.text == "")
        {
            showError(txt:Utility.getLbl(code: "ERRFIELDSCRIVI"))
            return;
        }
        //invia messaggio.
        
        showIndicator();
        if (ConnectionCheck.isConnectedToNetwork() == false){return;}
                      
                      let parameters: Parameters = [
                          "action": "inviaMessaggio",
                          "token":GeneralUtil.shared.user.token!,
                           "Msg":txtBodyMessage.text!
                      ]
                       print(parameters);
                      Alamofire.request(Utility.getBaseUrl(), method: .post, parameters: parameters)
                          .responseString { response in
                              print("INVIO MESSAAGGIO")
                              print(response);
                              self.txtBodyMessage.text = "";
                              self.showOK(txt: Utility.getLbl(code: "MSGINVIATOOK"))
                          }
                          .responseJSON {response in
                            self.hideIndicator();
                              
                      }
        
    }
    
    func showIndicator()
       {
           self.showSpinner(onView: self.view)
       }
          
       func hideIndicator()
       {
           self.removeSpinner()
       }
    
    func showError(txt:String)
    {
        let view = MessageView.viewFromNib(layout: .cardView)
        SwiftMessages.defaultConfig.presentationStyle = .top

        // Theme message elements with the warning style.
        view.configureTheme(.warning)
        
        // Add a drop shadow.
        //view.configureDropShadow()
        view.button?.isHidden = true;
        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()
        view.configureContent(title: "Ops...", body: txt, iconText: iconText!)
        
        // Show the message.
        SwiftMessages.show(view: view)
    }
    
    func showOK(txt:String)
    {
        let view = MessageView.viewFromNib(layout: .cardView)
        SwiftMessages.defaultConfig.presentationStyle = .top

        // Theme message elements with the warning style.
        view.configureTheme(.success)
        
        // Add a drop shadow.
        //view.configureDropShadow()
        view.button?.isHidden = true;
        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        let iconText = ["✅"].randomElement()
        view.configureContent(title: "Ops...", body: txt, iconText: iconText!)
        
        // Show the message.
        SwiftMessages.show(view: view)
    }
}
