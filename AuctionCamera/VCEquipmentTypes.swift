//
//  VCEquipmentTypes.swift
//  AuctionCamera
//
//  Created by Matthew Sansoucie on 8/16/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit

class VCEquipmentTypes: UIViewController {

    var equipment:String = ""
    var selectedEquipmentList=[EquipmentCodes]()

    
    @IBOutlet weak var tvEquipmentTypes: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if equipment == "Trans"{
            self.navigationItem.title = "Transmission"
        }else{
            self.navigationItem.title = equipment
        }
    }
    
    
}

extension VCEquipmentTypes: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedEquipmentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EQCell") as! TVCEquipmentTypes
        cell.lblEquipmentTypes.text = selectedEquipmentList[indexPath.row].EQDesc
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selecting type")
        let n:String = selectedEquipmentList[indexPath.row].EQDesc
        
        print(n)
        
        //delegate?.getTypes(name: n)//, buttonName: equipment)
        
        navigationController?.popViewController(animated: true)
    }


}

