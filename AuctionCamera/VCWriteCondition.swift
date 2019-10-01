//
//  VCWriteCondition.swift
//  AuctionCamera
//
//  Created by Matthew Sansoucie on 9/13/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit

class VCWriteCondition: UIViewController {

    var vin: String = ""
    var aucid: String = ""
    
    var itemCode: String = ""
    
    @IBOutlet weak var scLocation: UISegmentedControl!
    var buttionID = "0"
    @IBOutlet weak var scConditionType: UISegmentedControl!
    var sSubClass = "Body"
    @IBOutlet weak var btnDescription: UIButton!
    @IBOutlet weak var btnCondition: UIButton!
    
    @IBOutlet weak var txtComment: UITextField!
    @IBOutlet weak var txtLaborHrs: UITextField!
    @IBOutlet weak var txtLaborCost: UITextField!
    @IBOutlet weak var txtPartCost: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getConditionCodes(){
        
    }
    
    
    @IBAction func changedLocation(_ sender: Any) {
        
        switch scLocation.selectedSegmentIndex {
        case 0:
            buttionID = "3"
        case 1:
            buttionID = "4"
        case 2:
            buttionID = "0"
        case 3:
            buttionID = "0"
        case 4:
            buttionID = "0"
        case 5:
            buttionID = "0"
        case 6:
            buttionID = "0"
        case 7:
            buttionID = "0"
        default:
            let alert = UIAlertController(title: "Unknown Error", message: "This message should NEVER pop up!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { action in
                self.navigationController?.popViewController(animated: true)
            }))
            
            present(alert, animated: true, completion: nil)
        }
        
       
        
    }
    
    @IBAction func changedCoditionType(_ sender: Any) {
        switch scConditionType.selectedSegmentIndex {
        case 0:
            sSubClass = "Body"
        case 1:
            sSubClass = "Glass"
        case 2:
            sSubClass = "Accessories"
        case 3:
            sSubClass = "Wheels"
        case 4:
            sSubClass = "Material"
        case 5:
            sSubClass = "General"
        case 6:
            sSubClass = "Operational"
        case 7:
            sSubClass = "Overall"
        default:
            let alert = UIAlertController(title: "Unknown Error", message: "This message should NEVER pop up!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { action in
                self.navigationController?.popViewController(animated: true)
            }))
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func submitCondition(_ sender: Any) {
        
        /*
         
         aucid
         itemcodes
         comments
         buttonID //front, left, right
         conditionIDCode
         sSubclass
         ParCost
         Laborcost
         LaborHours
        -- DateWritten
         
         */
        
       
        
        let comment = self.txtComment.text
        let partCost = self.txtPartCost.text
        let laborCost = self.txtLaborCost.text
        let laborHr = self.txtLaborHrs.text
        
        let myURL = "https://mobile.aane.com/auction.asmx/AddCondition?lAucid=\(aucid)&lItemCode=\(itemCode)&comment=\(self.forURLs(s: comment!))"
        
        
    }
    
    func forURLs(s: String) -> String {
        return s.replacingOccurrences(of: " ", with: "%20")
    }
}


