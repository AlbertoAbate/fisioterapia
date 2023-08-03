//
//  DettaglioStepViewController.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 02/09/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import UIKit

class DettaglioStepViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet var imgClose: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescr: UILabel!
    @IBOutlet var tableDettaglioStep: UITableView!
    var step:StepProtocollo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

          let tapGestureRecognizerEntra = UITapGestureRecognizer(target: self, action:  #selector(chiudi))
              imgClose.isUserInteractionEnabled = true
              imgClose.addGestureRecognizer(tapGestureRecognizerEntra)
             
              lblTitle.text = GeneralUtil.shared.crtProtocollo.Nome + " - " + step.Titolo;
              lblDescr.text = step.Sottotitolo;
              // Do any additional setup after loading the view.
              
              
              tableDettaglioStep.register(UINib(nibName: "ContentStepViewCell", bundle: nil), forCellReuseIdentifier: "ContentStepViewCell")
                            tableDettaglioStep.delegate = self
                            tableDettaglioStep.dataSource = self
              
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
        if (step.fasi[section].elementi == nil)
        {
            return 0
        }
        else
        {
            return step.fasi[section].elementi.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return step.fasi[section].Nome;
              
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return step.fasi.count;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let item: ContentStepViewCell = tableDettaglioStep.dequeueReusableCell(withIdentifier: "ContentStepViewCell", for: indexPath) as! ContentStepViewCell
               
              item.lblTitle.text = step.fasi[indexPath.section].elementi[indexPath.row].Titolo;
              return item;
          }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //FAI QUALCOSA:
        let itemData:Elemento!
        itemData = step.fasi[indexPath.section].elementi[indexPath.row];
        
        DispatchQueue.main.async(){
        
                               DispatchQueue.main.async(){
                                       let vc = ElementoViewController()
                                       vc.elemento = itemData;
                                       vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                                       self.present(vc, animated: true, completion: nil)
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
   
   
}
