//
//  AccediViewController.swift
//  CS Riabilita
//
//  Created by Mac Coobi on 12/05/23.
//  Copyright © 2023 Rubik srls. All rights reserved.
//

import UIKit
import PMAlertController

class AccessoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        entra()
        //loginUser()
    }
    
    @objc func entra() {
        if let token = GeneralUtil.shared.user.token, !token.isEmpty {
            DispatchQueue.main.async {
                let vc = SchermataViewController()
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            }
            return
        }
        print("AREA RISERVATA")
        
        let alertVC = PMAlertController(title: Utility.getLbl(code: "SHOWTITLEACCOUNT"), description: Utility.getLbl(code: "SHOWBODYACCOUNT"), image: nil, style: .walkthrough)
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
        
        let pAct = PMAlertAction(title: Utility.getLbl(code: "HOGIAACCOUNT"), style: .default) { [weak self] in
            DispatchQueue.main.async {
                let vc = AccediViewController()
                vc.modalPresentationStyle = .overFullScreen
                self?.present(vc, animated: true, completion: nil)
            }
        }
        alertVC.addAction(pAct)
        
        let pActReg = PMAlertAction(title: Utility.getLbl(code: "REGISTRATI"), style: .default) { [weak self] in
            DispatchQueue.main.async {
                let vc = RegistratiViewController()
                vc.modalPresentationStyle = .overFullScreen
                self?.present(vc, animated: true, completion: nil)
            }
        }
        alertVC.addAction(pActReg)
        
        let pActCancel = PMAlertAction(title: Utility.getLbl(code: " "), style: .cancel) { [weak self] in
            // Non fare nulla
            DispatchQueue.main.async {
                let vc = AccessoViewController()
                vc.modalPresentationStyle = .overFullScreen
                self?.present(vc, animated: true, completion: nil)
            }
        }
        alertVC.addAction(pActCancel)



        
        DispatchQueue.main.async {
            self.present(alertVC, animated: true, completion: nil)
        }
    }
        
        
    }
