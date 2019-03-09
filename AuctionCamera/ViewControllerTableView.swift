//
//  ViewControllerTableView.swift
//  AuctionCamera
//
//  Created by John Sansoucie on 3/8/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit

class ViewControllerTableView: UITableViewController, UISearchBarDelegate{

    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var mytable: UITableView!
    
   // var rideArray = [Rides]()
   // var currentRideArray = [Rides]() //update table
    
    //feed and table struct to hold the ride data, is decodeable to allow JSON decoder to read the response
    struct feed: Decodable {
        let Table: [table]
    }
    struct table: Decodable {
        let rideid : Int
        let name : String
        var category : String
        /*
         let Departs : String
         let From : String
         let Destination : String
         let Participants : String
         */
    }
    //2D array used to populate the Table View with
    var twoDimensionalArray = [
        [""]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         UserDefaults.standard.removeObject(forKey: "vin")
     //   // SetupRides()
     //   GetFeed()
     //   setupSearchBar()
     //  // alterLayout()
        
        
        
    }
    
}
