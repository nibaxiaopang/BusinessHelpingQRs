//
//  AppDelegate.swift
//  BusinessHelpingQRs
//
//  Created by Swaminarayan on 19/11/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let loginUser = UserDefaults.standard.value(forKey: "LOGIN_USER")
        
        if loginUser == nil {
            self.setIntroScreen()
        } else {
            self.setHomeScreen()
        }
        
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


}

