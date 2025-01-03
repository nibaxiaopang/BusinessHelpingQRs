//
//  UPIVC.swift
//  BusinessHelpingQRs
//
//  Created by Swaminarayan on 19/11/24.
//

import UIKit

class UPIVC: UIViewController {

    //MARK: - IBOUtlet
    
    @IBOutlet weak var txtUPI: UITextField!
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
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Genrate(_ sender: Any) {
        
        if self.txtUPI.text == "" {
            self.view.makeToast("please enter all the details")
        } else {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "QRVC") as! QRVC
            vc.qrdetails = "\(self.txtUPI.text ?? "")"
            vc.topHeading = "UPI QR"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
}
