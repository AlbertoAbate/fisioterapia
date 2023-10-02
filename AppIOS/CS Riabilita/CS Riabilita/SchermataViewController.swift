//
//  LoginViewController.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 31/08/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import UIKit
import PMAlertController

class SchermataViewController: UIViewController {

    @IBOutlet weak var simbolo: UIImageView!
    @IBOutlet weak var imgLogout: UIImageView!
    @IBOutlet var lblCredits: UILabel!
    @IBOutlet var viewBttProtocolli: UIView!
    @IBOutlet var viewBttAreaRis: UIView!
    @IBOutlet weak var viewDocumenti: UIView!
    @IBOutlet weak var viewProfilo: UIView!
    var blurEffectView: UIVisualEffectView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isHidden = true;
        blurEffectView.alpha = 0.85;
        self.view.addSubview(blurEffectView)
        // Do any additional setup after loading the view.
        // Codice per capovolgere l'immagine orizzontalmente
                if let originalImage = simbolo.image {
                    let flippedImage = UIImage(cgImage: originalImage.cgImage!, scale: originalImage.scale, orientation: .upMirrored)
                    simbolo.image = flippedImage
                }
        
        viewBttProtocolli.backgroundColor = UIColor.white
        viewProfilo.backgroundColor = UIColor.white
        viewDocumenti.backgroundColor = UIColor.white
        viewBttAreaRis.backgroundColor = UIColor.white

        viewBttAreaRis.layer.cornerRadius = 10;
        viewBttProtocolli.layer.cornerRadius = 10;
        viewProfilo.layer.cornerRadius = 10;
        viewDocumenti.layer.cornerRadius = 10;
        viewBttProtocolli.clipsToBounds = true;
        viewBttAreaRis.clipsToBounds = true
        viewProfilo.clipsToBounds = true
        viewDocumenti.clipsToBounds = true
        
        viewBttAreaRis.layer.masksToBounds = false
        viewBttAreaRis.layer.shadowColor = UIColor.black.cgColor
        viewBttAreaRis.layer.shadowOpacity = 0.3
        viewBttAreaRis.layer.shadowOffset = CGSize(width: 0, height: 1)
        viewBttAreaRis.layer.shadowRadius = 10

        viewBttAreaRis.layer.shadowPath = UIBezierPath(rect:  viewBttAreaRis.bounds).cgPath
        viewBttAreaRis.layer.shouldRasterize = true
        viewBttAreaRis.layer.rasterizationScale = UIScreen.main.scale
        
        
        viewBttProtocolli.layer.masksToBounds = false
        viewBttProtocolli.layer.shadowColor = UIColor.black.cgColor
        viewBttProtocolli.layer.shadowOpacity = 0.3
        viewBttProtocolli.layer.shadowOffset = CGSize(width: -1, height: 1)
        viewBttProtocolli.layer.shadowRadius = 10

