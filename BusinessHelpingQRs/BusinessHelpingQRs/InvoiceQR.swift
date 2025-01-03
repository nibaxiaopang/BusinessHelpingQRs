//
//  InvoiceQR.swift
//  BusinessHelpingQRs
//
//  Created by Swaminarayan on 19/11/24.
//

import UIKit

class InvoiceQR: UIViewController {

    //MARK: - IBOUtlet
    
    @IBOutlet weak var txtTotalAmount: UITextField!
    @IBOutlet weak var txtTaxAmount: UITextField!
    @IBOutlet weak var txtOrderAmount: UITextField!
    @IBOutlet weak var txtTableNo: UITextField!
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
        
        if self.txtTableNo.text == "" || self.txtTaxAmount.text == "" || self.txtOrderAmount.text == "" || self.txtTotalAmount.text == "" {
            self.view.makeToast("please enter all the details")
        } else {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "QRVC") as! QRVC
            vc.qrdetails = "Table No : \(self.txtTableNo.text ?? "")\nOrder Amount : \(self.txtOrderAmount.text ?? "")\nTax Amount : \(self.txtTaxAmount.text ?? "")\nTotal Amount : \(self.txtTotalAmount.text ?? "")"
            vc.topHeading = "Invoice QR"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
}
