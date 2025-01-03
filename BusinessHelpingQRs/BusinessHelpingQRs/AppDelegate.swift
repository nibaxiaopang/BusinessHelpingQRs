//
//  AppDelegate.swift
//  BusinessHelpingQRs
//
//  Created by Swaminarayan on 19/11/24.
//

import UIKit
import FirebaseCore
import FirebaseMessaging
import AppsFlyerLib
import AppTrackingTransparency

@main
class AppDelegate: UIResponder, UIApplicationDelegate , AppsFlyerLibDelegate{

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let loginUser = UserDefaults.standard.value(forKey: "LOGIN_USER")
        
        if loginUser == nil {
            self.setIntroScreen()
        } else {
            self.setHomeScreen()
        }
        
        FirebaseApp.configure()
        
        let appsFlyer = AppsFlyerLib.shared()
        appsFlyer.appsFlyerDevKey = UIViewController.businessAppsFlyerDevKey()
        appsFlyer.appleAppID = "6739531522"
        appsFlyer.waitForATTUserAuthorization(timeoutInterval: 50)
        appsFlyer.delegate = self
        
        return true
    }
    
    func setHomeScreen() {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let navigationController = BusinessNavViewController.init(rootViewController: viewcontroller)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
    }
    
    func setIntroScreen() {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: "IntroVC") as! IntroVC
        let navigationController = BusinessNavViewController.init(rootViewController: viewcontroller)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    /// AppsFlyerLibDelegate
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        print("success appsflyer")
    }
    
    func onConversionDataFail(_ error: Error) {
        print("error appsflyer")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        AppsFlyerLib.shared().start()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                }
            }
        }
    }
}

