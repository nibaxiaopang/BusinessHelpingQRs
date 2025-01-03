//
//  QRVC.swift
//  BusinessHelpingQRs
//
//  Created by Swaminarayan on 19/11/24.
//

import UIKit

class QRVC: UIViewController {

    //MARK: - IBOUtlet
    
    @IBOutlet weak var lblTopHeading: UILabel!
    @IBOutlet weak var imgQR: UIImageView!
    var qrdetails = ""
    var topHeading = ""
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.lblTopHeading.text = self.topHeading
        
        let image = self.generateBusinessQRCode(from: self.qrdetails)
        if image == nil {
            let alertVal = UIAlertController.init(title: "Something went wrong", message: "Please try again.", preferredStyle: .alert)
            alertVal.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { alertOK in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alertVal, animated: true)
        } else {
            self.imgQR.image = image
        }
    }
    
    func generateBusinessQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    
    //MARK: - Functions
    
    //MARK: - API Calling
    
    //MARK: - IBActions
    @IBAction func TapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func TapSave(_ sender: Any) {
        
        let data = self.imgQR.image?.jpegData(compressionQuality: 1.0)
               let finalQR = UIImage.init(data: data!)
               UIImageWriteToSavedPhotosAlbum(finalQR!, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your \(self.topHeading) Code Save Successfully in Your Photo Library. Please Check Now.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    @IBAction func TapShare(_ sender: Any) {
        let objectsToShare = [self.imgQR.image]
        let activityVC = UIActivityViewController(activityItems: objectsToShare as [Any], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        activityVC.popoverPresentationController?.sourceRect = CGRect(x: 100, y: 200, width: 300, height: 300)
        self.present(activityVC, animated: true, completion: nil)
    }
}
