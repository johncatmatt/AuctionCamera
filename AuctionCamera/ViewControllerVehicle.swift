//
//  ViewControllerVehicle.swift
//  AuctionCamera
//
//  Created by John Sansoucie on 3/7/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit

class ViewControllerVehicle: UIViewController
,SendDataFromDelegate, UITextFieldDelegate{

    @IBOutlet var butPhoto: UIButton!
    @IBOutlet var txtVIN: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtVIN.delegate = self
        // Do any additional setup after loading the view.
        
        
    }
  
    
    @IBAction func butPhotoPress(_ sender: UIButton) {
        
         if txtVIN.text?.isEmpty ?? true {
        let alert = UIAlertController(title: "VIN Missing", message: "Must insert VIN to Continue", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
     //   alert.addAction(UIAlertAction(title: "Copy Close", style: .destructive, handler: {
       //     _ in  if self.delegate != nil {
        //        self.delegate?.sendData(data:object.stringValue!)
        //        self.navigationController?.popViewController(animated: true)
        //        self.dismiss(animated: true, completion: nil)
        present(alert, animated: true, completion: nil)
        }
        
    }
    
    //exit the textbox when the user clicks return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ScanSegue" {
            let vc : ViewControllerScanner = segue.destination as! ViewControllerScanner
            vc.delegate = self
        }
    }
    
    
    func sendData(data: String) {
        self.txtVIN.text = data
    }
}
