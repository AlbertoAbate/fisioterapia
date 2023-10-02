//
//  DocumentiViewController.swift
//  CS Riabilita
//
//  Created by Mac Coobi on 10/05/23.
//  Copyright © 2023 Rubik srls. All rights reserved.
//

import UIKit
import Alamofire

class DocumentiViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {
    
    var type: String!
    var documentURL: String? // Proprietà per memorizzare l'URL dei documenti
    
    @IBOutlet weak var nessunDocumento: UILabel!
    @IBOutlet weak var logoBianco: UIImageView!
    @IBOutlet weak var indietro: UIButton!
    @IBOutlet weak var DocumentiTableView: UITableView!
    var documentiList = [Documento]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DocumentiTableView.dataSource = self // Imposta il dataSource della tabella
        DocumentiTableView.register(UINib(nibName: "DocumentoTableViewCell", bundle: nil), forCellReuseIdentifier: "DocumentoTableViewCell")
        DocumentiTableView.delegate = self
        DocumentiTableView.dataSource = self
        DocumentiTableView.backgroundColor = UIColor.white

        loadDocumenti(side: "NUOVI")
        indietro.setTitle(Utility.getLbl(code: "TORNAINDIETRO"), for: .normal)
        
        nessunDocumento.isHidden = true

    }
    
    @IBAction func tornaIndietro(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func DocChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // FRONTE
            loadDocumenti(side: "NUOVI")
        } else {
            // RETRO
            loadDocumenti(side: "TUTTI")
        }
    }
    
    func loadDocumenti(side: String) {
        let url = Utility.getBaseUrl()
        
        let parameters: Parameters = [
            "action": "getDocumenti",
            "Token": GeneralUtil.shared.user.token!
        ]
        
        Alamofire.request(Utility.getBaseUrl(), method: .post, parameters: parameters)
            .responseString { response in
                print("DETTAGLI PATOLOGIE")
                print("Response doc1",response);
            }
            .responseJSON { response in
                
                print("Response doc2",response);
                do {
                    self.documentiList.removeAll()
                    let jsonArray = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! NSArray
                    // Looping through jsonArray
                    for jsonObject in jsonArray { // Riempiamo l'array.
                        if let dataArr = Documento(from: jsonObject as AnyObject) {
                            self.documentiList.append(dataArr)
                        }
                    }
                    
                    self.DocumentiTableView.reloadData()
                    
                    // Controllo se la lista degli appuntamenti è vuota
                        if self.documentiList.isEmpty {
                            self.nessunDocumento.isHidden = false
                            self.DocumentiTableView.isHidden = true
                        } else {
                            self.nessunDocumento.isHidden = true
                            self.DocumentiTableView.isHidden = false
                            self.DocumentiTableView.reloadData()
                        }
                    
                } catch {
                    print("Error: (Retrieving Data)")
                }
                
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documentiList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item: DocumentoTableViewCell = DocumentiTableView.dequeueReusableCell(withIdentifier: "DocumentoTableViewCell", for: indexPath) as! DocumentoTableViewCell
        let nomeDoc = documentiList[indexPath.row].nomeDoc ?? ""
        let docTipo = documentiList[indexPath.row].docTipo ?? ""
        let dataIT = documentiList[indexPath.row].dataIT ?? ""
        item.selectionStyle = .none // Imposta lo stile di selezione a "None" per evitare la colorazione di sfondo
        let paddedDataIT = dataIT.padding(toLength: 10, withPad: " ", startingAt: 0)
            item.DocLabel.text = "\(paddedDataIT)\n\(nomeDoc) - \(docTipo)"
            item.DocLabel.numberOfLines = 0 // Per consentire più righe di testo
            
            return item
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlCompleto = documentiList[indexPath.row].UrlDocCompleto
        
        guard let url = URL(string: urlCompleto!) else {
            print("URL non valido")
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
