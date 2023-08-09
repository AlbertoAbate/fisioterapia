//
//  InfoTerapiaViewController.swift
//  CS Riabilita
//
//  Created by Mac Coobi on 28/07/23.
//  Copyright © 2023 Rubik srls. All rights reserved.
//

import UIKit

class InfoTerapiaViewController: UIViewController {

    
    @IBOutlet weak var titleTera: UILabel!
    @IBOutlet weak var teraTipo: UILabel!
    @IBOutlet weak var teraNominativo: UILabel!
    @IBOutlet weak var parteCorpo: UILabel!
    @IBOutlet weak var dataInizioIT: UILabel!
    @IBOutlet weak var dataFine: UILabel!
    @IBOutlet weak var testoTerapia: UILabel!
    @IBOutlet weak var noteTerapia: UILabel!
    @IBOutlet weak var indietro: UIButton!
    // Property to hold the selected terapia data
        var terapia: Terapia?

    override func viewDidLoad() {
        super.viewDidLoad()

        indietro.setTitle(Utility.getLbl(code: "TORNAINDIETRO"), for: .normal)
        // Do any additional setup after loading the view.
        // Set the terapia data to the labels
        titleTera.text = Utility.getLbl(code: "TITLETERAPIA");
                if let terapia = self.terapia {
                    teraNominativo.text = Utility.getLbl(code: "TIPOTERAPIA") + terapia.terapiaTipo ?? ""
                    teraTipo.text = Utility.getLbl(code: "NOMINATIVO") + terapia.nominativo ?? ""
                    parteCorpo.text = Utility.getLbl(code: "ATTIVITA") + terapia.parteCorpo ?? ""
                    dataInizioIT.text = Utility.getLbl(code: "DATAINIZIO") + terapia.dataInizioIt ?? ""
                    if let dataFineIt = terapia.dataFineIt, !dataFineIt.isEmpty {
                                    dataFine.text = Utility.getLbl(code: "DATAFINE") + dataFineIt
                                } else {
                                    dataFine.text = Utility.getLbl(code: "DATAFINETERAPIA"); // Set the label to display a hyphen "-" if dataFineIt is not available or is empty
                                }
                    testoTerapia.text = Utility.getLbl(code: "DATITERAPIA") + terapia.testo ?? ""
                    
                    // Set the label to display the text on multiple lines
                                testoTerapia.numberOfLines = 0
                                testoTerapia.lineBreakMode = .byWordWrapping
                    
                                // Display "Nessuna nota" if terapia.note is empty, otherwise append the note to the localized label text
                                if let note = terapia.note, !note.isEmpty {
                                    noteTerapia.text = Utility.getLbl(code: "NOTETERAPIA") + note
                                } else {
                                    noteTerapia.text = Utility.getLbl(code: "NOTETERAPIA") + Utility.getLbl(code: "NONOTETERAPIA")
                                }                }
        

    }

    
    @IBAction func tornaIndieto(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
