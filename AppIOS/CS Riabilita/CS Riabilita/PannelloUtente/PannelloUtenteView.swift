//
//  PannelloUtenteView.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 03/11/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import UIKit
import PMAlertController
import SwiftMessages
import Alamofire
/*
class PannelloUtenteView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var imgClose: UIImageView!
    @IBOutlet var tableProtocolli: UITableView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgScrivimi: UIImageView!
    @IBOutlet var imgMessage: UIImageView!
    @IBOutlet var imgLogout: UIImageView!
    @IBOutlet var lblInfoArea: UILabel!
    var protocolliList = [Protocollo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableProtocolli.register(UINib(nibName: "StepTableViewCell", bundle: nil), forCellReuseIdentifier: "StepTableViewCell")
        tableProtocolli.delegate = self
        tableProtocolli.dataSource = self
        
        //COMMENTATA PER TERAPISTA
        /*
         if (GeneralUtil.shared.user.terapista != "")
         {
         var strToHtml = "<span style='font-family:Hind; font-size:26px;text-align:center;color:#347b9c; margin-left:10px; margin-right:10px;'><b>&nbsp;&nbsp;"  + GeneralUtil.shared.user.cognome + " " +  GeneralUtil.shared.user.nome + "</b><br/><span style='font-size:16px;'>&nbsp;&nbsp;Terapista: <b>" + GeneralUtil.shared.user.terapista + "&nbsp;&nbsp;</b></span></span>";
         let myMutableString = try! NSMutableAttributedString(
         data:  strToHtml.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
         options: [ .documentType: NSAttributedString.DocumentType.html],
         documentAttributes: nil)
         
         lblTitle.attributedText = myMutableString;
         
         //lblTitle.text = lblTitle.text! + "\n Terapista: " + GeneralUtil.shared.user.terapista;
         }
         else
         {
         lblTitle.text = GeneralUtil.shared.user.cognome + " " +  GeneralUtil.shared.user.nome
         }
         lblInfoArea.text = Utility.getLbl(code: "INFOAREARISERVATA");
         imgMessage.layer.cornerRadius = 30;
         imgScrivimi.layer.cornerRadius = 30;
         
         let tapGestureRecognizerEntra = UITapGestureRecognizer(target: self, action:  #selector(chiudi))
         imgClose.isUserInteractionEnabled = true
         imgClose.addGestureRecognizer(tapGestureRecognizerEntra)
         
         let tapGestureRecognizerEsci = UITapGestureRecognizer(target: self, action:  #selector(askLogout))
         imgLogout.isUserInteractionEnabled = true
         imgLogout.addGestureRecognizer(tapGestureRecognizerEsci)
         
         let tapGestureRecognizerScrivi = UITapGestureRecognizer(target: self, action:  #selector(showScrivi))
         imgScrivimi.isUserInteractionEnabled = true
         imgScrivimi.addGestureRecognizer(tapGestureRecognizerScrivi)
         
         let tapGestureRecognizerMsg = UITapGestureRecognizer(target: self, action:  #selector(showMsg))
         imgMessage.isUserInteractionEnabled = true
         imgMessage.addGestureRecognizer(tapGestureRecognizerMsg)
         
         loadData();
         // Do any additional setup after loading the view.
         }*/
        
        @objc func showScrivi()
        {
            DispatchQueue.main.async(){
                let vc = ScriviViewController()
                vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                self.present(vc, animated: true, completion: nil)
            }
        }
        
        @objc func showMsg()
        {
            DispatchQueue.main.async(){
                let vc = MessaggiViewController()
                vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                self.present(vc, animated: true, completion: nil)
            }
        }
        
        @objc func askLogout()
        {
            let alertVC = PMAlertController(title: Utility.getLbl(code: "TITLEASKESCI"), description: Utility.getLbl(code: "BODYASKESCI"), image: nil, style: .alert) //Image by freepik.com, taken on flaticon.com
            alertVC.headerViewTopSpaceConstraint.constant = 10
            alertVC.alertContentStackViewLeadingConstraint.constant = 10
            alertVC.alertContentStackViewTrailingConstraint.constant = 10
            alertVC.alertContentStackViewTopConstraint.constant = 10
            alertVC.alertActionStackViewLeadingConstraint.constant = 10
            alertVC.alertActionStackViewTrailingConstraint.constant = 10
            alertVC.alertActionStackViewTopConstraint.constant = 10
            alertVC.alertActionStackViewBottomConstraint.constant = 10
            //alertVC.alertTitle.textColor = UIColor(named:"Extradark")
            alertVC.alertTitle.textColor = Utility.hexStringToUIColor(hex: "#347b9c")
            alertVC.alertDescription.textColor = Utility.hexStringToUIColor(hex: "#347b9c")
            
            let imgBg = UIImage.from(color: Utility.hexStringToUIColor(hex: "#347b9c"));
            
            alertVC.alertMaskBackground.image = imgBg;
            alertVC.alertMaskBackground.alpha = 0.85
            
            alertVC.view.layoutIfNeeded()
            let act = PMAlertAction(title: Utility.getLbl(code: "ANNULLA"), style: .cancel, action: { () in
                
                
            })
            alertVC.addAction(act)
            
            let actEsc = PMAlertAction(title: Utility.getLbl(code: "ESCI"), style: .default, action: { () in
                
                GeneralUtil.shared.user.logout()
                self.dismiss(animated: true, completion: nil)
            })
            alertVC.addAction(actEsc)
            self.present(alertVC, animated: true, completion: nil)
        }
        
        func showIndicator()
        {
            self.showSpinner(onView: self.view)
        }
        
        func hideIndicator()
        {
            self.removeSpinner()
        }
        
        func loadData()
        {
            showIndicator();
            if (ConnectionCheck.isConnectedToNetwork() == false){return;}
            
            let parameters: Parameters = [
                "action": "getProtocolli",
                "IDLocation": GeneralUtil.shared.idLocation,
                //"IDArticolazione":patologia.IDArticolazione!,
                "IDPatologia":"",
                "token":GeneralUtil.shared.user.token!,
                "IDProtocollo":""
            ]
            print(parameters);
            Alamofire.request(Utility.getBaseUrl(), method: .post, parameters: parameters)
                .responseString { response in
                    print("DETTAGLI PATOLOGIE")
                    print(response);
                }
                .responseJSON {response in
                    
                    print(response);
                    do {
                        self.protocolliList.removeAll();
                        let jsonArray = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! NSArray
                        // Looping through jsonArray
                        for jsonObject in jsonArray { //riempiamo l'array.
                            if let dataArr = Protocollo(from: jsonObject as AnyObject) {
                                self.protocolliList.append(dataArr);
                            }
                        }
                        
                        if (self.protocolliList.count == 0)
                        {
                            TableViewHelper.EmptyMessage(message: Utility.getLbl(code: "EMPTYPROTOCOLLI"), viewController: self.tableProtocolli)
                            
                        }
                        else
                        {
                            TableViewHelper.EmptyMessage(message: "", viewController: self.tableProtocolli)
                            
                        }
                        
                        
                        self.tableProtocolli.reloadData();
                        self.hideIndicator()
                        
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
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if (protocolliList.isEmpty)
            {
                
                return 0
            }
            else
            {
                return protocolliList.count
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let item: StepTableViewCell = tableProtocolli.dequeueReusableCell(withIdentifier: "StepTableViewCell", for: indexPath) as! StepTableViewCell
            item.title.text = protocolliList[indexPath.row].Nome
            item.subtitle.text = protocolliList[indexPath.row].Patologia
            item.mainView.layer.cornerRadius = 10;
            item.mainView.clipsToBounds = true;
            print("VISIB:" + protocolliList[indexPath.row].Visibilita)
            /*if (protocolliList[indexPath.row].Visibilita == "PUBBLICA" )
             {
             item.imgLock.isHidden = true;
             }
             else
             {
             item.imgLock.isHidden = false;
             }*/
            //item.lblAddress.text = addressList[indexPath.row].mailingAddress;
            
            return item;
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            
            let itemData:Protocollo!
            itemData = protocolliList[indexPath.row]
            //if (itemData.Visibilita == "PUBBLICA")
            //{
            GeneralUtil.shared.crtProtocollo = itemData;
            DispatchQueue.main.async(){
                
                DispatchQueue.main.async(){
                    let vc = InfoViewController()
                    vc.type = "PROTOCOLLISTEP";
                    vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                    self.present(vc, animated: true, completion: nil)
                }
            }
            /*}
             else
             {
             //ACQUISTA MESSAGGIO.
             }*/
            
            
        }
        
    }
}*/
