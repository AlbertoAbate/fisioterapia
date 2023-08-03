//
//  GeneralUtil.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 31/08/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//


import Foundation
import Alamofire

final class GeneralUtil {
    
    var labelsArray:[Label]
    // Can't init is singleton
    private init() {
        labelsArray = [Label]()
    }
    
    // MARK: Shared Instance
    
    static let shared = GeneralUtil()
    //var user = Utente();
    var idLocation = "1";
    var idlang = "ITA";
    var logoUrl = "";
    var nomeApp = "CS Riabilita";
    //var nomeApp = "";
    //var idLocation = "";
    //var nomeLocation = "";
    //var isCustom = "0"; //se è una app custom lo sapremo con questo flag.
    var user = Utente()
    var nomeLocation = "csriabilita";
    var isCustom = "1";
    var nextView = "";
    var nextIdView = "";
    var nextTypeView = "";
    var actionType = "";
    var dataAction = "";
    var crtProtocollo:Protocollo!
    var howMuchDismiss = 0;
    // MARK: Local Variable
    
   
    
    func firstCall()
    {
        //Code Process
        print("Location granted")
    }
    
    func loadData()
    {
        
        let location = UserDefaults.standard.string(forKey: "location");
        if (location != nil && location != "")
        {
            self.idLocation = location!;
            print("location:" + self.idLocation);
        }
        
        let namelocation = UserDefaults.standard.string(forKey: "namelocation");
        if (namelocation != nil && namelocation != "")
        {
            self.nomeLocation = namelocation!;
            print("namelocation:" + self.nomeLocation);
        }
        
        let appname = UserDefaults.standard.string(forKey: "appname");
        if (appname != nil && appname != "")
        {
            self.nomeApp = appname!;
            print("appname:" + self.nomeApp);
        }
        
        let logoUrl = UserDefaults.standard.string(forKey: "logourl");
        if (logoUrl != nil && logoUrl != "")
        {
            self.logoUrl = logoUrl!;
            print("logoUrl:" + self.logoUrl);
        }
        
        let token = UserDefaults.standard.string(forKey: "token");
        if (token != nil && token != "")
        {
            self.user.token = token;
            print("TOKEN:" + self.user.token);
        }
        
        let nome = UserDefaults.standard.string(forKey: "nome");
        if (nome != nil  && nome != "")
        {
            self.user.nome = nome;
            print("nome:" + self.user.nome);
        }
        
        let cognome = UserDefaults.standard.string(forKey: "cognome");
        if (cognome != nil  && cognome != "")
        {
            self.user.cognome = cognome;
             print("cognome:" + self.user.cognome);
        }
        
        let email = UserDefaults.standard.string(forKey: "email");
        if (email != nil  && email != "")
        {
            self.user.email = email;
             print("email:" + self.user.email);
        }
        
        let role = UserDefaults.standard.string(forKey: "role");
        if (role != nil  && role != "")
        {
            self.user.role = role;
             print("role:" + self.user.role);
        }
        
        let phone = UserDefaults.standard.string(forKey: "phone");
        if (phone != nil  && phone != "")
        {
            self.user.phone = phone;
             print("phone:" + self.user.phone);
        }
        
        
    }
    
    
    
}



