//
//  HomeVC.swift
//  BusinessHelpingQRs
//
//  Created by Swaminarayan on 19/11/24.
//

import UIKit
import StoreKit
import IQKeyboardManagerSwift

class HomeVC: UIViewController {

    //MARK: - IBOUtlet
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        IQKeyboardManager.shared.isEnabled = true
    }
    
    //MARK: - Functions
    
    //MARK: - API Calling
    
    //MARK: - IBActions

    @IBAction func TapUPI(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "UPIVC") as! UPIVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func TapInvoice(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "InvoiceQR") as! InvoiceQR
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func TapProduct(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ProductDetailsVC") as! ProductDetailsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func TapContact(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ContactDetailsQRVC") as! ContactDetailsQRVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func TapShare(_ sender: Any) {
        let objectsToShare = ["BusinessHelpingQRs"]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        activityVC.popoverPresentationController?.sourceRect = CGRect(x: 100, y: 200, width: 300, height: 300)
        self.present(activityVC, animated: true, completion: nil)
    }
    @IBAction func TapRate(_ sender: Any) {
        SKStoreReviewController.requestReview()
    }
}