        viewBttProtocolli.layer.shadowPath = UIBezierPath(rect:  viewBttAreaRis.bounds).cgPath
        viewBttProtocolli.layer.shouldRasterize = true
        viewBttProtocolli.layer.rasterizationScale = UIScreen.main.scale
        
        
        
        
        let tapGestureRecognizerAppuntamenti = UITapGestureRecognizer(target: self, action:  #selector(vaiAppuntamenti))
        viewBttProtocolli.isUserInteractionEnabled = true
        viewBttProtocolli.addGestureRecognizer(tapGestureRecognizerAppuntamenti)
        
        let tapGestureRecognizerTerapie = UITapGestureRecognizer(target: self, action:  #selector(vaiTerapie))
        viewBttAreaRis.isUserInteractionEnabled = true
        viewBttAreaRis.addGestureRecognizer(tapGestureRecognizerTerapie)
        
        let tapGestureRecognizerDocumenti = UITapGestureRecognizer(target: self, action:  #selector(vaiDocumenti))
        viewDocumenti.isUserInteractionEnabled = true
        viewDocumenti.addGestureRecognizer(tapGestureRecognizerDocumenti)
        
        let tapGestureRecognizerProfilo = UITapGestureRecognizer(target: self, action:  #selector(vaiProfilo))
        viewProfilo.isUserInteractionEnabled = true
        viewProfilo.addGestureRecognizer(tapGestureRecognizerProfilo)
        
        let tapGestureRecognizerEsci = UITapGestureRecognizer(target: self, action:  #selector(askLogout))
        imgLogout.isUserInteractionEnabled = true
        imgLogout.addGestureRecognizer(tapGestureRecognizerEsci)

        if (GeneralUtil.shared.user.token != "")
        {
            lblCredits.text = Utility.getLbl(code: "BENVENUTO") + " " + GeneralUtil.shared.user.nome;
        }
        else
        {
            lblCredits.text = Utility.getLbl(code: "CREDITS");
        }
    }
    
   


    override func viewWillAppear(_ animated: Bool) {
        Utility.setGradientBackground(v:self.view)
        super.viewWillAppear(animated)
        
        
    }
    /*
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action:  #selector(vaiProtocolli))
    viewBttProtocolli.isUserInteractionEnabled = true
    viewBttProtocolli.addGestureRecognizer(tapGestureRecognizer)

    let tapGestureRecognizerEntra = UITapGestureRecognizer(target: self, action:  #selector(entra))
    viewBttAreaRis.isUserInteractionEnabled = true
    viewBttAreaRis.addGestureRecognizer(tapGestureRecognizerEntra)*/
    /*
     
    @objc func vaiProtocolli()
    {
        print("PROTOCOLLI")
        
        DispatchQueue.main.async(){
                       let vc = InfoViewController()
                        vc.type = "APPUNTAMENTI";
                       vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                       self.present(vc, animated: true, completion: nil)
               }
        
    }
    
    @objc func entra()
       {
        if ( GeneralUtil.shared.user != nil && GeneralUtil.shared.user.token != nil &&  GeneralUtil.shared.user.token != "")
        {
            DispatchQueue.main.async(){
                           let vc = PannelloUtenteView()
                           vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                           self.present(vc, animated: true, completion: nil)
                   }
            return;
        }
        print("AREA RISERVATA")
        
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
            
       }*/
    
    @objc func vaiAppuntamenti()
    {
        print("APPUNTAMENTI")
        
        DispatchQueue.main.async(){
                       let vc = AppuntamentiViewController()
                        vc.type = "APPUNTAMENTI";
                       vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                       self.present(vc, animated: true, completion: nil)
               }
        
    }
    
    @objc func vaiTerapie()
    {
        print("TERAPIE")
        
        DispatchQueue.main.async(){
                       let vc = TerapieViewController()
                        vc.type = "TERAPIE";
                       vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                       self.present(vc, animated: true, completion: nil)
               }
        
    }
    
    @objc func vaiDocumenti()
    {
        print("Documenti")
        
        DispatchQueue.main.async(){
                       let vc = DocumentiViewController()
                        vc.type = "DOCUMENTI";
                       vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                       self.present(vc, animated: true, completion: nil)
               }
        
    }
    
    @objc func vaiProfilo()
    {
        print("PROFILO")
        
        DispatchQueue.main.async(){
                       let vc = ProfiloViewController()
                        vc.type = "PROFILO";
                       vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                       self.present(vc, animated: true, completion: nil)
               }
        
    }
    
    @objc func askLogout() {
        let alertVC = PMAlertController(title: Utility.getLbl(code: "TITLEASKESCI"), description: Utility.getLbl(code: "BODYASKESCI"), image: nil, style: .alert) //Image by freepik.com, taken on flaticon.com
        alertVC.headerViewTopSpaceConstraint.constant = 10
        alertVC.alertContentStackViewLeadingConstraint.constant = 10
        alertVC.alertContentStackViewTrailingConstraint.constant = 10
        alertVC.alertContentStackViewTopConstraint.constant = 10
        alertVC.alertActionStackViewLeadingConstraint.constant = 10
        alertVC.alertActionStackViewTrailingConstraint.constant = 10
        alertVC.alertActionStackViewTopConstraint.constant = 10
        alertVC.alertActionStackViewBottomConstraint.constant = 10
        alertVC.alertTitle.textColor = Utility.hexStringToUIColor(hex: "#347b9c")
        alertVC.alertDescription.textColor = Utility.hexStringToUIColor(hex: "#347b9c")
        
        let imgBg = UIImage.from(color: Utility.hexStringToUIColor(hex: "#347b9c"))
        
        alertVC.alertMaskBackground.image = imgBg
        alertVC.alertMaskBackground.alpha = 0.85
        
        alertVC.view.layoutIfNeeded()
        
        let act = PMAlertAction(title: Utility.getLbl(code: "ANNULLA"), style: .cancel, action: { () in
            // Azione annulla
        })
        alertVC.addAction(act)
        
        let actEsc = PMAlertAction(title: Utility.getLbl(code: "ESCI"), style: .default, action: { () in
            GeneralUtil.shared.user.logout()
            let accessoViewController = AccessoViewController() // Crea un'istanza di AccessoViewController
            self.view.window?.rootViewController = accessoViewController // Imposta AccessoViewController come il root view controller
            self.view.window?.makeKeyAndVisible() // Rendi AccessoViewController visibile
        })
        alertVC.addAction(actEsc)
        
        self.present(alertVC, animated: true, completion: nil)
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
