//
//  ViewController.swift
//  BarcodeReader
//
//  Created by Jacob Ellious on 5/30/17.
//  Copyright © 2017 Jacob Ellious. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var barcodeTextView: UITextView!
  @IBOutlet weak var imageView: UIImageView!
  weak var actionToEnable : UIAlertAction?

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }

  @IBAction func generateBarcode(_ sender: Any) {
    
    
    let titleStr = "Enter a barcode"
    let messageStr = "Example: A1234B567"
    
    let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertControllerStyle.alert)
    
    let placeholderStr =  "A1234B567"
    
    alert.addTextField(configurationHandler: {(textField: UITextField) in
      textField.placeholder = placeholderStr
    })
    
    let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (_) -> Void in
      
    })
    
    let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (_) -> Void in
      let textfield = alert.textFields!.first!
      
      let barcode = textfield.text!
      
      self.imageView.image = self.generateBarcode(from: barcode)
      self.barcodeTextView.text = barcode
    })
    
    alert.addAction(cancel)
    alert.addAction(action)

    self.present(alert, animated: true, completion: nil)
  }
  
  
  
  func generateBarcode(from string: String) -> UIImage? {
    let data = string.data(using: String.Encoding.ascii)
    
    if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
      filter.setValue(data, forKey: "inputMessage")
      let transform = CGAffineTransform(scaleX: 3, y: 3)
      
      if let output = filter.outputImage?.applying(transform) {
        return UIImage(ciImage: output)
      }
    }
    return nil
  }
}
