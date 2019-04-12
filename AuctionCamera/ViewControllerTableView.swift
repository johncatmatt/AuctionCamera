//
//  ViewControllerTableView.swift
//  AuctionCamera
//
//  Created by John Sansoucie on 3/8/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit

class VINCell: UITableViewCell {
    @IBOutlet weak var lblVIN: UILabel!
    @IBOutlet weak var lblJoin: UILabel!
    @IBOutlet weak var btnButton: UIButton!
}

class ViewControllerTableView: UITableViewController, UISearchBarDelegate{

    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var mytable: UITableView!
    
    
    struct CarData {
        var vin: String
    }
    
    var Cars = [ CarData(vin: "Test Vehicle 1"), CarData(vin: "Test Vehicle 2"), CarData(vin: "Test Vehicle 3") ]
    
   // var rideArray = [Rides]()
   // var currentRideArray = [Rides]() //update table
    
    //feed and table struct to hold the ride data, is decodeable to allow JSON decoder to read the response
    struct feed: Decodable {
        let Table: [table]
    }
    struct table: Decodable {
        let vin : Int
        
        /*let rideid : Int
        let name : String
        var category : String
        
         let Departs : String
         let From : String
         let Destination : String
         let Participants : String
         */
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
         UserDefaults.standard.removeObject(forKey: "vin")
        
    }

   
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as! VINCell
        
       cell.lblVIN.text = Cars[indexPath.row].vin
        
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cars.count
    }
  
    
}


