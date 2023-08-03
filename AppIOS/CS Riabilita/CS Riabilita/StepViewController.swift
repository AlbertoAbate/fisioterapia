//
//  StepViewController.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 02/09/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import PMAlertController

class StepViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   var infoToClose:InfoViewController!
   
    @IBOutlet var bttAutovalutazione: UIButton!
    @IBOutlet var lblDescr: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgClose: UIImageView!
    @IBOutlet var tableStep: UITableView!
     var stepList = [StepProtocollo]()
    var blurEffectView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bttAutovalutazione.isHidden = true;
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isHidden = true;
        blurEffectView.alpha = 0.85;
        self.view.addSubview(blurEffectView)
        
        let tapGestureRecognizerEntra = UITapGestureRecognizer(target: self, action:  #selector(chiudi))
        imgClose.isUserInteractionEnabled = true
        imgClose.addGestureRecognizer(tapGestureRecognizerEntra)
       
        lblTitle.text = GeneralUtil.shared.crtProtocollo.Nome;
        lblDescr.text = GeneralUtil.shared.crtProtocollo.Testo;
        // Do any additional setup after loading the view.
        infoToClose.dismiss(animated: false, completion: nil)
        bttAutovalutazione.setTitle(Utility.getLbl(code: "BTTAUTOVALUTAZIONE"), for: .normal)
        bttAutovalutazione.layer.cornerRadius = 10;
        
        
        tableStep.register(UINib(nibName: "StepTableViewCell", bundle: nil), forCellReuseIdentifier: "StepTableViewCell")
                      tableStep.delegate = self
                      tableStep.dataSource = self
        loadStep();
        loadQuestionario();
    }

    func loadQuestionario()
    {
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
                    print("QUESTIONARIO RISULTATI")
                  if (jsonArray.count > 0)
                  {
                    self.bttAutovalutazione.isHidden = false;
                  }
                    
                }
                catch {
                    print("Error: (Retrieving Data)")
                }
                
                
                
        }
    }

    override func viewWillAppear(_ animated: Bool) {
             Utility.setGradientBackground(v:self.view)
             super.viewWillAppear(animated)
       }
    
    @objc func chiudi()
          {
            self.dismiss(animated: false, completion: nil)
          }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (stepList.isEmpty)
        {
             
             return 0
        }
        else
        {
            return stepList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let item: StepTableViewCell = tableStep.dequeueReusableCell(withIdentifier: "StepTableViewCell", for: indexPath) as! StepTableViewCell
                item.mainView.layer.cornerRadius = 10;
                item.mainView.clipsToBounds = true;
                item.title.text = stepList[indexPath.row].Titolo
                item.subtitle.text = stepList[indexPath.row].Sottotitolo
                
          
              
              return item;
          }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        let itemData:StepProtocollo!
        itemData = stepList[indexPath.row]
        
        DispatchQueue.main.async(){
        
                               DispatchQueue.main.async(){
                                       let vc = DettaglioStepViewController()
                                        vc.step = itemData;
                                       vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                                       self.present(vc, animated: true, completion: nil)
                               }
             }
        
        //FAI QUALCOSA:
        
    }
    
    @IBAction func showAutovalDolore(_ sender: UIButton) {
        
        if (GeneralUtil.shared.user == nil || GeneralUtil.shared.user.token == nil || GeneralUtil.shared.user.token == "")
        {
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
                                    vc.doveVado = "NIENTE";
                                   self.present(vc, animated: true, completion: nil)
                           }
                        });
                        
                        alertVC.addAction(pAct)
                    
                    let pActReg = PMAlertAction(title: Utility.getLbl(code: "REGISTRATI"), style: .default, action: { () -> Void in
                            self.blurEffectView.isHidden = true;
                            DispatchQueue.main.async(){
                                       let vc = RegistratiViewController()
                                       vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                                        vc.doveVado = "NIENTE";
                                       self.present(vc, animated: true, completion: nil)
                               }
                        });
                        
                        alertVC.addAction(pActReg)
            
            
                let pActCancel = PMAlertAction(title: Utility.getLbl(code: "CHIUDIMODALE"), style: .cancel, action: { () -> Void in
                    self.blurEffectView.isHidden = true;
                    
                });
                
                alertVC.addAction(pActCancel)
                self.present(alertVC, animated: true, completion: nil)
            
            return;
        }
        
        DispatchQueue.main.async(){
                let vc = AutoValutazioneViewController()
                vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                self.present(vc, animated: true, completion: nil)
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
    
    func loadStep()
    {
        showIndicator();
        if (ConnectionCheck.isConnectedToNetwork() == false){return;}
                      
                      let parameters: Parameters = [
                          "action": "getProtocolli",
                          "IDLocation": GeneralUtil.shared.idLocation,
                          //"IDArticolazione":patologia.IDArticolazione!,
                          "IDPatologia":GeneralUtil.shared.crtProtocollo.IDPatologia!,
                          "token":GeneralUtil.shared.user.token!,
                          "IDProtocollo":GeneralUtil.shared.crtProtocollo.IDProtocollo!
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
                                   self.stepList.removeAll();
                                  let jsonArray = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! NSArray
                                  // Looping through jsonArray
                                  for jsonObject in jsonArray { //riempiamo l'array.
                                       if let dataArr = Protocollo(from: jsonObject as AnyObject) {
                                            self.stepList = dataArr.step;
                                      }
                                  }
                               
                                  
                                  self.tableStep.reloadData();
                                  self.hideIndicator()
                                  
                              }
                              catch {
                                  print("Error: (Retrieving Data)")
                              }
                              
                              
                              
                      }
    }
    


   

}
