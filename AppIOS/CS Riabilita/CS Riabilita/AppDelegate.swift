//
//  AppDelegate.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 31/08/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//


import UIKit
import GoogleMaps
import Firebase
import UserNotifications
import SwiftMessages

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        //and then
        if launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] != nil { //controlliamo se stiamo avviando la app tramite tap di una notifica,
            
    
            let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as! [AnyHashable: Any]
            GeneralUtil.shared.actionType = (userInfo["ActionType"] as! String);
            GeneralUtil.shared.dataAction = (userInfo["DataAction"] as! String)
            
        }
        
        
        GMSServices.provideAPIKey("AIzaSyCb0ujVpI8Jr_zVGGlpkjzs4tR7RiSq80c")
        
        FirebaseApp.configure()
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            
            
            
            
            UNUserNotificationCenter.current().delegate = self
            Messaging.messaging().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization (options:authOptions) { (granted, error) in
                // Enable or disable features based on authorization.
                print("FATTOOOO");
                //self.connectToFcm()
                
            }
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
             UNUserNotificationCenter.current().delegate = self
            Messaging.messaging().delegate = self
        }
        
        application.registerForRemoteNotifications()
        
        //GeneralUtil.shared.loadData() //restore logged user data
       
        
        
    

        
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let content = notification.request.content
        // Process notification content
        print("\(content.userInfo)")
        completionHandler([.alert, .sound]) // Display notification as
        
    }
    
   
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        let actionType = userInfo["ActionType"] as! String
        let actionData = userInfo["DataAction"] as! String
        //let c = Citygram();
        //c.interceptAction(actionType: actionType, actionData: actionData)
     }
    
    
    
   
   
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("ECCOLO MSGGG")
        print("GINGU Firebase registration token: \(fcmToken)")
        connectToFcm()
    }
    
    func connectToFcm()
    {
        Messaging.messaging().connect { (error) in
            if (error != nil) {
                print("Unable to connect with FCM. \(String(describing: error))")
            } else {
                print("Connected to FCM.")
                //Messaging.
                print("REGISTRO TOPIC CITYGRAM");
                //InstanceID.instanceID().setAPNSToken(Messaging.messaging().apnsToken!, type: InstanceIDAPNSTokenType.unknown)
                Messaging.messaging().subscribe(toTopic: "citygram")
            }
        }
    }
    
  
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        print("REGISTRO SET APNS")
        Messaging.messaging().apnsToken = deviceToken
        print("SETTO TOKEN");
        
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

   
}







