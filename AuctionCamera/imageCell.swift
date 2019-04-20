//
//  imageCell.swift
//  AuctionCamera
//
//  Created by John Sansoucie on 4/20/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//



import Foundation
import UIKit

import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    var representedAssetIdentifier: String!
    var thumbnailImage: UIImage! {
        didSet {
            imageView.image = thumbnailImage
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
