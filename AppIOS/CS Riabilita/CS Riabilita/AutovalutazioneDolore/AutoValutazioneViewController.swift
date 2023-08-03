//
//  AutoValutazioneViewController.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 14/10/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import UIKit
import Alamofire
import SwiftMessages

class AutoValutazioneViewController: UIViewController {

    @IBOutlet var imgClose: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var scrollContent: UIScrollView!
    @IBOutlet var lblNumDomande: UILabel!
    @IBOutlet var imgOK: UIImageView!
    @IBOutlet var imgDescrOK: UILabel!
    @IBOutlet var bttChiudi: UIButton!
    
    var crtDomanda: Int! = 0;
    var domandeList = [Domanda]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgOK.isHidden = true
        imgDescrOK.isHidden = true;
        bttChiudi.isHidden = true;
        let tapGestureRecognizerEntra = UITapGestureRecognizer(target: self, action:  #selector(chiudi))
        imgClose.isUserInteractionEnabled = true
        imgClose.addGestureRecognizer(tapGestureRecognizerEntra)
        lblTitle.text = Utility.getLbl(code: "TITLEQUESTIONARIO")
        bttChiudi.setTitle(Utility.getLbl(code: "CHIUDI"), for: .normal)
        self.hideKeyboardWhenTappedAround()
        loadQuestionario()
    }
    
