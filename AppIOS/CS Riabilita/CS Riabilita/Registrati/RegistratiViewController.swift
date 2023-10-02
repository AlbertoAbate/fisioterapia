//
//  RegistratiViewController.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 03/11/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import UIKit
import SwiftMessages
import Alamofire
import PMAlertController

extension String {
    // Function to check if a string is in a valid email format
    func isValidEmail() -> Bool {
        // Regular expression for email format validation
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
}


class RegistratiViewController: UIViewController {

    @IBOutlet var lblInfoRegistrati: UILabel!
    @IBOutlet var imgClose: UIImageView!
    @IBOutlet var bttRegistrati: UIButton!
    @IBOutlet var lblTitle: UILabel!
    var blurEffectView: UIVisualEffectView!
    @IBOutlet var lblCitta: UITextField!
    @IBOutlet var lblTelefono: UITextField!
    @IBOutlet var lblConfermaPass: UITextField!
    @IBOutlet var lblPassword: UITextField!
    @IBOutlet var lblEmail: UITextField!
    @IBOutlet var lblCognome: UITextField!
    @IBOutlet var lblNome: UITextField!
    var doveVado:String!
    @IBOutlet weak var scrollRegistra: UIScrollView!
    @IBOutlet weak var lblCf: UITextField!
    var isKeyboardActive = false
    var keyboardHeight: CGFloat = 0.0

    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblCitta.keyboardAppearance = .default
        lblCf.keyboardAppearance = .default

        
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
        lblTitle.text = Utility.getLbl(code: "REGISTRATITITLE")
        lblInfoRegistrati.text = Utility.getLbl(code: "LBLINFOREGISTRATI")
        bttRegistrati.layer.cornerRadius = 10;
        bttRegistrati.setTitle(Utility.getLbl(code: "DOREGISTRATI"), for: .normal)
        lblTelefono.keyboardType = .numberPad
        
