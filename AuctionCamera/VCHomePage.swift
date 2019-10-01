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
   
    //@IBOutlet weak var btnAuctionXPhotos: UIButton!
    @IBOutlet var butClear: UIButton!
    @IBOutlet var butPhoto: UIButton!
    @IBOutlet var txtVIN: UITextField!
    
    var limit = ""
    var week = ""
    
    
    
    struct EquipmentList:Decodable {
        let vl: [vcl]
    }
    struct vcl: Decodable{
        var EQGroup: String
        var EQCode: String
        var EQDesc: String
    }
    
    var screwedUpCode=[myScrewedUpCode]()
    //Entire Equipment List
    var equipmentList=[EquipmentCodes]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtVIN.delegate = self
        // Do any additional setup after loading the view.
        getEquipment()
    }
    
    @IBAction func toEquipmentSection(_ sender: Any) {
        if txtVIN.text?.isEmpty ?? true {
            let alert = UIAlertController(title: "VIN Missing", message: "Must insert VIN to Continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
         
            present(alert, animated: true, completion: nil)
        } else {
            //UserDefaults.standard.set(txtVIN.text, forKey: "vin") //setObject
            performSegue(withIdentifier: "toEquipment", sender: nil)
        }
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
            //alert.addAction(UIAlertAction(title: "Copy Close", style: .destructive, handler: {
            //_ in  if self.delegate != nil {
            //self.delegate?.sendData(data:object.stringValue!)
            //self.navigationController?.popViewController(animated: true)
            //self.dismiss(animated: true, completion: nil)
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
    
    
    
    @IBAction func lastWeekFindMissing(_ sender: Any) {
        self.week = "last"
        self.limit = "0test"
        self.performSegue(withIdentifier: "toMissingPhotos", sender: nil)
    }
    @IBAction func lastWeekFindMissing15(_ sender: Any) {
        self.week = "last"
        self.limit = "14test"
        self.performSegue(withIdentifier: "toMissingPhotos", sender: nil)
    }
    @IBAction func findMissingPhotos(_ sender: Any) {
        self.week = "this"
        self.limit = "0"
        self.performSegue(withIdentifier: "toMissingPhotos", sender: nil)
    }
    @IBAction func findMissingPhotos15(_ sender: Any) {
        self.week = "this"
        self.limit = "14"
        self.performSegue(withIdentifier: "toMissingPhotos", sender: nil)
    }
    
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ScanSegue" {
            let vc : VCScanner = segue.destination as! VCScanner
            vc.delegate = self
        }else if segue.identifier == "AuctionPhotos"{
            let vc = segue.destination as! VCAuctionPhotos
            vc.vin = txtVIN.text!
        }else if segue.identifier == "toMissingPhotos" {
            let vc = segue.destination as! VCMissingPhotos
            vc.week = week
            vc.photoNumber = limit
        }else if segue.identifier == "toEquipment" {
            let vc = segue.destination as! VCEquipment
            vc.vin = txtVIN.text!
            vc.equipmentList = equipmentList
        }
    }
    
    @IBAction func burClear_touchupInside(_ sender: Any) {
        txtVIN.text = ""
        butClear.isHidden = true
    }

    
    func sendData(data: String) {
        if data.uppercased().contains("I") || data.uppercased().contains("O") ||  data.uppercased().contains("Q") ||  data.uppercased().contains("-") ||  data.uppercased().contains("+") || data.uppercased().contains("$") || data.uppercased().contains("<") || data.uppercased().contains(".") || data.uppercased().contains(">") || data.uppercased().contains("!") {
            
            var newData = data.replacingOccurrences(of: "I", with: "")
            newData = newData.replacingOccurrences(of: "0", with: "")
            newData = newData.replacingOccurrences(of: "Q", with: "")
            newData = newData.replacingOccurrences(of: "-", with: "")
            newData = newData.replacingOccurrences(of: "+", with: "")
            newData = newData.replacingOccurrences(of: ".", with: "")
            newData = newData.replacingOccurrences(of: "<", with: "")
            newData = newData.replacingOccurrences(of: ">", with: "")
            newData = newData.replacingOccurrences(of: "!", with: "")
            newData = newData.replacingOccurrences(of: "$", with: "")
            
            self.txtVIN.text = newData
            UserDefaults.standard.set(newData, forKey: "vin") //setObject
        }else{
            self.txtVIN.text = data
            UserDefaults.standard.set(data, forKey: "vin") //setObject
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscapeLeft
    }
    
    
    
    //Equipment Section
    func getEquipment(){
        showSpinner(onView: self.view)
        let todoEndpoint: String = "https://mobile.aane.com/auction.asmx/getEquipment?requestStr=\(0)"
        
        guard let url = URL(string: todoEndpoint) else {
            print("ERROR: cannot create URL")
            self.removeSpinner()
            return
        }
        
        print(url)
        var urlRequest = URLRequest(url: url)
        
        urlRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("text/xml", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest){ data, response, error in
            guard error == nil else{
                print("ERROR: calling GET: \(error!)")
                self.removeSpinner()
                return
            }
            
            guard let data = data else { print("DATA ERROR!!!"); return }
            
            do {
                print(data)
                
                let t = try JSONDecoder().decode(EquipmentList.self, from: data)
                DispatchQueue.main.async {
                    //print(t.vl)
                    for i in t.vl{
                        self.screwedUpCode.append(myScrewedUpCode(EQGroup: i.EQGroup, EQDesc: i.EQDesc, EQCode: i.EQCode))
                    }
                    
                    self.fixMyError()
                    
                    self.removeSpinner()
                    
                }
                
            }catch {
                print("\(error)")
                self.removeSpinner()
            }
           // self.removeSpinner()
            
            
        }
        task.resume()
       // self.removeSpinner()
        
    }
    
    func fixMyError(){
        for e in screwedUpCode{
            let f = EquipmentCodes(EQGroup: e.EQGroup, EQDesc: e.EQDesc, id: e.EQCode)
            equipmentList.append(f)
        }
    }
    
    
}
