//
//  NewPreviewViewController.swift
//  AuctionCamera
//
//  Created by John Sansoucie on 4/20/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit
import Photos

class NewPreviewViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate
    , URLSessionDelegate, URLSessionDataDelegate
{
    
    @IBOutlet weak var btnDelete: UIButton!
    
    var myCollectionView: UICollectionView!
    var imageArray=[UIImage]()
    let MAXTIME : Float = 5.0
    var currentTime : Float = 0.0
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    let url = URL(string: "https://mobile.aane.com/Auction.asmx/SendPicture")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //self.title = "Photos"
        
        let layout = UICollectionViewFlowLayout()
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        myCollectionView.delegate=self
        myCollectionView.dataSource=self
        myCollectionView.register(PhotoItemCell.self, forCellWithReuseIdentifier: "Cell")
        myCollectionView.backgroundColor=UIColor.white
        self.view.addSubview(myCollectionView)
        
       myCollectionView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.RawValue(UInt8(UIView.AutoresizingMask.flexibleWidth.rawValue) | UInt8(UIView.AutoresizingMask.flexibleHeight.rawValue )))
        
     
        
        
      //  myCollectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth, .flexibleTopMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleHeight  - toolBar.frame.height ]

    //    btnDelete.isHidden = true

        grabPhotos()
        
        
        // Do any additional setup after loading the view.
    }
    
   
    
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
      
        //        if UIDevice.current.orientation.isPortrait {
        //            return CGSize(width: width/4 - 1, height: width/4 - 1)
        //        } else {
        //            return CGSize(width: width/6 - 1, height: width/6 - 1)
        //        }
        if DeviceInfo.Orientation.isPortrait {
            return CGSize(width: width/4 - 1, height: width/4 - 1)
        } else {
            return CGSize(width: width/6 - 1, height: width/6 - 1)
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        myCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    //MARK: grab photos
    func grabPhotos(){
        imageArray = []
        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            let imgManager = PHImageManager.default()
            
            let requestOptions=PHImageRequestOptions()
            requestOptions.isSynchronous=true
            requestOptions.deliveryMode = .highQualityFormat
            
            let fetchOptions=PHFetchOptions()
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
                        PHImageManager.default().requestImageData(for: asset, options: PHImageRequestOptions(),
                                 resultHandler: { (imagedata, dataUTI, orientation, info) in
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
                                        },                                                                                           completionHandler: {(success, error)in
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

  
    
    func GetImageStatus(paramName: String, fileName: String)
    {
        
      
        let boundary = UUID().uuidString
             let session = URLSession.shared
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        
        print("paramname: \(paramName)")
        
        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        
        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        
        
        //  let img = image.pngData()
        //let img =  image.jpegData(compressionQuality: 0.04)
        
       // let base64String = img?.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
           
        //data.append(base64String!)
        
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        
        
        // Send a POST request to the URL, with the data we created earlier
        
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            //         self.fetchFile(url: self.url! )
            
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any] {
                    print(json)
                    self.currentTime = self.MAXTIME
                    let jsonStr = "\(json)"
                    let range: Range<String.Index> = jsonStr.range(of: "Success")!
                    let index: Int = jsonStr.distance(from: jsonStr.startIndex, to: range.lowerBound)
                    if index == 0 {
                        let alert = UIAlertController(title: "Upload Status ERROR", message: "\(json)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    else
                        // if index == 30
                    {
                        print(index)
  
   
                        VCAuctionCameraPreview.showAlertMessage(message:"\(json)", viewController: self)
                    }
                }
            }
        }).resume()
    }
    struct pic: Codable {
        let vin: String
    }
    struct jsonData: Decodable {
        
        var imageid : NSInteger
        
        var error : String
    }
    
    
    
    
}

class PhotoItemCell: UICollectionViewCell {
    
    var img = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        img.contentMode = .scaleAspectFill
        img.clipsToBounds=true
        self.addSubview(img)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        img.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct DeviceInfo {
    struct Orientation {
        // indicate current device is in the LandScape orientation
        static var isLandscape: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isLandscape
                    : UIApplication.shared.statusBarOrientation.isLandscape
            }
        }
        // indicate current device is in the Portrait orientation
        static var isPortrait: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isPortrait
                    : UIApplication.shared.statusBarOrientation.isPortrait
            }
        }
    }
}
