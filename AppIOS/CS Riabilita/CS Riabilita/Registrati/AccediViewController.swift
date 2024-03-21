//
//  AccediViewController.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 03/11/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import UIKit
import Alamofire
import SwiftMessages
import PMAlertController

class AccediViewController: UIViewController {

    @IBOutlet var bttrecuperaPass: UIButton!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgClose: UIImageView!
    @IBOutlet var lblInfoAccedi: UILabel!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPass: UITextField!
    @IBOutlet weak var txtTel: UITextField!
    @IBOutlet var bttRegistrati: UIButton!
    var doveVado:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bttrecuperaPass.isHidden = true
        
        lblTitle.text = Utility.getLbl(code: "ACCEDITITLE");
        lblInfoAccedi.text = Utility.getLbl(code: "INFOACCEDI")
        bttRegistrati.setTitle(Utility.getLbl(code: "ENTRA"), for: .normal)
        bttrecuperaPass.setTitle(Utility.getLbl(code: "RECUPERAPWD"), for: .normal)
        
        txtTel.textColor = UIColor.black
            txtPass.textColor = UIColor.black
            
            // Set the background color of txtTel and txtPass to white
            txtTel.backgroundColor = UIColor.white
            txtPass.backgroundColor = UIColor.white
            
            // Set the placeholder text color for txtTel and txtPass to black
            txtTel.attributedPlaceholder = NSAttributedString(string: "Telefono...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            txtPass.attributedPlaceholder = NSAttributedString(string: "Codice Fiscale...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        // Do any additional setup after loading the view.
        bttRegistrati.layer.cornerRadius = 10;
        let tapGestureRecognizerEntra = UITapGestureRecognizer(target: self, action:  #selector(chiudi))
        imgClose.isUserInteractionEnabled = true
        imgClose.addGestureRecognizer(tapGestureRecognizerEntra)
        
        // Set secure text entry for password field
        txtPass.isSecureTextEntry = true
        txtTel.isSecureTextEntry = false
        txtTel.keyboardType = .numberPad

    }


    @IBAction func showRecuperaPwd(_ sender: UIButton) {
        var txtEmail:UITextField!
        
        let alertVC = PMAlertController(title: Utility.getLbl(code: "RECPWDTITLE"), description: Utility.getLbl(code: "RECPWDESCR"), image: nil, style: .walkthrough) //Image by freepik.com, taken on flaticon.com
        alertVC.headerViewTopSpaceConstraint.constant = 10
        alertVC.alertContentStackViewLeadingConstraint.constant = 10
        alertVC.alertContentStackViewTrailingConstraint.constant = 10
        alertVC.alertContentStackViewTopConstraint.constant = 10
        alertVC.alertActionStackViewLeadingConstraint.constant = 10
        alertVC.alertActionStackViewTrailingConstraint.constant = 10
        alertVC.alertActionStackViewTopConstraint.constant = 10
        alertVC.alertActionStackViewBottomConstraint.constant = 10
        //alertVC.alertTitle.textColor = UIColor(named:"Extradark")
        alertVC.alertTitle.textColor = Utility.hexStringToUIColor(hex: "#02597d")
        alertVC.alertDescription.textColor = Utility.hexStringToUIColor(hex: "#347b9c")
        let imgBg = UIImage.from(color: Utility.hexStringToUIColor(hex: "#56a600"));
        
        alertVC.alertMaskBackground.image = imgBg;
        alertVC.alertMaskBackground.alpha = 0.85
        
        alertVC.view.layoutIfNeeded()

        
        alertVC.addTextField { (textField) in
            textField?.placeholder = "E-mail..."
            textField?.textColor = UIColor.black
            
            textField?.tag = 0;
            txtEmail = textField!;
            if #available(iOS 13.0, *) {
                textField?.overrideUserInterfaceStyle = .light
            } else {
                // Fallback on earlier versions
            }
            //textField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        }
       
        let pAct = PMAlertAction(title: Utility.getLbl(code: "RECUPERA"), style: .default, action: { () -> Void in
            self.recuperaPwd(vc: self,email: txtEmail.text!);
        });
        alertVC.addAction(pAct)
        
        let pActAnn = PMAlertAction(title: Utility.getLbl(code: "ANNULLA"), style: .cancel, action: { () in
           
        })
        alertVC.addAction(pActAnn)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func recuperaPwd(vc:AccediViewController, email:String )
    {
        if (ConnectionCheck.isConnectedToNetwork() == false){return;}
        
        let parameters: Parameters = [
            "action": "recuperoPassword",
            "email": email,
            "IDLocation": GeneralUtil.shared.idLocation
        ]
        Alamofire.request(Utility.getBaseUrl(), method: .post, parameters: parameters)
            .responseString { response in
                print("RECUPERO")
                print(response);
            }
            .responseJSON {response in
                
                print(response);
                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! NSArray
                    // Looping through jsonArray
                    for jsonObject in jsonArray { //riempiamo l'array.
                        
                        let res = (jsonObject as AnyObject).object(forKey: "status") as? String;
                        if (res == "OK")
                        {
                            vc.showDoneRecupera();
                        }
                        else
                        {
                            vc.showErr(title:Utility.getLbl(code: "NOPWDREC"), body:"");
                        }
                        
                    }
                    
                    
                    
                    
                }
                catch {
                    print("Error: (Retrieving Data)")
                }
                
                
                
        }
    }
    
    func showErr(title:String, body:String)
    {
        let alertVC = PMAlertController(title: title, description: body, image: nil, style: .alert) //Image by freepik.com, taken on flaticon.com
        alertVC.headerViewTopSpaceConstraint.constant = 10
        alertVC.alertContentStackViewLeadingConstraint.constant = 10
        alertVC.alertContentStackViewTrailingConstraint.constant = 10
        alertVC.alertContentStackViewTopConstraint.constant = 10
        alertVC.alertActionStackViewLeadingConstraint.constant = 10
        alertVC.alertActionStackViewTrailingConstraint.constant = 10
        alertVC.alertActionStackViewTopConstraint.constant = 10
        alertVC.alertActionStackViewBottomConstraint.constant = 10
        //alertVC.alertTitle.textColor = UIColor(named:"Extradark")
        let imgBg = UIImage.from(color: Utility.hexStringToUIColor(hex: "#56a600"));
        
        alertVC.alertMaskBackground.image = imgBg;
        alertVC.alertMaskBackground.alpha = 0.85
        
        alertVC.view.layoutIfNeeded()
        
        let pAct = PMAlertAction(title: Utility.getLbl(code: "HOCAPITO"), style: .default, action: { () in
            
            //self.doEsci();
        });
        alertVC.addAction(pAct)
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    func showDoneRecupera()
    {
        let alertVC = PMAlertController(title: Utility.getLbl(code: "RECPWD"), description:  Utility.getLbl(code: "DESCRRECPWDOK"), image: nil, style: .alert) //Image by freepik.com, taken on flaticon.com
        alertVC.headerViewTopSpaceConstraint.constant = 10
        alertVC.alertContentStackViewLeadingConstraint.constant = 10
        alertVC.alertContentStackViewTrailingConstraint.constant = 10
        alertVC.alertContentStackViewTopConstraint.constant = 10
        alertVC.alertActionStackViewLeadingConstraint.constant = 10
        alertVC.alertActionStackViewTrailingConstraint.constant = 10
        alertVC.alertActionStackViewTopConstraint.constant = 10
        alertVC.alertActionStackViewBottomConstraint.constant = 10
        //alertVC.alertTitle.textColor = UIColor(named:"Extradark")
        let imgBg = UIImage.from(color: Utility.hexStringToUIColor(hex: "#56a600"));
        
        alertVC.alertMaskBackground.image = imgBg;
        alertVC.alertMaskBackground.alpha = 0.85
        
        alertVC.view.layoutIfNeeded()
        
        let pAct = PMAlertAction(title: Utility.getLbl(code: "CHIUDI"), style: .default, action: { () in
        
            //self.doEsci();
        })
        alertVC.addAction(pAct)
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @objc func chiudi() {
        let accessoViewController = AccessoViewController()
        self.present(accessoViewController, animated: true, completion: nil)
    }

    @IBAction func doEntra(_ sender: UIButton) {
        if (txtTel.text == "" || txtPass.text == "")
        {
            showError(txt:Utility.getLbl(code: "ERRFIELD"));
            return;
        }
        
        //proviamo il login.
        bttRegistrati.isEnabled = false;
        if (ConnectionCheck.isConnectedToNetwork() == false){return;}
        let parameters: Parameters = [
            "action": "loginUser2023",
            "pwd": txtPass.text!,
            "phone": txtTel.text!
            
        ]
        
        print(parameters)
        
        Alamofire.request(Utility.getBaseUrl(), method: .post, parameters: parameters)
            .responseString { response in
                print(response);
            }
            .responseJSON {response in
                //print("SONO QUI JSON")
                
                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! NSMutableArray //parse del data.
                    for jsonObject in jsonArray { //riempiamo l'array.
                        if let dataArr = ResponseLogin(from: jsonObject as AnyObject) {
                            //self.arrShopping.append(dataArr)
                            self.bttRegistrati.isEnabled = true;
                            if (dataArr.status == "KO")
                            {
                                DispatchQueue.main.async(){
                                        self.showError(txt: Utility.getLbl(code: "ERRORLOGIN"))
                                }
                            }
                            else if (dataArr.status == "OK")
                            {
                                
                                
                                //print("risultato token: ",dataArr.utente.token)
                                dataArr.utente.initTopic();
                                dataArr.utente.saveUtente();
                                dataArr.utente.saveLocation();
                                //GeneralUtil.shared.ordine.utente = dataArr.utente;
                                //dataArr.utente.initTopic();
                                
                                self.showMsgLoginOK(title: Utility.getLbl(code: "BENVENUTO") + " " + dataArr.utente.nome, body: Utility.getLbl(code: "ACCESSOOK"))
                                //self.txtUsername.text = "";
                                //self.txtPassword.text = "";
                                //self.arvc.reinitView()
                                
                               // GeneralUtil.shared.bottomMenu.createFABAngel()
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
    
    func showMsgLoginOK(title:String, body:String)
    {
        let alertVC = PMAlertController(title: title, description: body, image: nil, style: .alert) //Image by freepik.com, taken on flaticon.com
        alertVC.headerViewTopSpaceConstraint.constant = 10
        alertVC.alertContentStackViewLeadingConstraint.constant = 10
        alertVC.alertContentStackViewTrailingConstraint.constant = 10
        alertVC.alertContentStackViewTopConstraint.constant = 10
        alertVC.alertActionStackViewLeadingConstraint.constant = 10
        alertVC.alertActionStackViewTrailingConstraint.constant = 10
        alertVC.alertActionStackViewTopConstraint.constant = 10
        alertVC.alertActionStackViewBottomConstraint.constant = 10
        //alertVC.alertTitle.textColor = UIColor(named:"Extradark")
        alertVC.alertTitle.textColor = Utility.hexStringToUIColor(hex: "#02597d")
        alertVC.alertDescription.textColor = Utility.hexStringToUIColor(hex: "#347b9c")
        
        let imgBg = UIImage.from(color: Utility.hexStringToUIColor(hex: "#56a600"));
        
        alertVC.alertMaskBackground.image = imgBg;
        alertVC.alertMaskBackground.alpha = 0.85
        
        alertVC.view.layoutIfNeeded()
        let act = PMAlertAction(title: Utility.getLbl(code: "OK"), style: .default, action: { () in
          
            if (self.doveVado != "NIENTE")
            {
            DispatchQueue.main.async(){
                           let vc = SchermataViewController()
                           vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                           self.present(vc, animated: true, completion: nil)
                   }
            }
            self.dismiss(animated: true, completion: nil)
            
        })
        alertVC.addAction(act)
        self.present(alertVC, animated: true, completion: nil)
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
    
}
