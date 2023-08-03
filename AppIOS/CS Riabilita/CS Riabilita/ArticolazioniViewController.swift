//
//  ArticolazioniViewController.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 31/08/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import UIKit
import Alamofire

class ArticolazioniViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet var imgClose: UIImageView!
    
    @IBOutlet var imgSagoma: UIImageView!
    @IBOutlet var lblDescr: UILabel!
    @IBOutlet var lblTitle: UILabel!
    var infoToClose:InfoViewController!
    
    var articolazioni:[Articolazione] = [Articolazione]()
    var articolazioniImg:[UIView] = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGestureRecognizerEntra = UITapGestureRecognizer(target: self, action:  #selector(chiudi))
        imgClose.isUserInteractionEnabled = true
        imgClose.addGestureRecognizer(tapGestureRecognizerEntra)
        lblDescr.text = Utility.getLbl(code: "DESCRARTICOLAZIONI")
        // Do any additional setup after loading the view.
        infoToClose.dismiss(animated: false, completion: nil)
        loadArticolazioni(side:"FRONTE");
    }

    @IBAction func cambiaFronte(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0)
        {
            //FRONTE
            loadArticolazioni(side: "FRONTE")
        }
        else
        {
            //RETRO
            loadArticolazioni(side: "RETRO")
        }
    }
    
    @objc func chiudi()
          {
            self.dismiss(animated: false, completion: nil)
          }
    

    override func viewWillAppear(_ animated: Bool) {
             Utility.setGradientBackground(v:self.view)
             super.viewWillAppear(animated)
        print("DISMISSO")
        if ( GeneralUtil.shared.howMuchDismiss > 0)
        {
            GeneralUtil.shared.howMuchDismiss =  GeneralUtil.shared.howMuchDismiss - 1;
            self.dismiss(animated: false, completion: nil)
        }
       }
    
    func loadArticolazioni(side: String)
    {
        if (ConnectionCheck.isConnectedToNetwork() == false){return;}
        
        self.articolazioni.removeAll();
         for art in articolazioniImg
            {
                art.removeFromSuperview()
            }
        
        let parameters: Parameters = [
            "action": "getArticolazioni",
            "IDLocation": GeneralUtil.shared.idLocation
        ]
        
        if (side == "FRONTE")
         {
            imgSagoma.image = UIImage(named: "sagoma")
        }
        else
        {
            imgSagoma.image = UIImage(named: "sagoma_retro")
        }
        
        Alamofire.request(Utility.getBaseUrl(), method: .post, parameters: parameters)
            .responseString { response in
              
                //print(response);
                
              
                
            }
            .responseJSON {response in
                
                do {
                    //GeneralUtil.shared.labelsArray = [Label](); //instanziamo nuovo array
                    let jsonArray = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! NSMutableArray //parse del data.
                    // Looping through jsonArray
                    for jsonObject in jsonArray { //riempiamo l'array.
                        if let dataArr = Articolazione(from: jsonObject as AnyObject) {
                            print(dataArr.Nome + "  " + dataArr.IDArticolazione)
                            if (dataArr.side == side)
                            {
                                self.articolazioni.append(dataArr)
                                self.creaArticolazione(a:dataArr);
                            }
                        }
                    }
                   
                    //loaded.
                    
                }
                catch {
                    print("Error: (Retrieving Data LABLE)")
                }
                
                
                //var l = mainArray[0] //SAMPLE
                //print(l.code as! String);
              
                
        }
    }
    
    func creaArticolazione(a:Articolazione)
    {
        var x = 0;
        var y = 0;
        
        if (a.IDArticolazione == "1") //GINOCCHIO
        {
            x = Int(imgSagoma.bounds.size.width / 2) + 25;
            y = Int(imgSagoma.bounds.size.height - imgSagoma.bounds.size.height / 3) + 30;
        }
        else if (a.IDArticolazione == "4") //GOMITO
        {
            x = Int(imgSagoma.bounds.size.width) - Int(imgSagoma.bounds.size.width / 4);
            y = Int(imgSagoma.bounds.size.height / 2) - 70;
        }
        else if (a.IDArticolazione == "3") //SPALLA
        {
            x = Int(imgSagoma.bounds.size.width / 2) - 60
            y = Int(imgSagoma.bounds.size.height / 4) - 5
        }
        else if (a.IDArticolazione == "5") //POLSO
        {
            x = Int(imgSagoma.bounds.size.width / 4) - 20;
            y = Int(imgSagoma.bounds.size.height / 2) - 30;
        }
        else if (a.IDArticolazione == "6") //MANO
        {
            x = Int(imgSagoma.bounds.size.width) - Int(imgSagoma.bounds.size.width / 4) + 20;
            y = Int(imgSagoma.bounds.size.height / 2) - 5;
        }
        else if (a.IDArticolazione == "7") //ANCA
        {
            x = Int(imgSagoma.bounds.size.width) - Int(imgSagoma.bounds.size.width / 4) - 55;
            y = Int(imgSagoma.bounds.size.height / 2) + 30;
        }
        else if (a.IDArticolazione == "8") //CAVIGLIA
        {
                  x = Int(imgSagoma.bounds.size.width / 2) + 20;
                  y = Int(imgSagoma.bounds.size.height) - 70;
        }
        else if (a.IDArticolazione == "9") //PIEDE
        {
                  x = Int(imgSagoma.bounds.size.width / 4) + 20;
                  y = Int(imgSagoma.bounds.size.height) - 45;
        }
        else if (a.IDArticolazione == "10") //COLONNA CERVICALE
               {
                         x = Int(imgSagoma.bounds.size.width / 2) - 10
                         y = Int(imgSagoma.bounds.size.height / 2) - 190
               }
        else if (a.IDArticolazione == "11") //COLONNA DORSALE
               {
                         x = Int(imgSagoma.bounds.size.width / 2) - 10
                         y = Int(imgSagoma.bounds.size.height / 2) - 100
               }
        else if (a.IDArticolazione == "12") //COLONNA LOMBARE
               {
                         x = Int(imgSagoma.bounds.size.width / 2) - 10
                         y = Int(imgSagoma.bounds.size.height / 2) - 20
               }
       
        if (x != 0 && y != 0)
        {
            let uArt = UIView(frame: CGRect(x:x, y: y, width: 30 , height: 30))
            uArt.layer.cornerRadius = 15;
            uArt.alpha = 0.5
            uArt.backgroundColor = Utility.hexStringToUIColor(hex: "#ffd800")
            
            let uArtCuore = UIView(frame: CGRect(x:x+3, y: y+3, width: 24 , height: 24))
            uArtCuore.layer.cornerRadius = 12;
            uArtCuore.backgroundColor = UIColor.yellow
           
            
            let tapGestureRecognizerArt = ArticolazioneTapGesture(target: self, action: #selector(self.tapArticolazione(_:)))
            tapGestureRecognizerArt.idart = a.IDArticolazione;
            tapGestureRecognizerArt.coverimg = a.ImageUrl;
            tapGestureRecognizerArt.nomeart = a.Nome
            uArt.isUserInteractionEnabled = true
            uArtCuore.isUserInteractionEnabled = true
            uArt.addGestureRecognizer(tapGestureRecognizerArt)
            uArtCuore.addGestureRecognizer(tapGestureRecognizerArt)
            
            self.imgSagoma.isUserInteractionEnabled = true
            self.imgSagoma.addSubview(uArt);
            self.imgSagoma.addSubview(uArtCuore)
            articolazioniImg.append(uArtCuore)
            articolazioniImg.append(uArt)
            animalo(uArt: uArt);
        }
      
    }
    
    func animalo(uArt:UIView)
    {
        UIView.animate(withDuration:1.0,
        animations: {
            uArt.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        },
        completion: { _ in
            UIView.animate(withDuration: 1.0) {
                uArt.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                self.animalo(uArt: uArt)
            }
        })
    }
    
       
    @objc func tapArticolazione(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        let artGest = sender as! ArticolazioneTapGesture;
        print(artGest.idart)
        
        DispatchQueue.main.async(){
                    let vc = ArticolazioneDetailViewController()
                    vc.idart = artGest.idart;
                    vc.coverimg = artGest.coverimg;
                    vc.nomeart = artGest.nomeart
                    vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                    self.present(vc, animated: false, completion: nil)
        }
    }

}

class ArticolazioneTapGesture: UITapGestureRecognizer {
    var idart = ""
    var coverimg = "";
    var nomeart = "";
}
