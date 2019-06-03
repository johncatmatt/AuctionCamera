//
//  VCAuctionPhotos.swift
//  AuctionCamera
//
//  Created by Matthew Sansoucie on 5/26/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit
import Photos

//parent VC
class VCAuctionPhotos: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, URLSessionDelegate, URLSessionDataDelegate, ChildDelegate {
    
    func dataChanged(b: Bool) {
        DelMasImage = b
    }
    
    var DelMasImage: Bool = false
    
    var myIndexPath: IndexPath? = nil
    var vin: String = ""
    
    var myCollectionView: UICollectionView!
    var imageArray=[UIImage]()
    var indexArray=[String]()
    let MAXTIME : Float = 5.0
    var currentTime : Float = 0.0
    
    
    
    struct photoArray: Decodable {
        let vl: [t]
    }
    struct t: Decodable {
        var ImgID: String
        var imgData: String
    }
    //base64

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(vin)
        
        let btnRefresh = UIBarButtonItem(title: "Refresh", style: .done, target: self, action: #selector(refreshPage))
        self.navigationItem.rightBarButtonItem = btnRefresh
        
        //Add the VIN to the navigation bar title
        let upperTitle = NSMutableAttributedString(string: "\(vin)", attributes: [NSAttributedString.Key.font: UIFont(name: "Arial", size: 17)!])
        let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height:66))
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.attributedText = upperTitle  //assign it to attributedText instead of text
        self.navigationItem.titleView = label1
        
        //collection view of the photos
        let layout = UICollectionViewFlowLayout()
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.delegate=self
        myCollectionView.dataSource=self
        myCollectionView.register(PhotoItemCell.self, forCellWithReuseIdentifier: "Cell")
        myCollectionView.backgroundColor=UIColor.white
        self.view.addSubview(myCollectionView)
        myCollectionView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.RawValue(UInt8(UIView.AutoresizingMask.flexibleWidth.rawValue) | UInt8(UIView.AutoresizingMask.flexibleHeight.rawValue )))
        
       // print("View did not appear")
        showSpinner(onView: self.view)
        grabPhotos()
        //DelMasImage = true
        
    }
 
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isBeingPresented || isMovingToParent {
             //print("!!!!!!!!!!!!!First!!!!!!!!!!!!!!!!!")
        }else{
            grabPhotos()
        }
        
        
    }
    
 
    
    //Gets the photos of the car with the 
    func grabPhotos(){
        
        //https://mobile.aane.com/auction.asmx/VehicleImageCollection?requestStr=2CKDL43F086045757
        //vin = 2CKDL43F086045757
        let todoEndpoint: String = "https://mobile.aane.com/auction.asmx/VehicleImageCollection?requestStr=\(vin)"
       
        //!!!MUST EMPTY THE ARRAYS BEFORE EACH GRAB
        imageArray.removeAll()
        indexArray.removeAll()
        

        guard let url = URL(string: todoEndpoint) else {
            print("ERROR: cannot create URL")
            self.removeSpinner()
            return
        }
        
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
                
                print("trying to decode JSON")
                let t = try JSONDecoder().decode(photoArray.self, from: data)
                
                print("Trying to do stuff with JSON now")
                
                DispatchQueue.main.async {
                    if t.vl.isEmpty{
                        print("There is not data")
                    }else{
                        for p in t.vl{
                            if let decodeData = Data(base64Encoded: p.imgData, options: .ignoreUnknownCharacters){
                                self.imageArray.append(UIImage(data: decodeData)!)
                                self.indexArray.append(p.ImgID)
                                self.myCollectionView.reloadData()
                            }
                        }
                }
                    
                self.removeSpinner()
                }
            }catch let jsonErr{
                print("-------------\(jsonErr) --------------")
                self.removeSpinner()
                
                
                let alert = UIAlertController(title: "Error", message: "\(jsonErr)", preferredStyle: .alert)
                //alert.view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2) )
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    
                    self.dismiss(animated: true, completion: nil)
                    // self.cancelButton_TouchUpInside
                    //cancelButton.
                    
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
            }
             self.removeSpinner()
           
        }
        task.resume()
        
        
    }
    
    
    //refreshes the page by grabbing the photos from AuctionX again
    @objc func refreshPage(){
         showSpinner(onView: self.view)
         grabPhotos()

    }
    
    //---------------------------------------COLLECTIONVIEW FUCTIONALITY-----------------------------------------------
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = VCAuctionPhotoPreview()
        vc.imgArray = self.imageArray
        print(indexPath)
        
        vc.passedContentOffset = indexPath
        
        let i = indexPath.row
        //print(i)
        print(indexArray) 
        vc.imageID = indexArray[i]
        vc.indexArray = self.indexArray
        
        myIndexPath = indexPath
       
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoItemCell
        cell.img.image=imageArray[indexPath.item]
        return cell
    }
    //---------------------------------------COLLECTIONVIEW FUCTIONALITY-----------------------------------------------
    
    
    

   

}
