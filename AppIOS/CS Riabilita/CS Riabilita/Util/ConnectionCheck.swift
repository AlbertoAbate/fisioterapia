//
//  ConnectionCheck.swift
//  CS Riabilita
//
//  Created by Gianni Inguscio on 31/08/2020.
//  Copyright © 2020 Rubik srls. All rights reserved.
//


import Foundation
import SystemConfiguration
import SwiftMessages

public class ConnectionCheck {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        let res = (isReachable && !needsConnection)
        if (res == false)
        {
            let view = MessageView.viewFromNib(layout: .cardView)
            SwiftMessages.defaultConfig.presentationStyle = .top

            // Theme message elements with the warning style.
            view.configureTheme(.error)
            
            // Add a drop shadow.
            //view.configureDropShadow()
            view.button?.isHidden = true;
            // Set message title, body, and icon. Here, we're overriding the default warning
            // image with an emoji character.
            let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()
            view.configureContent(title: "Ops...", body: "ControllaConnessione".localized, iconText: iconText!)
            
            // Show the message.
            SwiftMessages.show(view: view)
            
        }
        return (isReachable && !needsConnection)
    }
}
