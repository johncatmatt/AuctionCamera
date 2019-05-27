//
//  ImagePreviewVC.swift
//  AuctionCamera
//
//  Created by Matthew Sansoucie on 4/20/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import Foundation
import UIKit
import Photos

class ImagePreviewVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    var myCollectionView: UICollectionView!
    var imgArray = [UIImage]()
    var passedContentOffset = IndexPath()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor=UIColor.black
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing=0
        layout.minimumLineSpacing=0
        layout.scrollDirection = .horizontal
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.delegate=self
        myCollectionView.dataSource=self
        myCollectionView.register(ImagePreviewFullViewCell.self, forCellWithReuseIdentifier: "Cell")
        myCollectionView.isPagingEnabled = true
        
        myCollectionView.scrollToItem(at: passedContentOffset, at: .left, animated: true)
        
        myCollectionView.cellForItem(at: passedContentOffset)
        
    self.view.addSubview(myCollectionView)
        
        myCollectionView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.RawValue(UInt8(UIView.AutoresizingMask.flexibleWidth.rawValue) | UInt8(UIView.AutoresizingMask.flexibleHeight.rawValue)))
        
       // self.collectionView.scrollToItem(at:IndexPath(item: indexNumber, section: sectionNumber), at: .right, animated: false)
      //  myCollectionView.scrollToItem(at:IndexPath(item: 5, section: 0), at: .right, animated: false)
        
        let logoutBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(logoutUser))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
    }
    
    @objc func logoutUser(){
        print("clicked")
        let alert = UIAlertController(title: "Delete Photo?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        //   alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in UIPasteboard.general.string = object.stringValue
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {
            _ in

         let imgManager=PHImageManager.default()
            
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
                            self.imgArray.append(image!)
                            
                        
                        
                        //    let filename = imgManager.value(forKey: "PHImageFileURLKey") as! String
                        //        print(filename)
                        let asset = fetchResult.object(at: i)
                        
                        if asset == fetchResult.object(at: i) {
                            
                            //  let creationDate = asset.creationDate
                            //   print(creationDate!)
                            
                            PHImageManager.default().requestImageData(for: asset, options: PHImageRequestOptions(), resultHandler: { (imagedata, dataUTI, orientation, info) in
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
                                                                                    if (i == self.passedContentOffset.item                                                                           )                                                                                    {
                                                                                        
                                                                                        let arrayToDelete = NSArray(object: asset)
                                                                                        print(arrayToDelete)
                                                                                        
                                                                                        PHPhotoLibrary.shared().performChanges({
                                                                                            //Delete Photo
                                                                                            PHAssetChangeRequest.deleteAssets(arrayToDelete)
                                                                                        },                                                                                           completionHandler: {(success, error)in
                                                                                            NSLog("\nDeleted Image -> %@", (success ? "Success":"Error!"))
                                                                                            
                                                                                            if success == true {
                                                                                                let alert = UIAlertController(title: "Success", message: "The image has been deleted", preferredStyle: .alert)
                                                                                                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                                                                                                self.present(alert, animated: true)
                                                                                            }else{
                                                                                                /*let alert = UIAlertController(title: "Error", message: "The image was not deleted", preferredStyle: .alert)
                                                                                                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                                                                                                self.present(alert, animated: true)*/
                                                                                            }
                                                                                            
                                                                                            if(success){
                                                                                                
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
            
         /*
            let arrayToDelete = self.passedContentOffset.item;                print(arrayToDelete)
            //need to fetch the asset name to delete
                PHPhotoLibrary.shared().performChanges({
                    //Delete Photo
                    PHAssetChangeRequest.deleteAssets(arrayToDelete as! NSFastEnumeration)
                },                                                                                           completionHandler: {(success, error)in
                    NSLog("\nDeleted Image -> %@", (success ? "Success":"Error!"))
                    if(success){
                        // Move to the main thread to execute
                    }
                })
                
           */
            
            
            
            
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        
        myCollectionView.scrollToItem(at:IndexPath(item: passedContentOffset.item, section: 0), at: .right, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
    //    myimgArray = imgArray
        
//print(imgArray)
        //  myIndex = index
        
        
        return imgArray.count
    }
    
    
 
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 {
            // TODO: scroll to correct position here
            return false
        }
        
        collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.left, animated: true)
        
        
        return true
    }
 
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("IndexPath\(indexPath)")

        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImagePreviewFullViewCell
        cell.imgView.image=imgArray[indexPath.row]
        return cell
    }

    

        
        
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let flowLayout = myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        flowLayout.itemSize = myCollectionView.frame.size
        
        flowLayout.invalidateLayout()
        
        myCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let offset = myCollectionView.contentOffset
        let width  = myCollectionView.bounds.size.width
        
        let index = round(offset.x / width)
        
        print("Index\(index)")
        
        
        
        let newOffset = CGPoint(x: index * size.width, y: offset.y)
        
        myCollectionView.setContentOffset(newOffset, animated: false)
        
        coordinator.animate(alongsideTransition: { (context) in
            self.myCollectionView.reloadData()
            
            self.myCollectionView.setContentOffset(newOffset, animated: false)
        }, completion: nil)
    }
    
}
class ImagePreviewFullViewCell: UICollectionViewCell, UIScrollViewDelegate {
    
    var scrollImg: UIScrollView!
    var imgView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollImg = UIScrollView()
        scrollImg.delegate = self
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.showsVerticalScrollIndicator = true
        scrollImg.flashScrollIndicators()
        
        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 4.0
        
        let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTapGest.numberOfTapsRequired = 2
        scrollImg.addGestureRecognizer(doubleTapGest)
        
        self.addSubview(scrollImg)
        
        imgView = UIImageView()
        imgView.image = UIImage(named: "user3")
        
     //   print(myimgArray[5])
     //   imgView.image = myimgArray[5]
        
        scrollImg.addSubview(imgView!)
        imgView.contentMode = .scaleAspectFit
    }
    
    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        if scrollImg.zoomScale == 1 {
            scrollImg.zoom(to: zoomRectForScale(scale: scrollImg.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
        } else {
            scrollImg.setZoomScale(1, animated: true)
        }
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imgView.frame.size.height / scale
        zoomRect.size.width  = imgView.frame.size.width  / scale
        let newCenter = imgView.convert(center, from: scrollImg)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imgView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollImg.frame = self.bounds
        imgView.frame = self.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        scrollImg.setZoomScale(1, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