        lblNome.textColor = UIColor.black
        lblNome.backgroundColor = UIColor.white
        lblNome.attributedPlaceholder = NSAttributedString(string: "Nome...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        lblCognome.textColor = UIColor.black
        lblCognome.backgroundColor = UIColor.white
        lblCognome.attributedPlaceholder = NSAttributedString(string: "Cognome...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        lblEmail.textColor = UIColor.black
        lblEmail.backgroundColor = UIColor.white
        lblEmail.attributedPlaceholder = NSAttributedString(string: "E-mail...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        lblPassword.textColor = UIColor.black
        lblPassword.backgroundColor = UIColor.white
        lblPassword.attributedPlaceholder = NSAttributedString(string: "Password...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        lblConfermaPass.textColor = UIColor.black
        lblConfermaPass.backgroundColor = UIColor.white
        lblConfermaPass.attributedPlaceholder = NSAttributedString(string: "Conferma password...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        lblTelefono.textColor = UIColor.black
        lblTelefono.backgroundColor = UIColor.white
        lblTelefono.attributedPlaceholder = NSAttributedString(string: "Telefono...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        lblCitta.textColor = UIColor.black
        lblCitta.backgroundColor = UIColor.white
        lblCitta.attributedPlaceholder = NSAttributedString(string: "Città...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        lblCf.textColor = UIColor.black
        lblCf.backgroundColor = UIColor.white
        lblCf.attributedPlaceholder = NSAttributedString(string: "Codice Fiscale...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        self.hideKeyboardWhenTappedAround()
        
        // Aggiungi un'osservazione per la notifica della tastiera
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            if !isKeyboardActive {
                // Sposta la UIScrollView verso l'alto solo se la tastiera non è già attiva
                scrollRegistra.contentInset.bottom += keyboardHeight
                scrollRegistra.scrollIndicatorInsets.bottom += keyboardHeight
                isKeyboardActive = true
            }
        }
    }


    @objc func keyboardWillHide(notification: NSNotification) {
        if isKeyboardActive {
            // Ripristina l'offset della UIScrollView solo se la tastiera è attualmente attiva
            scrollRegistra.contentInset.bottom -= keyboardHeight
            scrollRegistra.scrollIndicatorInsets.bottom -= keyboardHeight
            isKeyboardActive = false
        }
    }


        deinit {
            NotificationCenter.default.removeObserver(self)
        }

    @objc func chiudi()
             {
                 let accessoViewController = AccessoViewController()
                 self.present(accessoViewController, animated: true, completion: nil)
             }
    
    @IBAction func doRegistrati(_ sender: UIButton) {
            bttRegistrati.isEnabled = false
            if !checkFields() {
                return
            }
            
            if !ConnectionCheck.isConnectedToNetwork() {
                return
            }
            
            let number = Int.random(in: 0..<300)
            
            let parameters: Parameters = [
                "action": "registerUser2023",
                //"IDLocation": "1",
                "Name": lblNome.text!,
                "Surname": lblCognome.text!,
                "Email": lblEmail.text!,
                "Password": lblPassword.text!,
                "Phone": lblTelefono.text!,
                //"username": lblCognome.text! + lblNome.text! + String(number),
                "Address": lblCitta.text!,
                "Cf": lblCf.text!,
                "language": ""
            ]
            
            Alamofire.request(Utility.getBaseUrl(), method: .post, parameters: parameters)
               .responseString { response in
                   print("DETTAGLI parameters ",parameters)
                   print("response registrazione: ",response)
               }
               .responseJSON { [self] response in
                   do {
                       let jsonArray = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! NSMutableArray
                       for jsonObject in jsonArray {
                           if let dataArr = ResponseLogin(from: jsonObject as AnyObject) {
                               if dataArr.status == "OK" {
                                   self.showDone()
                               } else {
                                   self.bttRegistrati.isEnabled = true
                                   self.showError(txt: dataArr.message!)
                               }
                           }
                       }
                   } catch {
                       print("Error: (Retrieving Data)")
                   }
               }
        }
    
    func showDone()
    {
        let alertVC = PMAlertController(title: Utility.getLbl(code: "SHOWDONEREGTITLE"), description: Utility.getLbl(code: "SHOWDONEREGBODY"), image: nil, style: .walkthrough) //Image by freepik.com, taken on flaticon.com
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
                
                
        let pActCancel = PMAlertAction(title: Utility.getLbl(code: "CHIUDI"), style: .cancel, action: { () -> Void in
            self.blurEffectView.isHidden = true
            self.dismiss(animated: true, completion: {
                DispatchQueue.main.async {
                    let accediViewController = AccediViewController()
                    if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
                        rootViewController.present(accediViewController, animated: true, completion: nil)
                    }
                }
            })
        })

        alertVC.addAction(pActCancel)
        self.present(alertVC, animated: true, completion: nil)

    }
    
    func checkFields() -> Bool
    {
        if (lblNome.text=="")
        {
            showError(txt:Utility.getLbl(code: "ERRFIELD"));
            return false;
        }
        if (lblCognome.text=="")
        {
            showError(txt:Utility.getLbl(code: "ERRFIELD"));
            return false;
        }
        if (lblEmail.text=="")
        {
            showError(txt:Utility.getLbl(code: "ERRFIELD"));
            return false;
        }
        if (lblPassword.text=="")
        {
            showError(txt:Utility.getLbl(code: "ERRFIELD"));
            return false;
        }
        if (lblConfermaPass.text=="")
        {
            showError(txt:Utility.getLbl(code: "ERRFIELD"));
            return false;
        }
        if (lblPassword.text != lblConfermaPass.text)
        {
            showError(txt:Utility.getLbl(code: "ERRFIELDPASSWORD"));
            return false;
        }
        if (lblCf.text=="")
        {
            showError(txt:Utility.getLbl(code: "ERRFIELD"));
            return false;
        }

        if (Utility.isValidEmail(testStr: lblEmail.text!) == false)
        {
            showError(txt:Utility.getLbl(code: "ERREMAIL"));
            return false;
        }
        
        if let email = lblEmail.text, !email.isValidEmail() {
                showError(txt: Utility.getLbl(code: "ERREMAILFORMAT"))
                return false
            }
        return true;
    }

    
    func showError(txt:String)
    {
        let view = MessageView.viewFromNib(layout: .cardView)
        SwiftMessages.defaultConfig.presentationStyle = .top

        // Theme message elements with the warning style.
        view.configureTheme(.warning)
        
        // Add a drop shadow.
        //view.configureDropShadow()
        view.button?.isHidden = true;
        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()
        view.configureContent(title: "Ops...", body: txt, iconText: iconText!)
        
        // Show the message.
        SwiftMessages.show(view: view)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
