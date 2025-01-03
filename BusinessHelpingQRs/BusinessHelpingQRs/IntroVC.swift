//
//  IntroVC.swift
//  BusinessHelpingQRs
//
//  Created by Swaminarayan on 19/11/24.
//

import UIKit

class IntroVC: UIViewController {

    //MARK: - IBOUtlet
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Functions
    
    //MARK: - API Calling
    
    //MARK: - IBActions
    @IBAction func TapLets(_ sender: Any) {
        UserDefaults.standard.setValue(true, forKey: "LOGIN_USER")
        UserDefaults.standard.synchronize()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setHomeScreen()
    }
    
}
