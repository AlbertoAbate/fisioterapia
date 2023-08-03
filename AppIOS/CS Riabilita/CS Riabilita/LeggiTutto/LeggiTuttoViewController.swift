//
//  LeggiTuttoViewController.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 13/10/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import UIKit

class LeggiTuttoViewController: UIViewController {

    @IBOutlet var imgClose: UIImageView!
    @IBOutlet var lblContent: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGestureRecognizerEntra = UITapGestureRecognizer(target: self, action:  #selector(chiudi))
        imgClose.isUserInteractionEnabled = true
        imgClose.addGestureRecognizer(tapGestureRecognizerEntra)
        
    }
    
    @objc func chiudi()
             {
               self.dismiss(animated: false, completion: nil)
             }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
