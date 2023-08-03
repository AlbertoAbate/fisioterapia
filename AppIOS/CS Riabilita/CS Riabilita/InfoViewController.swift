//
//  InfoViewController.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 31/08/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    var type:String!
    var valore:String!
    
    @IBOutlet var edtContent: UITextView!
    @IBOutlet var bttTorna: UIButton!
    @IBOutlet var bttAvanti: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        bttAvanti.layer.cornerRadius = 10;
        bttAvanti.setTitle(Utility.getLbl(code: "AVANTI"), for: .normal)
         bttTorna.setTitle(Utility.getLbl(code: "TORNAINDIETRO"), for: .normal)
        // Do any additional setup after loading the view.
        fillContent();
    }

    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func goOn(_ sender: UIButton) {
        if (type == "PROTOCOLLI")
        {
                        DispatchQueue.main.async(){
                                  let vc = ArticolazioniViewController()
                            vc.infoToClose = self;
                                  vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                                  self.present(vc, animated: false, completion: nil)
                          }
        }
        else if (type == "PROTOCOLLISTEP")
        {
                        DispatchQueue.main.async(){
                                  let vc = StepViewController()
                                  vc.infoToClose = self;
                                  vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                                  self.present(vc, animated: false, completion: nil)
                          }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
          Utility.setGradientBackground(v:self.view)
          super.viewWillAppear(animated)
    }
    
    func fillContent()
    {
        if (type == "PROTOCOLLI")
        {
            edtContent.text = Utility.getLbl(code: "PROTOCOLLIDESCR")
        }
        else if (type == "PROTOCOLLISTEP")
        {
             edtContent.text = Utility.getLbl(code: "PROTOCOLLISTEPDESCR")
        }
        else if (type == "RISPOSTAQUESTIONARIO")
        {
            edtContent.text = valore!;
            bttAvanti.isHidden = true;
            bttTorna.setTitle(Utility.getLbl(code: "CHIUDI"), for: .normal)
        }
    }

}
