//
//  ElementoViewController.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 02/09/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import WebKit

class ElementoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WKNavigationDelegate {

    @IBOutlet var tableElementi: UITableView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgClose: UIImageView!
    var elemento:Elemento!

    override func viewDidLoad() {
        super.viewDidLoad()

                   let tapGestureRecognizerEntra = UITapGestureRecognizer(target: self, action:  #selector(chiudi))
                   imgClose.isUserInteractionEnabled = true
                   imgClose.addGestureRecognizer(tapGestureRecognizerEntra)
                  
                   lblTitle.text = elemento.Titolo
                   // Do any additional setup after loading the view.
                   
                   
                   tableElementi.register(UINib(nibName: "ElementoDescrCell", bundle: nil), forCellReuseIdentifier: "ElementoDescrCell")
                    tableElementi.register(UINib(nibName: "ElementoImgCell", bundle: nil), forCellReuseIdentifier: "ElementoImgCell")
                    tableElementi.register(UINib(nibName: "VideoElementoViewCell", bundle: nil), forCellReuseIdentifier: "VideoElementoViewCell")
                   tableElementi.delegate = self
                   tableElementi.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
                   Utility.setGradientBackgroundWhite(v:self.view)
                   super.viewWillAppear(animated)
             }
          
          @objc func chiudi()
                {
                  self.dismiss(animated: false, completion: nil)
                }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (elemento.mediaItems.isEmpty == nil)
           {
               return 0
           }
           else
           {
            return elemento.mediaItems.count
           }
       }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Start loading")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("End loading")
        webView.isHidden = false;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let med = elemento.mediaItems[indexPath.row];
        print(med.Tipo)
        if (med.Tipo! == "IMG")
        {
            let item: ElementoImgCell = tableElementi.dequeueReusableCell(withIdentifier: "ElementoImgCell", for: indexPath) as! ElementoImgCell
            item.heightImg.constant = UIScreen.main.bounds.width - 20.0;
            let url = URL(string: Utility.getBaseImgUrl() + med.Url)
            item.imgMedia.af_setImage(withURL: url!)
            return item;
        }
        else if (med.Tipo! == "VID")
        {
            
            let item: VideoElementoViewCell = tableElementi.dequeueReusableCell(withIdentifier: "VideoElementoViewCell", for: indexPath) as! VideoElementoViewCell
            //item.lblTitolo.text = med.Descrizione
            let wScreen = UIScreen.main.bounds.width / 16 * 9
            print(wScreen)
            item.webView.isHidden = true;
            let link = URL(string:med.Url)!
            let request = URLRequest(url: link)
            item.webView.navigationDelegate = self
            item.heightConstant.constant = wScreen
            item.webView.load(request)
            return item;
        }
        else //TIPO DESC
        {
                 let item: ElementoDescrCell = tableElementi.dequeueReusableCell(withIdentifier: "ElementoDescrCell", for: indexPath) as! ElementoDescrCell
                 item.lblTitolo.text = med.Descrizione
                 return item;
            
        }
        
        
    }
}
