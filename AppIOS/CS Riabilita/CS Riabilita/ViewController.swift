//
//  ViewController.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 31/08/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let cg = Citygram()
        cg.loadLabels(vc:self);
        
        GeneralUtil.shared.loadData();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
          
     
        print("SI AVVIO");
    }
    
    func startAll()
    {
        DispatchQueue.main.async(){
              let vc = AccessoViewController()
          vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
              self.present(vc, animated: true, completion: nil)
      }
    }


    
}

