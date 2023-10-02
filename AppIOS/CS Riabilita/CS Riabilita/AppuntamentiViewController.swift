//
//  AppuntamentiViewController.swift
//  CS Riabilita
//
//  Created by Mac Coobi on 10/05/23.
//  Copyright © 2023 Rubik srls. All rights reserved.
//

import UIKit
import Alamofire

class AppuntamentiViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {
    
    var type: String!
    var documentURL: String? // Proprietà per memorizzare l'URL dei documenti
    
    @IBOutlet weak var nessunAppuntamentoLabel: UILabel!
    @IBOutlet weak var logoBianco: UIImageView!
    @IBOutlet weak var indietro: UIButton!
    @IBOutlet weak var AppuntamentiTableView: UITableView!
    var appuntamentiList = [Appuntamento]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppuntamentiTableView.dataSource = self // Imposta il dataSource della tabella
        AppuntamentiTableView.register(UINib(nibName: "AppuntamentoTableViewCell", bundle: nil), forCellReuseIdentifier: "AppuntamentoTableViewCell")
        AppuntamentiTableView.delegate = self
        AppuntamentiTableView.dataSource = self
        AppuntamentiTableView.backgroundColor = UIColor.white

        loadAppuntamenti(side: "NUOVI", allAppuntamenti: "0")
        indietro.setTitle(Utility.getLbl(code: "TORNAINDIETRO"), for: .normal)
        
        nessunAppuntamentoLabel.isHidden = true

    }
    
    @IBAction func tornaIndietro(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func appuntamentoValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // FRONTE
            loadAppuntamenti(side: "PROSSIMI", allAppuntamenti: "0")
        } else {
            // RETRO
            loadAppuntamenti(side: "TUTTI", allAppuntamenti: "1")
        }
    }
    
    func loadAppuntamenti(side: String, allAppuntamenti: String) {
        let url = Utility.getBaseUrl()
        
        let parameters: Parameters = [
            "action": "getAppuntamenti",
            "allAppuntamenti": allAppuntamenti, //0=solo futuri, 1=tutti
            "Token": GeneralUtil.shared.user.token!
        ]
        print("Token: ", GeneralUtil.shared.user.token!);

        Alamofire.request(Utility.getBaseUrl(), method: .post, parameters: parameters)
            .responseString { response in
                print("DETTAGLI APPUNTAMENTI")
                print("Response doc1", response);
            }
            .responseJSON { response in
                print("Response doc2", response);
                do {
                    self.appuntamentiList.removeAll()
                    let jsonArray = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! NSArray
                    
                    let currentDate = Date() // Ottieni la data odierna
                    
                    // Loop through jsonArray
                    for jsonObject in jsonArray {
                        if let dataArr = Appuntamento(from: jsonObject as AnyObject) {
                            if side == "PROSSIMI" {
                                let appuntamentoDate = dataArr.date // Supponiamo che tu abbia una proprietà 'date' nell'oggetto Appuntamento che rappresenta la data dell'appuntamento
                                
                                // Controlla se la data dell'appuntamento è successiva alla data odierna
                                if appuntamentoDate! >= currentDate {
                                    self.appuntamentiList.append(dataArr)
                                }
                            } else {
                                self.appuntamentiList.append(dataArr)
                            }
                        }
                    }
                    
                    // Controllo se la lista degli appuntamenti è vuota
                        if self.appuntamentiList.isEmpty {
                            self.nessunAppuntamentoLabel.isHidden = false
                            self.AppuntamentiTableView.isHidden = true
                        } else {
                            self.nessunAppuntamentoLabel.isHidden = true
                            self.AppuntamentiTableView.isHidden = false
                            self.AppuntamentiTableView.reloadData()
                        }
                    
                } catch {
                    print("Error: (Retrieving Data)")
                }
                
        }
    }

    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appuntamentiList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item: AppuntamentoTableViewCell = AppuntamentiTableView.dequeueReusableCell(withIdentifier: "AppuntamentoTableViewCell", for: indexPath) as! AppuntamentoTableViewCell
        item.selectionStyle = .none // Imposta lo stile di selezione a "None" per evitare la colorazione di sfondo
        item.appuntamentoLabel.text = appuntamentiList[indexPath.row].ggFormat + appuntamentiList[indexPath.row].ora
        return item
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appuntamento = appuntamentiList[indexPath.row]
        
        apriInfoAppuntamenti(with: appuntamento)
    }
    
    func apriInfoAppuntamenti(with appuntamento: Appuntamento) {
        DispatchQueue.main.async {
            let vc = InfoAppuntamentoViewController()
            // Passa le informazioni della terapia al InfoTerapieViewController, puoi usare proprieta' nel controller per mostrare i dati
            vc.appuntamento = appuntamento // Pass the selected terapia to InfoTerapiaViewController
            vc.modalPresentationStyle = .overFullScreen // or .overFullScreen for transparency
            self.present(vc, animated: true, completion: nil)
            
            // Deselect the selected cell to remove the selection highlight
                        if let indexPath = self.AppuntamentiTableView.indexPathForSelectedRow {
                            self.AppuntamentiTableView.deselectRow(at: indexPath, animated: true)
                        }
        }
    }
}
