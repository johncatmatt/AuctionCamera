//
//  VCHomePage.swift
//  AuctionCamera
//
//  Created by John Sansoucie on 3/7/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit

protocol  SendDataFromDelegateVIN {
    func sendData(data : String)
}

//parent
class VCHomePage: UIViewController, SendDataFromDelegate, UITextFieldDelegate{
    
    func sendData(data: String) {
        self.txtVIN.text = data
        UserDefaults.standard.set(data, forKey: "vin") //setObject
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscapeLeft
    }
    
    //@IBOutlet weak var btnAuctionXPhotos: UIButton!
    @IBOutlet var butClear: UIButton!
    @IBOutlet var butPhoto: UIButton!
    @IBOutlet var txtVIN: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtVIN.delegate = self
        // Do any additional setup after loading the view.

    }
    
    @IBOutlet weak var btnAuctionXPhotos: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        
        if txtVIN.text?.isEmpty ?? true {
            butClear.isHidden = true
            
        } else {
            butClear.isHidden = false
            
        }
    }
  
    @IBAction func butGetAuctionPhotos(_ sender: Any) {
        
        //AuctionPhotos
        
        if txtVIN.text?.isEmpty == true{
            let alert = UIAlertController(title: "VIN Missing", message: "Must insert VIN to Continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else{
            performSegue(withIdentifier: "AuctionPhotos", sender: nil)
        }
        
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
         } else {
         UserDefaults.standard.set(txtVIN.text, forKey: "vin") //setObject
        }
        
    }
    
    //exit the textbox when the user clicks return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func findMissingPhotos(_ sender: Any) {
        performSegue(withIdentifier: "toMissingPhotos", sender: nil)
        
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ScanSegue" {
            let vc : VCScanner = segue.destination as! VCScanner
            vc.delegate = self
        }else if segue.identifier == "AuctionPhotos"{
            let vc = segue.destination as! VCAuctionPhotos
            vc.vin = txtVIN.text!
            
        }
    }
    
    @IBAction func burClear_touchupInside(_ sender: Any) {
        txtVIN.text = ""
         butClear.isHidden = true
        
        
    }
    
   
}
