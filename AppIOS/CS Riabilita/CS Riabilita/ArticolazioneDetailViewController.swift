//
//  ArticolazioneDetailViewController.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 01/09/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ArticolazioneDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var imgClose: UIImageView!
    var idart:String!;
    var coverimg:String!
    @IBOutlet var imgCover: UIImageView!
    var patologieList = [Patologia]()
    var nomeart:String!
    @IBOutlet var lblTitlePatologie: UILabel!
    @IBOutlet var lblNomeArt: UILabel!
    
    @IBOutlet var tablePatologie: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizerEntra = UITapGestureRecognizer(target: self, action:  #selector(chiudi))
               imgClose.isUserInteractionEnabled = true
               imgClose.addGestureRecognizer(tapGestureRecognizerEntra)
        setGradientCover(v: imgCover);
        tablePatologie.register(UINib(nibName: "PatologieTableViewCell", bundle: nil), forCellReuseIdentifier: "PatologieTableViewCell")
        tablePatologie.delegate = self
        tablePatologie.dataSource = self
        
        let url = URL(string: Utility.getBaseImgUrl() + coverimg)
        imgCover.af_setImage(withURL: url!)
        lblNomeArt.text = nomeart;
        lblTitlePatologie.text = Utility.getLbl(code: "DESCRIZIONEPATOLOGIE")
        loadData();
       

    }

    
    func loadData()
    {
        showIndicator();
        if (ConnectionCheck.isConnectedToNetwork() == false){return;}
                      
                      let parameters: Parameters = [
                          "action": "getPatologie",
                          "IDLocation": GeneralUtil.shared.idLocation,
                          "IDArticolazione":idart!,
                          "IDPatologia":""
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
                                   self.patologieList.removeAll();
                                  let jsonArray = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! NSArray
                                  // Looping through jsonArray
                                  for jsonObject in jsonArray { //riempiamo l'array.
                                       if let dataArr = Patologia(from: jsonObject as AnyObject) {
                                          self.patologieList.append(dataArr);
                                      }
                                  }
                               
                                  
                                  self.tablePatologie.reloadData();
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
    
    @objc func chiudi()
             {
               self.dismiss(animated: false, completion: nil)
             }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
       
               Utility.setGradientBackground(v:self.view)
               super.viewWillAppear(animated)
            
            
               
               
    }

    
     func setGradientCover(v:UIView) {
          let colorTop =  UIColor(red: 81.0/255.0, green: 139.0/255.0, blue: 171.0/255.0, alpha: 0.0).cgColor
          let colorBottom = UIColor(red: 81.0/255.0, green: 139.0/255.0, blue: 171.0/255.0, alpha: 1.0).cgColor
                      
          let gradientLayer = CAGradientLayer()
          gradientLayer.colors = [colorTop, colorBottom]
          gradientLayer.locations = [0.0, 1.0]
           gradientLayer.frame = v.bounds
                  
          v.layer.insertSublayer(gradientLayer, at:0)
      }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (patologieList.isEmpty)
        {
             
             return 0
        }
        else
        {
            return patologieList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let item: PatologieTableViewCell = tablePatologie.dequeueReusableCell(withIdentifier: "PatologieTableViewCell", for: indexPath) as! PatologieTableViewCell
                item.lblNome.text = patologieList[indexPath.row].Nome
                item.mainView.layer.cornerRadius = 10;
                item.mainView.clipsToBounds = true;
        
               //item.lblAddress.text = addressList[indexPath.row].mailingAddress;
              
              return item;
          }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let itemData:Patologia!
        itemData = patologieList[indexPath.row]
       DispatchQueue.main.async(){
   
                          let vc = ProtocolliViewController()
                           vc.patologia = itemData;
        print(itemData);
                           vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                           self.present(vc, animated: false, completion: nil)
        }
        
        
    }
    
}

var vSpinner : UIView?
 
extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
