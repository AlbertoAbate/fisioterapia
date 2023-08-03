//
//  ProtocolliViewController.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 01/09/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import PMAlertController

class ProtocolliViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var imgClose: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var tableProtocolli: UITableView!
     var protocolliList = [Protocollo]()
    
    @IBOutlet var bttTornaHome: UIButton!
    @IBOutlet var lblTitoloPatologia: UILabel!
    var patologia:Patologia!
    var blurEffectView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizerEntra = UITapGestureRecognizer(target: self, action:  #selector(chiudi))
               imgClose.isUserInteractionEnabled = true
               imgClose.addGestureRecognizer(tapGestureRecognizerEntra)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isHidden = true;
        blurEffectView.alpha = 0.85;
        self.view.addSubview(blurEffectView)
        
        
        
               tableProtocolli.register(UINib(nibName: "ProtocolloTableViewCell", bundle: nil), forCellReuseIdentifier: "ProtocolloTableViewCell")
               tableProtocolli.delegate = self
               tableProtocolli.dataSource = self
        lblTitoloPatologia.text = patologia.Nome;
        var patologiaTesto = patologia.Testo;
        if (patologiaTesto!.count > 150)
        {
            patologiaTesto = "<span style='font-family:Hind; font-size:16px;text-align:center;color:#FFFFFF'>" + patologiaTesto!.prefix(150) + "...<b><u>" + Utility.getLbl(code: "LEGGITUTTO") + "</b></u></span>";
        }
        
        let myMutableString = try! NSMutableAttributedString(
            data:  patologiaTesto!.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [ .documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
            
            lblTitle.attributedText = myMutableString;
            lblTitle.isUserInteractionEnabled = true;
            
             let tapGestureRecognizerLeggiTutto = UITapGestureRecognizer(target: self, action:  #selector(leggiTutto))
             lblTitle.addGestureRecognizer(tapGestureRecognizerLeggiTutto)
        
            loadData();
        
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func doTornaHome(_ sender: UIButton) {
        GeneralUtil.shared.howMuchDismiss = 1;
        


    }
    
    @objc func leggiTutto()
    {
        
        
        DispatchQueue.main.async(){ [self] in
                let vc = LeggiTuttoViewController()
                vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                
                self.present(vc, animated: true, completion: nil)
            vc.lblContent.text = patologia.Testo;
        }
        
    }
    
    @objc func chiudi()
            {
              self.dismiss(animated: false, completion: nil)
            }

    
    func loadData()
     {
         showIndicator();
         if (ConnectionCheck.isConnectedToNetwork() == false){return;}
                       
                       let parameters: Parameters = [
                           "action": "getProtocolli",
                           "IDLocation": GeneralUtil.shared.idLocation,
                           //"IDArticolazione":patologia.IDArticolazione!,
                           "IDPatologia":patologia.IDPatologia!,
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
                                
                                   
                                   self.tableProtocolli.reloadData();
                                   self.hideIndicator()
                                   
                               }
                               catch {
                                   print("Error: (Retrieving Data)")
                               }
                               
                               
                               
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
     
     
       override func viewWillAppear(_ animated: Bool) {
                Utility.setGradientBackground(v:self.view)
                super.viewWillAppear(animated)
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
               let item: ProtocolloTableViewCell = tableProtocolli.dequeueReusableCell(withIdentifier: "ProtocolloTableViewCell", for: indexPath) as! ProtocolloTableViewCell
                 item.lblNome.text = protocolliList[indexPath.row].Nome
                 item.mainView.layer.cornerRadius = 10;
                 item.mainView.clipsToBounds = true;
                print("VISIB:" + protocolliList[indexPath.row].Visibilita)
                if (protocolliList[indexPath.row].Visibilita == "PUBBLICA" )
                {
                    item.imgLock.isHidden = true;
                }
                else
                {
                    item.imgLock.isHidden = false;
                }
                //item.lblAddress.text = addressList[indexPath.row].mailingAddress;
               
               return item;
           }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
        
         let itemData:Protocollo!
         itemData = protocolliList[indexPath.row]
        if (itemData.Visibilita == "PUBBLICA")
        {
            GeneralUtil.shared.crtProtocollo = itemData;
            DispatchQueue.main.async(){
        
                               DispatchQueue.main.async(){
                                       let vc = InfoViewController()
                                        vc.type = "PROTOCOLLISTEP";
                                       vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                                       self.present(vc, animated: true, completion: nil)
                               }
             }
        }
        else
        {
            //ACQUISTA MESSAGGIO.
            if (GeneralUtil.shared.user != nil && GeneralUtil.shared.user.token != nil && GeneralUtil.shared.user.token != "")
            {
                
            
                let alertVC = PMAlertController(title: Utility.getLbl(code: "SHOWTITLEACQUISTA"), description: Utility.getLbl(code: "SHOWBODYACQUISTA").replacingOccurrences(of: "[COSTO]", with: itemData.Prezzo + " €"), image: nil, style: .walkthrough) //Image by freepik.com, taken on flaticon.com
                    alertVC.headerViewTopSpaceConstraint.constant = 4
                    alertVC.alertContentStackViewLeadingConstraint.constant = 4
                    alertVC.alertContentStackViewTrailingConstraint.constant = 4
                    alertVC.alertContentStackViewTopConstraint.constant = 4
                    alertVC.alertActionStackViewLeadingConstraint.constant = 4
                    alertVC.alertActionStackViewTrailingConstraint.constant = 4
                    alertVC.alertActionStackViewTopConstraint.constant = 4
                    alertVC.alertActionStackViewBottomConstraint.constant = 4
                    alertVC.alertTitle.textColor = Utility.hexStringToUIColor(hex: "#02597d")
                    alertVC.alertDescription.textColor = Utility.hexStringToUIColor(hex: "#347b9c")
                    //alertVC.alertView.backgroundColor = Utility.hexStringToUIColor(hex: "#02597d")
                    //alertVC.alertImage.backgroundColor = Utility.hexStringToUIColor(hex: "#02597d")
                    //alertVC.alertContentStackView.backgroundColor = Utility.hexStringToUIColor(hex: "#FFFFFF")
                    blurEffectView.isHidden = false;
                    alertVC.view.layoutIfNeeded()
                    
                     let pAct = PMAlertAction(title: Utility.getLbl(code: "ACQUISTAORA"), style: .default, action: { () -> Void in
                            self.blurEffectView.isHidden = true;
                            
                    
                            
                        let url = URL(string: Utility.getBaseUrlPath() + "admin/stripe/public/pagaAttivazione.php?IDProtocollo=" + itemData.IDProtocollo + "&token=" + GeneralUtil.shared.user.token!)!

                            UIApplication.shared.open(url) { success in
                                if success {
                                    //self.ordinePaypalFatto()
                                }
                            }
                            
                        });
                        
                        alertVC.addAction(pAct)
                    
                 
            
                let pActCancel = PMAlertAction(title: Utility.getLbl(code: "NOGRAZIE"), style: .cancel, action: { () -> Void in
                    self.blurEffectView.isHidden = true;
                    
                });
                
                alertVC.addAction(pActCancel)
                self.present(alertVC, animated: true, completion: nil)
        }
        
        else
        {
            //ACCEDI O REGISTRATI PER ACQUISTARE:
            
            let alertVC = PMAlertController(title: Utility.getLbl(code: "SHOWTITLEACCOUNT"), description: Utility.getLbl(code: "SHOWBODYACCOUNT"), image: nil, style: .walkthrough) //Image by freepik.com, taken on flaticon.com
                    alertVC.headerViewTopSpaceConstraint.constant = 4
                    alertVC.alertContentStackViewLeadingConstraint.constant = 4
                    alertVC.alertContentStackViewTrailingConstraint.constant = 4
                    alertVC.alertContentStackViewTopConstraint.constant = 4
                    alertVC.alertActionStackViewLeadingConstraint.constant = 4
                    alertVC.alertActionStackViewTrailingConstraint.constant = 4
                    alertVC.alertActionStackViewTopConstraint.constant = 4
                    alertVC.alertActionStackViewBottomConstraint.constant = 4
                    alertVC.alertTitle.textColor = Utility.hexStringToUIColor(hex: "#02597d")
                    alertVC.alertDescription.textColor = Utility.hexStringToUIColor(hex: "#347b9c")
                    //alertVC.alertView.backgroundColor = Utility.hexStringToUIColor(hex: "#02597d")
                    //alertVC.alertImage.backgroundColor = Utility.hexStringToUIColor(hex: "#02597d")
                    //alertVC.alertContentStackView.backgroundColor = Utility.hexStringToUIColor(hex: "#FFFFFF")
                    blurEffectView.isHidden = false;
                    alertVC.view.layoutIfNeeded()
                    
                     let pAct = PMAlertAction(title: Utility.getLbl(code: "HOGIAACCOUNT"), style: .default, action: { () -> Void in
                            self.blurEffectView.isHidden = true;
                            DispatchQueue.main.async(){
                                   let vc = AccediViewController()
                                   vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                                   self.present(vc, animated: true, completion: nil)
                           }
                        });
                        
                        alertVC.addAction(pAct)
                    
                    let pActReg = PMAlertAction(title: Utility.getLbl(code: "REGISTRATI"), style: .default, action: { () -> Void in
                            self.blurEffectView.isHidden = true;
                            DispatchQueue.main.async(){
                                       let vc = RegistratiViewController()
                                       vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                                       self.present(vc, animated: true, completion: nil)
                               }
                        });
                        
                        alertVC.addAction(pActReg)
            
            
                let pActCancel = PMAlertAction(title: Utility.getLbl(code: "CHIUDIMODALE"), style: .cancel, action: { () -> Void in
                    self.blurEffectView.isHidden = true;
                    
                });
                
                alertVC.addAction(pActCancel)
                self.present(alertVC, animated: true, completion: nil)
        }
        
        }
     }
     

}
