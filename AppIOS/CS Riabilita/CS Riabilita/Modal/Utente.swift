//
//  Utente.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 31/08/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//


import Foundation
import Firebase

class Utente: NSObject,MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        
    }
    
    public func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage){
        print("MESSAGGIO DA FIREBASE")
        print(remoteMessage.appData)
    }
    
    
    
    
    var token: String!
    var nome: String!
    var cognome: String!
    var email: String!
    var role: String!
    var phone: String!
    var address: String!
    //var cf: String!
    
    public override init() {
        token = "";
        nome = "";
        cognome = "";
        email = "";
        role = "";
        phone = "";
        address = "";
        //cf = "";
    }
    
    init?(from jsonObject: AnyObject) {
        guard let bName: String = jsonObject.object(forKey: "Name") as? String,
            let bSurname: String = jsonObject.object(forKey: "Surname") as? String,
            let bEmail: String = jsonObject.object(forKey: "Email") as? String,
            let bPhone: String = jsonObject.object(forKey: "Phone") as? String,
            //let bCf: String = jsonObject.object(forKey: "Cf") as? String,
            let bAddress: String = jsonObject.object(forKey: "Address") as? String,
            let bRole: String = jsonObject.object(forKey: "Role") as? String else {
                print("Error: (Creating User Object)")
                return nil
        }
        token = ""
        nome = bName
        cognome = bSurname
        email = bEmail
        role = bRole
        phone = bPhone
        address = bAddress
        //cf = bCf
        super.init()
    }
    
    public func saveUtente()
    {
        GeneralUtil.shared.user = self;
        
        UserDefaults.standard.set(GeneralUtil.shared.user.token, forKey: "token")
        UserDefaults.standard.set(GeneralUtil.shared.user.nome, forKey: "nome")
        UserDefaults.standard.set(GeneralUtil.shared.user.cognome, forKey: "cognome")
        UserDefaults.standard.set(GeneralUtil.shared.user.email, forKey: "email")
        UserDefaults.standard.set(GeneralUtil.shared.user.role, forKey: "role")
        UserDefaults.standard.set(GeneralUtil.shared.user.phone, forKey: "phone")
        UserDefaults.standard.set(GeneralUtil.shared.user.phone, forKey: "address")
        //UserDefaults.standard.set(GeneralUtil.shared.user.phone, forKey: "cf")

        
    }
    
    public func saveLocation()
    {
        UserDefaults.standard.set(GeneralUtil.shared.idLocation, forKey: "location")
        UserDefaults.standard.set(GeneralUtil.shared.nomeLocation, forKey: "namelocation")
        UserDefaults.standard.set(GeneralUtil.shared.logoUrl, forKey: "logourl")
        UserDefaults.standard.set(GeneralUtil.shared.nomeApp, forKey: "appname")
        
        
    }
    
   
    
    public func initTopic()
    {
        Messaging.messaging().delegate = self
        Messaging.messaging().connect { (error) in
            if (error != nil) {
                print("Unable to connect with FCM. \(String(describing: error))")
            } else {
                print("Connected to FCM.")
                //Messaging.
                print("REGISTRO TOPIC LOCATION");
                //InstanceID.instanceID().setAPNSToken(Messaging.messaging().apnsToken!, type: InstanceIDAPNSTokenType.unknown)
                Messaging.messaging().subscribe(toTopic: "csriabilita_location_" + GeneralUtil.shared.idLocation)
                print("csriabilita_location_" + GeneralUtil.shared.idLocation);
            }
        }
    }
    
    public func logout()
    {
        GeneralUtil.shared.user = Utente()
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "nome")
        UserDefaults.standard.removeObject(forKey: "cognome")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "role")
        UserDefaults.standard.removeObject(forKey: "phone")
        UserDefaults.standard.removeObject(forKey: "address")
        //UserDefaults.standard.removeObject(forKey: "cf")

        
        Messaging.messaging().connect { (error) in
            if (error != nil) {
                print("Unable to connect with FCM. \(String(describing: error))")
            } else {
                print("Connected to FCM.")
                //Messaging.
                print("RIMUOVO TOPIC LOCATION");
                //InstanceID.instanceID().setAPNSToken(Messaging.messaging().apnsToken!, type: InstanceIDAPNSTokenType.unknown)
                Messaging.messaging().unsubscribe(fromTopic: "csriabilita_location_" + GeneralUtil.shared.idLocation)
                print("csriabilita_location_" + GeneralUtil.shared.idLocation);
            }
        }
    }
}

