//
//  ProfiloViewController.swift
//  CS Riabilita
//
//  Created by Mac Coobi on 10/05/23.
//  Copyright © 2023 Rubik srls. All rights reserved.
//

import UIKit
import Alamofire

class ProfiloViewController: UIViewController {

    var type: String!
    
    @IBOutlet weak var cittaProfi: UILabel!
    @IBOutlet weak var TelefonoProfi: UILabel!
    @IBOutlet weak var emailProfi: UILabel!
    @IBOutlet weak var cognomeProfi: UILabel!
    @IBOutlet weak var nomeProfi: UILabel!
    @IBOutlet weak var indietro: UIButton!
    @IBOutlet weak var logoBianco: UIImageView!
    @IBOutlet weak var codiceFiscaleProfi: UILabel!
    var profiloList = [Profilo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        indietro.setTitle(Utility.getLbl(code: "TORNAINDIETRO"), for: .normal)
        
        nomeProfi.text = GeneralUtil.shared.user.nome
        nomeProfi.layer.cornerRadius = 10;
        nomeProfi.clipsToBounds = true
        nomeProfi.textColor = UIColor.black
        nomeProfi.backgroundColor = UIColor.white
        
        cognomeProfi.text =  GeneralUtil.shared.user.cognome
        cognomeProfi.layer.cornerRadius = 10;
        cognomeProfi.clipsToBounds = true
        cognomeProfi.textColor = UIColor.black
        cognomeProfi.backgroundColor = UIColor.white
        
        emailProfi.text = GeneralUtil.shared.user.email
        emailProfi.layer.cornerRadius = 10;
        emailProfi.clipsToBounds = true
        emailProfi.textColor = UIColor.black
        emailProfi.backgroundColor = UIColor.white
        
        //cfProfi.text = GeneralUtil.shared.user.cf
        TelefonoProfi.text = GeneralUtil.shared.user.phone
        TelefonoProfi.layer.cornerRadius = 10;
        TelefonoProfi.clipsToBounds = true
        TelefonoProfi.textColor = UIColor.black
        TelefonoProfi.backgroundColor = UIColor.white
        
        cittaProfi.text = GeneralUtil.shared.user.address
        cittaProfi.layer.cornerRadius = 10;
        cittaProfi.clipsToBounds = true
        cittaProfi.textColor = UIColor.black
        cittaProfi.backgroundColor = UIColor.white
        
        codiceFiscaleProfi.text = GeneralUtil.shared.user.cf
        codiceFiscaleProfi.layer.cornerRadius = 10;
        codiceFiscaleProfi.clipsToBounds = true
        codiceFiscaleProfi.textColor = UIColor.black
        codiceFiscaleProfi.backgroundColor = UIColor.white
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = 10
        paragraphStyle.firstLineHeadIndent = 10

        let attributedStringNome = NSAttributedString(string: GeneralUtil.shared.user.nome, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

        nomeProfi.attributedText = attributedStringNome
        
        let attributedStringCognome = NSAttributedString(string: GeneralUtil.shared.user.cognome, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

        cognomeProfi.attributedText = attributedStringCognome

        let attributedStringEmail = NSAttributedString(string: GeneralUtil.shared.user.email, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

        emailProfi.attributedText = attributedStringEmail
        
        let attributedStringTel = NSAttributedString(string: GeneralUtil.shared.user.phone, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

        TelefonoProfi.attributedText = attributedStringTel
        
        let attributedStringCitta = NSAttributedString(string: GeneralUtil.shared.user.address, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

        cittaProfi.attributedText = attributedStringCitta
        
        let attributedStringCf = NSAttributedString(string: GeneralUtil.shared.user.cf, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

        codiceFiscaleProfi.attributedText = attributedStringCf
        
        if cittaProfi.text == "" {
                cittaProfi.isHidden = true
            }

            if codiceFiscaleProfi.text == "" {
                codiceFiscaleProfi.isHidden = true
            }

        
        loadProfilo()
    }
    
    @IBAction func tornaIndietro(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadProfilo() {
        let url = Utility.getBaseUrl()
        
        let parameters: Parameters = [
            "action": "getUser",
            "Token": GeneralUtil.shared.user.token!
        ]
        
        Alamofire.request(Utility.getBaseUrl(), method: .post, parameters: parameters)
            .responseString { response in
                print("DETTAGLI USER")
                print("Response doc1",response);
                print("Response doc1",response);

            }
            .responseJSON { response in
                
                print("Response doc2",response);
                do {
                    self.profiloList.removeAll()
                    let jsonArray = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! NSArray
                    // Looping through jsonArray
                    for jsonObject in jsonArray { // Riempiamo l'array.
                        if let dataArr = Profilo(from: jsonObject as AnyObject) {
                            self.profiloList.append(dataArr)
                        }
                    }
                    
                    
                } catch {
                    print("Error: (Retrieving Data)")
                }
                
        }
    }
}

