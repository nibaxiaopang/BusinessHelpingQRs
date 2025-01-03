//
//  ProductDetailsVC.swift
//  BusinessHelpingQRs
//
//  Created by Swaminarayan on 19/11/24.
//

import UIKit

class ProductDetailsVC: UIViewController {

    //MARK: - IBOUtlet
    
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtProduct: UITextField!
    @IBOutlet weak var txtIngredients: UITextField!
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
    @IBAction func Generate(_ sender: Any) {
        
        if self.txtProduct.text == "" || self.txtIngredients.text == "" || self.txtPrice.text == "" {
            self.view.makeToast("please enter all the details")
        } else {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "QRVC") as! QRVC
            vc.qrdetails = "Product Name : \(self.txtProduct.text ?? "")\nProduct Ingredients : \(self.txtIngredients.text ?? "")\nProduct Price : \(self.txtPrice.text ?? "")"
            vc.topHeading = "Product Details QR"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
}
