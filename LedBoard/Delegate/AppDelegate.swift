//
//  AppDelegate.swift
//  LedBoard
//
//  Created by 김하은 on 2023/07/25.
//

import UIKit
import GoogleMobileAds
import AppTrackingTransparency

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        ATTrackingManager.requestTrackingAuthorization { status in
           #if DEBUG
            GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "755e19f6e5a3b4141324d78c3193f06b" ]
           #else
            GADMobileAds.sharedInstance().start(completionHandler: nil)
           #endif
      }
        
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
}

