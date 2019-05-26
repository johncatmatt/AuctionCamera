//
//  VCAuctionPhotos.swift
//  AuctionCamera
//
//  Created by Matthew Sansoucie on 5/26/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit
import Photos

class VCAuctionPhotos: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, URLSessionDelegate, URLSessionDataDelegate {
    
    var vin: String = ""
    
    var myCollectionView: UICollectionView!
    var imageArray=[UIImage]()
    let MAXTIME : Float = 5.0
    var currentTime : Float = 0.0
    
    
    struct photoArray: Decodable {
        let vl: [t]
    }
    struct t: Decodable {
        var imageid: Int
        var photo: String
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(vin)
        
        //Add the VIN to the navigation bar title
        let upperTitle = NSMutableAttributedString(string: "\(vin)", attributes: [NSAttributedString.Key.font: UIFont(name: "Arial", size: 17)!])
        let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height:66))
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.attributedText = upperTitle  //assign it to attributedText instead of text
        self.navigationItem.titleView = label1
        
        //
        let layout = UICollectionViewFlowLayout()
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.delegate=self
        myCollectionView.dataSource=self
        myCollectionView.register(PhotoItemCell.self, forCellWithReuseIdentifier: "Cell")
        myCollectionView.backgroundColor=UIColor.white
        self.view.addSubview(myCollectionView)
        myCollectionView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.RawValue(UInt8(UIView.AutoresizingMask.flexibleWidth.rawValue) | UInt8(UIView.AutoresizingMask.flexibleHeight.rawValue )))
        
        grabPhotos()
        
    }
    
    
    func grabPhotos(){
        imageArray = []
        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            let imgManager = PHImageManager.default()
            
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous=true
            requestOptions.deliveryMode = .highQualityFormat
            
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors=[NSSortDescriptor(key:"creationDate", ascending: false)]
            
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            print(fetchResult)
            print(fetchResult.count)
            if fetchResult.count > 0 {
                for i in 0..<fetchResult.count{
                    imgManager.requestImage(for: fetchResult.object(at: i) as PHAsset, targetSize: CGSize(width:500, height: 500),contentMode: .aspectFill, options: requestOptions, resultHandler: { (image, error) in
                        
                        if image != nil {
                            self.imageArray.append(image!)
                            
                            //    let filename = imgManager.value(forKey: "PHImageFileURLKey") as! String
                            //        print(filename)
                            let asset = fetchResult.object(at: i)
                            if asset == fetchResult.object(at: i) {
                                //  let creationDate = asset.creationDate
                                //   print(creationDate!)
                                PHImageManager.default().requestImageData(for: asset, options: PHImageRequestOptions(),resultHandler: { (imagedata, dataUTI, orientation, info) in
                                   if let info = info {
                                        if info.keys.contains(NSString(string: "PHImageFileURLKey")) {
                                            if let path = info[NSString(string: "PHImageFileURLKey")] as? NSURL {
                                                print(path)
                                                print(UIDevice.current.name)
                                                                                            
                                                let creationDate = asset.creationDate
                                                print("Asset Date: \(creationDate!)")
                                               //  if path == NSURL(string: "file:///var/mobile/Media/DCIM/100APPLE/IMG_0015.JPG") {
                                                                                            
                                                let date = creationDate
                                                let formatter = DateFormatter()
                                                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
                                                let myString = formatter.string(from: date!)
                                                print("Formatted: \(myString)")
                                                if (myString ==  ("2019-04-21 09:44:20 +0000")) {
                                                                                                
                                                    let arrayToDelete = NSArray(object: asset)
                                                    print(arrayToDelete)
                                                                                                
                                                    PHPhotoLibrary.shared().performChanges({
                                                    //Delete Photo
                                                    PHAssetChangeRequest.deleteAssets(arrayToDelete)
                                                    },  completionHandler: {(success, error)in
                                                    NSLog("\nDeleted Image -> %@", (success ? "Success":"Error!"))
                                                       if(success){
                                                          // Move to the main thread to execute
                                                        }
                                                    })
                                                                                                
                                                }
                                                                                            
                                            }
                                        }
                                     }
                                 })
                             }}
                         })
                    }
                    
            } else {
                print("You got no photos.")
            }
            print("imageArray count: \(self.imageArray.count)")
            
            DispatchQueue.main.async {
                print("This is run on the main queue, after the previous code in outer block")
                self.myCollectionView.reloadData()
            }
        }
    }
    
    
    
    //---------------------------------------COLLECTIONVIEW FUCTIONALITY-----------------------------------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoItemCell
        cell.img.image=imageArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc=ImagePreviewVC()
        vc.imgArray = self.imageArray
        print(indexPath)
        vc.passedContentOffset = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        if DeviceInfo.Orientation.isPortrait {
            return CGSize(width: width/4 - 1, height: width/4 - 1)
        } else {
            return CGSize(width: width/6 - 1, height: width/6 - 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    //---------------------------------------COLLECTIONVIEW FUCTIONALITY-----------------------------------------------
    
    
    

   

}
