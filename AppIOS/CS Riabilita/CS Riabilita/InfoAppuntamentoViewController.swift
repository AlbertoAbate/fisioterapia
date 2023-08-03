//
//  InfoAppuntamentoViewController.swift
//  CS Riabilita
//
//  Created by Mac Coobi on 03/08/23.
//  Copyright © 2023 Rubik srls. All rights reserved.
//

import UIKit

class InfoAppuntamentoViewController: UIViewController {

    @IBOutlet weak var nomeApp: UILabel!
    @IBOutlet weak var cognomeApp: UILabel!
    @IBOutlet weak var statoApp: UILabel!
    @IBOutlet weak var dataApp: UILabel!
    @IBOutlet weak var tagApp: UILabel!
    @IBOutlet weak var durataApp: UILabel!
    @IBOutlet weak var indietro: UIButton!
    var appuntamento: Appuntamento?

    @IBAction func tornaIndietro(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        indietro.setTitle(Utility.getLbl(code: "TORNAINDIETRO"), for: .normal)

        // Do any additional setup after loading the view.
        // Set the terapia data to the labels
        //nomeApp.text = Utility.getLbl(code: "TITLETERAPIA");
                if let appuntamento = self.appuntamento {
                    nomeApp.text = Utility.getLbl(code: "NOMEAPP") + appuntamento.nome ?? ""
                    cognomeApp.text = Utility.getLbl(code: "COGNOMEAPP") + appuntamento.cognome ?? ""
                    statoApp.text = Utility.getLbl(code: "STATOAPP") + appuntamento.stato ?? ""
                    dataApp.text = Utility.getLbl(code: "DATAAPP") + appuntamento.ggFormat ?? ""
                    tagApp.text = Utility.getLbl(code: "TAG") + appuntamento.tag ?? ""
                    durataApp.text = Utility.getLbl(code: "DURATAAPP") + appuntamento.durata ?? ""

                }
        

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