    @IBAction func doCompletato(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
       func showIndicator()
          {
              self.showSpinner(onView: self.view)
          }
             
          func hideIndicator()
          {
              self.removeSpinner()
          }
    
    
    func loadQuestionario()
    {
        showIndicator();
        crtDomanda = 0;
        if (ConnectionCheck.isConnectedToNetwork() == false){return;}
                      
                      let parameters: Parameters = [
                          "action": "getQuestionario",
                         "IDProtocollo":GeneralUtil.shared.crtProtocollo.IDProtocollo!
                      ]
                       print(parameters);
                       Alamofire.request(Utility.getBaseUrl(), method: .post, parameters: parameters)
                          .responseString { response in
                              print("DETTAGLI QUESTIONARIO")
                              print(response);
                          }
                          .responseJSON {response in
                              
                              print(response);
                              do {
                                let jsonArray = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! NSArray
                                // Looping through jsonArray
                                self.lblNumDomande.text = Utility.getLbl(code: "DOMANDA") + " " + String(self.crtDomanda+1) + " di " + String(jsonArray.count)
                                for jsonObject in jsonArray { //riempiamo l'array.
                                     if let dataArr = Domanda(from: jsonObject as AnyObject) {
                                        self.domandeList.append(dataArr);
                                    }
                                }
                                print(self.domandeList);
                                self.hideIndicator()
                                self.showViewDomanda();
                                  
                              }
                              catch {
                                  print("Error: (Retrieving Data)")
                              }
                              
                              
                              
                      }
    }
    
    @objc func chiudi()
             {
               self.dismiss(animated: false, completion: nil)
             }
    
    func showViewDomanda()
    {
        for sb in scrollContent.subviews
        {
            sb.removeFromSuperview();
        }
        
        let title = UILabel();
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        title.frame = CGRect(x: lblTitle.frame.origin.x , y: 0 , width: screenWidth, height: lblTitle.frame.size.height)
        //lblnometopic.backgroundColor = UIColor(named:"TintBase")
        title.numberOfLines = 0;
        title.font = title.font.withSize(21)
        title.textColor = UIColor.white
        title.textAlignment = .center;
        
        title.padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        title.text = domandeList[crtDomanda].Testo;
        title.sizeToFit()
        scrollContent.addSubview(title)
        self.lblNumDomande.text = Utility.getLbl(code: "DOMANDA") + " " + String(self.crtDomanda+1) + " di " + String(domandeList.count)
        var crtPosY:Double = 0;
        var idx:Int = 0;
        for rispo in domandeList[crtDomanda].risposteList
        {
            if (rispo.Tipo == "MULTI")
            {
                crtPosY = crtPosY + 60;
                let btt = UIButton();
                btt.frame = CGRect(x: lblTitle.frame.origin.x + 20 , y: CGFloat(crtPosY) , width: lblTitle.frame.size.width - 40, height: 46)
                //lblnometopic.backgroundColor = UIColor(named:"TintBase")
                btt.titleLabel?.font = title.font.withSize(21)
                btt.tintColor = Utility.hexStringToUIColor(hex: "#29688B")
                btt.setTitleColor(Utility.hexStringToUIColor(hex: "#29688B"), for: .normal)
                btt.setTitleColor(Utility.hexStringToUIColor(hex: "#000000"), for: .highlighted)
                btt.setTitleColor(Utility.hexStringToUIColor(hex: "#000000"), for: .selected)
                btt.setTitle(rispo.Titolo, for: .normal);
                btt.layer.cornerRadius = 5;
                btt.titleLabel?.padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                btt.backgroundColor = UIColor.white
                btt.tag = idx;
                btt.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
                scrollContent.addSubview(btt)
            }
            else if (rispo.Tipo == "TXT")
            {
                crtPosY = crtPosY + 60;
                let bttText = UITextView();
                bttText.frame = CGRect(x: lblTitle.frame.origin.x + 20 , y: CGFloat(crtPosY) , width: lblTitle.frame.size.width - 40, height: 250)
                //btt.placeholder = rispo.Titolo;
                bttText.layer.cornerRadius = 5;
                scrollContent.addSubview(bttText)
                
                crtPosY = crtPosY + 264;
                let btt = SubclassedUIButton();
                btt.frame = CGRect(x: lblTitle.frame.origin.x + 10 , y: CGFloat(crtPosY) , width: lblTitle.frame.size.width - 20, height: 46)
                //lblnometopic.backgroundColor = UIColor(named:"TintBase")
                btt.titleLabel?.font = title.font.withSize(21)
                btt.tintColor = Utility.hexStringToUIColor(hex: "#29688B")
                btt.setTitleColor(Utility.hexStringToUIColor(hex: "#29688B"), for: .normal)
                btt.setTitleColor(Utility.hexStringToUIColor(hex: "#000000"), for: .highlighted)
                btt.setTitleColor(Utility.hexStringToUIColor(hex: "#000000"), for: .selected)
                btt.setTitle(Utility.getLbl(code: "CONFERMARISPOSTA"), for: .normal);
                btt.layer.cornerRadius = 5;
                btt.titleLabel?.padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                btt.backgroundColor = UIColor.white
                btt.tag = idx;
                btt.cntText = bttText;
                btt.addTarget(self, action:#selector(self.buttonClickedTestoLibero), for: .touchUpInside)
                scrollContent.addSubview(btt)
                
                bttText.becomeFirstResponder()
            }
            idx = idx + 1;
        }
        
    }
    
    @objc func buttonClicked(sender : UIButton)
    {
        print("VAI");
        if (domandeList[crtDomanda].risposteList[sender.tag].TestoDato == nil)
        {
            domandeList[crtDomanda].risposteList[sender.tag].TestoDato = "";
        }
        domandeList[crtDomanda].risposteList[sender.tag].selezionato = true;
        domandeList[crtDomanda].rispostaData = domandeList[crtDomanda].risposteList[sender.tag];
        crtDomanda = crtDomanda + 1;
        if (crtDomanda < domandeList.count)
        {
           
            showViewDomanda()
        }
        else
        {
            crtDomanda = crtDomanda - 1;
            print("MOSTRO LA FINE");
            mostraLaFine();
        }
    }
    
    @objc func buttonClickedTestoLibero(sender : SubclassedUIButton)
    {
        print("VAI");
        if (sender.cntText?.text! == "")
        {
            let view = MessageView.viewFromNib(layout: .cardView)
            SwiftMessages.defaultConfig.presentationStyle = .top

            // Theme message elements with the warning style.
            view.configureTheme(.error)
            
            // Add a drop shadow.
            //view.configureDropShadow()
            view.button?.isHidden = true;
            // Set message title, body, and icon. Here, we're overriding the default warning
            // image with an emoji character.
            let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()
            view.configureContent(title: "Ops...", body: Utility.getLbl(code: "COMPILAILCAMPO"), iconText: iconText!)
            
            // Show the message.
            SwiftMessages.show(view: view)
            return;
        }
        
        //domandeList[crtDomanda].risposteList[sender.tag].TestoDato = sender.cntText?.text!
        domandeList[crtDomanda].risposteList[sender.tag].selezionato = true;
        domandeList[crtDomanda].rispostaData = domandeList[crtDomanda].risposteList[sender.tag];
        domandeList[crtDomanda].rispostaData.TestoDato = sender.cntText?.text!
        print(sender.cntText?.text!)
        crtDomanda = crtDomanda + 1;
        if (crtDomanda < domandeList.count)
        {
           
            showViewDomanda()
        }
        else
        {
            crtDomanda = crtDomanda - 1;
            print("MOSTRO LA FINE");
            mostraLaFine();
        }
    }
    
    
    func jsonToString(json: AnyObject) -> String {
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            return convertedString! // <-- here is ur string

        } catch let myJSONError {
            print(myJSONError)
            return "";
        }

    }
    
    func ringraziamentoFinale()
    {
        self.scrollContent.isHidden = true;
        self.lblNumDomande.isHidden = true;
        self.imgOK.isHidden = false;
        self.imgDescrOK.text = Utility.getLbl(code: "QUESTIONARIOINVIATOOK");
        self.imgDescrOK.isHidden = false;
        self.bttChiudi.isHidden = false;
        self.hideIndicator()
    }
    
    func showMessaggio(strMessage:String)
    {
        DispatchQueue.main.async(){
                let vc = InfoViewController()
                vc.type = "RISPOSTAQUESTIONARIO";
                vc.valore = strMessage
                vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                self.present(vc, animated: true, completion: nil)
        }
    }
    
    func mostraLaFine()
    {
        //INVIAMO.
        showIndicator();
        
        let resources = domandeList.map({ ["IDDomanda": $0.IDDomanda, "Risposte": $0.getRisposteSelezionate().map({["IDRisposta":$0.IDRisposta, "Valore":$0.TestoDato]}) ] })
        
        
       do {
            let jsonData = try JSONSerialization.data(withJSONObject: resources, options: .prettyPrinted)
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
       
        
        if (ConnectionCheck.isConnectedToNetwork() == false){return;}
                      
                      let parameters: Parameters = [
                          "action": "saveQuestionario",
                          "IDProtocollo":GeneralUtil.shared.crtProtocollo.IDProtocollo!,
                         "token": GeneralUtil.shared.user.token!,
                        "Domande": jsonToString(json: decoded as AnyObject)
                        
                      ]
                       print(parameters);
                       Alamofire.request(Utility.getBaseUrl(), method: .post, parameters: parameters)
                          .responseString { response in
                              print("DETTAGLI SAVE QUESTIONARIO")
                              print(response);
                          }
                          .responseJSON {response in
                              
                            
                            do {
                                let jsonArray = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! NSMutableArray //parse del data.
                                for jsonObject in jsonArray { //riempiamo l'array.
                                    if let dataArr = ResponseLoginQuestionario(from: jsonObject as AnyObject) {
                                        //self.arrShopping.append(dataArr)
                                        if (dataArr.message == "")
                                        {
                                            self.ringraziamentoFinale();
                                        }
                                        else
                                        {
                                            //MOSTRA MESSAGGIO
                                            self.ringraziamentoFinale();
                                            self.showMessaggio(strMessage: dataArr.message);
                                        }
                                    }
                                }
                                
                                
                                //self.tableRicerca.reloadData()
                                
                            }
                            catch {
                                print("Error: (Retrieving Data)")
                            }
                            
                            
                          }
                              
                           
            
        
       }
       catch {
                   print("ERRORE DECODIFICA")
       }
    }

    
}

class SubclassedUIButton: UIButton {
    var cntText: UITextView?
}
