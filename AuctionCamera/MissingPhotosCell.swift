//
//  MissingPhotosCell.swift
//  AuctionCamera
//
//  Created by Matthew Sansoucie on 6/11/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit

class MissingPhotosCell: UITableViewCell {

    
    @IBOutlet weak var lblLotLane: UILabel!
    @IBOutlet weak var lblConsignor: UILabel!
    @IBOutlet weak var lblYearMakeModel: UILabel!
    @IBOutlet weak var lblVin: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
