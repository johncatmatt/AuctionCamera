//
//  VCEquipment.swift
//  AuctionCamera
//
//  Created by Matthew Sansoucie on 8/16/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit


class VCEquipment: UIViewController {

  
    

    @IBOutlet weak var lblEngine: UILabel!
    @IBOutlet weak var lblTransmission: UILabel!
    @IBOutlet weak var lblInterior: UILabel!
    @IBOutlet weak var lblRoof: UILabel!
    @IBOutlet weak var lblRadio: UILabel!
    @IBOutlet weak var lblBreaks: UILabel!
    @IBOutlet weak var lblSeats: UILabel!
    @IBOutlet weak var lblAirbag: UILabel!
    @IBOutlet weak var lblDriveType: UILabel!
    @IBOutlet weak var lblExteriorColor: UILabel!
    @IBOutlet weak var lblInteriorColor: UILabel!
    @IBOutlet weak var lblMileageType: UILabel!
    @IBOutlet weak var lblTireRating: UILabel!
    @IBOutlet weak var lblWheels: UILabel!
    
    @IBOutlet weak var btnEngine: UIButton!
    @IBOutlet weak var btnTrans: UIButton!
    @IBOutlet weak var btnInterior: UIButton!
    @IBOutlet weak var btnRoof: UIButton!
    @IBOutlet weak var btnRadio: UIButton!
    @IBOutlet weak var btnBreaks: UIButton!
    @IBOutlet weak var btnSeats: UIButton!
    @IBOutlet weak var btnAirbag: UIButton!
    @IBOutlet weak var btnDriveType: UIButton!
    @IBOutlet weak var btnExteriorColor: UIButton!
    @IBOutlet weak var btnInteriorColor: UIButton!
    @IBOutlet weak var btnMileageType: UIButton!
    @IBOutlet weak var btnTireRating: UIButton!
    @IBOutlet weak var btnWheels: UIButton!
    
    var vin: String = ""
    var equ: String = ""
    var equipmentList=[EquipmentCodes]()
    var selectedList=[EquipmentCodes]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        equipmentList.append(EquipmentCodes(EQGroup: "AIRBAG", EQDesc: "10 Airbags", id: "50054"))
        equipmentList.append(EquipmentCodes(EQGroup: "AIRBAG", EQDesc: "3 Airbags", id: "50047"))
        equipmentList.append(EquipmentCodes(EQGroup: "AIRBAG", EQDesc: "4 Airbags", id: "50048"))

        equipmentList.append(EquipmentCodes(EQGroup: "ENGINE", EQDesc: "10-Cylinder", id: "19"))
        equipmentList.append(EquipmentCodes(EQGroup: "ENGINE", EQDesc: "10-Cylinder Diesel", id: "50328"))
        equipmentList.append(EquipmentCodes(EQGroup: "ENGINE", EQDesc: "10-Cylinder Diesel Turbo", id: "50280"))
        
        equipmentList.append(EquipmentCodes(EQGroup: "TRANSMISSION", EQDesc: "Average", id: "50236"))
        equipmentList.append(EquipmentCodes(EQGroup: "TRANSMISSION", EQDesc: "Good", id: "50237"))
        equipmentList.append(EquipmentCodes(EQGroup: "TRANSMISSION", EQDesc: "Poor", id: "50238"))
        
        self.navigationItem.title = "Equipment (TESTING!!!)"
    }
    

    
    @IBAction func SaveEquipment(_ sender: Any) {
        
    }
    
    //MARK Handle the Equipment drop downs
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectType"{
            let vc = segue.destination as! VCEquipmentTypes
            
            vc.equipment = self.equ
            vc.selectedEquipmentList = selectedList
        }
    }
    @IBAction func EngineTypes(_ sender: Any) {
        equ = lblEngine.text!
        getList(group: "ENGINE")
        performSegue(withIdentifier: "selectType", sender: nil)
    }
    @IBAction func TransType(_ sender: Any) {
        equ = lblTransmission.text!
         getList(group: "TRANSMISSION")
        performSegue(withIdentifier: "selectType", sender: nil)
    }
    @IBAction func InteriorType(_ sender: Any) {
        equ = lblInterior.text!
        getList(group: "INTERIORTYPE")
        performSegue(withIdentifier: "selectType", sender: nil)
    }
    @IBAction func RoofType(_ sender: Any) {
        equ = lblRoof.text!
        getList(group: "ROOF")
        performSegue(withIdentifier: "selectType", sender: nil)
    }
    @IBAction func RadioType(_ sender: Any) {
        equ = lblRadio.text!
        getList(group: "RADIO")
        performSegue(withIdentifier: "selectType", sender: nil)
    }
    @IBAction func BreaksType(_ sender: Any) {
        equ = lblBreaks.text!
        getList(group: "BREAKS")
        performSegue(withIdentifier: "selectType", sender: nil)
    }
    @IBAction func SeatsType(_ sender: Any) {
        equ = lblSeats.text!
        getList(group: "SEATS")
        performSegue(withIdentifier: "selectType", sender: nil)
    }
    @IBAction func AirbagTypes(_ sender: Any) {
        equ = lblAirbag.text!
        getList(group: "AIRBAG")
        performSegue(withIdentifier: "selectType", sender: nil)
    }
    @IBAction func DriveTypes(_ sender: Any) {
        equ = lblDriveType.text!
        getList(group: "DRIVETYPE")
        performSegue(withIdentifier: "selectType", sender: nil)
    }
    @IBAction func ExteriorColorTypes(_ sender: Any) {
        equ = lblExteriorColor.text!
        getList(group: "EXTCOLOR")
        performSegue(withIdentifier: "selectType", sender: nil)
    }
    @IBAction func InteriorColorTypes(_ sender: Any) {
        equ = lblInteriorColor.text!
        getList(group: "COLOR")
        performSegue(withIdentifier: "selectType", sender: nil)
    }
    @IBAction func MileageType(_ sender: Any) {
        equ = lblMileageType.text!
        getList(group: "MILEAGETYPE")
        performSegue(withIdentifier: "selectType", sender: nil)
    }
    @IBAction func TireRatingTypes(_ sender: Any) {
        equ = lblTireRating.text!
        getList(group: "TIRE_RATING")
        performSegue(withIdentifier: "selectType", sender: nil)
    }
    @IBAction func WheelsTypes(_ sender: Any) {
        equ = lblWheels.text!
        getList(group: "WHEELS")
        performSegue(withIdentifier: "selectType", sender: nil)
    }
    
    
    func getList(group: String) {
        selectedList.removeAll()
        for e in equipmentList {
            if e.EQGroup == group {
                selectedList.append(e)
            }
        }
    }
    
    
}
