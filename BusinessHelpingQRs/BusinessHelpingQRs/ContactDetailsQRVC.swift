//
//  ContactDetailsQRVC.swift
//  BusinessHelpingQRs
//
//  Created by Swaminarayan on 19/11/24.
//

import UIKit

class ContactDetailsQRVC: UIViewController {

    //MARK: - IBOUtlet
    
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtShopAddress: UITextField!
    @IBOutlet weak var txtShopName: UITextField!
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Functions
    
    //MARK: - API Calling
    
    //MARK: - IBActions
    @IBAction func TapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func TapGenrate(_ sender: Any) {
        
        if self.txtShopName.text == "" || self.txtShopAddress.text == "" || self.txtEmailAddress.text == "" || self.txtMobileNumber.text == "" {
            self.view.makeToast("please enter all the details")
        } else {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "QRVC") as! QRVC
            vc.qrdetails = "Shop Name : \(self.txtShopName.text ?? "")\nShop Address : \(self.txtShopAddress.text ?? "")\nMobile Number : \(self.txtMobileNumber.text ?? "")\nEmail Address : \(self.txtEmailAddress.text ?? "")"
            vc.topHeading = "Contact Details QR"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
}
