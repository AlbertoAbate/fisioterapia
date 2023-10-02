//
//  TerapieViewController.swift
//  CS Riabilita
//
//  Created by Mac Coobi on 10/05/23.
//  Copyright © 2023 Rubik srls. All rights reserved.
//

import UIKit
import Alamofire
import PMAlertController

class TerapieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {
    
    var type:String!
    
    
    @IBOutlet weak var nessunaTerapia: UILabel!
    @IBOutlet weak var TerapieTableView: UITableView!
    @IBOutlet weak var indietro: UIButton!
    var terapieList = [Terapia]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TerapieTableView.dataSource = self // Imposta il dataSource della tabella
        TerapieTableView.register(UINib(nibName: "TerapiaTableViewCell", bundle: nil), forCellReuseIdentifier: "TerapiaTableViewCell")
        TerapieTableView.delegate = self
        TerapieTableView.dataSource = self
        TerapieTableView.backgroundColor = UIColor.white

        
        loadTerapie(side:"IN CORSO", allTerapie: "0");
        indietro.setTitle(Utility.getLbl(code: "TORNAINDIETRO"), for: .normal)
        // Do any additional setup after loading the view.
        
        nessunaTerapia.isHidden = true

    }
    
    @IBAction func tornaIndietro(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func TerapValueChanged(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0)
        {
            //FRONTE
            loadTerapie(side: "IN CORSO", allTerapie: "0")
        }
        else
        {
            //RETRO
            loadTerapie(side: "TUTTE", allTerapie: "1")
        }
    }
    
    func loadTerapie(side: String, allTerapie: String) {
        let url = Utility.getBaseUrl()

        let parameters: Parameters = [
            "action": "getTerapie",
            "allTerapie": allTerapie,
            "Token": GeneralUtil.shared.user.token!
        ]

        Alamofire.request(url, method: .post, parameters: parameters)
            .responseString { response in
                print("DETTAGLI TERAPIE")
                print("Response doc1", response)
            }
            .responseJSON { response in
                print("Response doc2", response)
                do {
                    self.terapieList.removeAll()
                    let jsonArray = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! [[String: Any]]
                    
                    let currentDate = Date()
                    print("Current Date:", currentDate) // Add this line for debugging
                    let filteredTerapie = jsonArray.compactMap { jsonObject -> Terapia? in
                        guard let dataArr = Terapia(from: jsonObject as AnyObject) else {
                            return nil
                        }
                        // Include all terapie for "TUTTE" regardless of their end date
                        return dataArr
                    }
                    
                    self.terapieList = filteredTerapie
                    self.TerapieTableView.reloadData()
                    
                    // Controllo se la lista degli appuntamenti è vuota
                        if self.terapieList.isEmpty {
                            self.nessunaTerapia.isHidden = false
                            self.TerapieTableView.isHidden = true
                        } else {
                            self.nessunaTerapia.isHidden = true
                            self.TerapieTableView.isHidden = false
                            self.TerapieTableView.reloadData()
                        }
                    
                } catch {
                    print("Error: (Retrieving Data)")
                }
            }

    }



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return terapieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item: TerapiaTableViewCell = TerapieTableView.dequeueReusableCell(withIdentifier: "TerapiaTableViewCell", for: indexPath) as! TerapiaTableViewCell
        print("ciao1 ")
        item.selectionStyle = .none // Imposta lo stile di selezione a "None" per evitare la colorazione di sfondo
        item.terapiaLabel.text = terapieList[indexPath.row].nomeTer
        return item
        print("ciao2 ")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let terapia = terapieList[indexPath.row]

       

        // Chiama la tua nuova funzione apriInfoTerapie con i dati della terapia selezionata
        apriInfoTerapie(with: terapia)
    }


    func apriInfoTerapie(with terapia: Terapia) {
        DispatchQueue.main.async {
            let vc = InfoTerapiaViewController()
            // Passa le informazioni della terapia al InfoTerapieViewController, puoi usare proprieta' nel controller per mostrare i dati
            vc.terapia = terapia // Pass the selected terapia to InfoTerapiaViewController
            vc.modalPresentationStyle = .overFullScreen // or .overFullScreen for transparency
            self.present(vc, animated: true, completion: nil)
            
            // Deselect the selected cell to remove the selection highlight
                        if let indexPath = self.TerapieTableView.indexPathForSelectedRow {
                            self.TerapieTableView.deselectRow(at: indexPath, animated: true)
                        }
        }
    }

    
    // MARK: - UITableViewDelegate
    
    
}
