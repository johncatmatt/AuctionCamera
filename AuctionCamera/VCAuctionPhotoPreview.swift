//
//  VCAuctionPhotoPreview.swift
//  AuctionCamera
//
//  Created by Matthew Sansoucie on 5/27/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit

class VCAuctionPhotoPreview: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var myCollectionView: UICollectionView!
    var imgArray = [UIImage]()
    var passedContentOffset = IndexPath()
    
    var imageID: String = ""
    var indexArray=[String]()
    let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("NEW PHOTO PREVIEW")
        print("ImageID is \(imageID)")
        print("the imageid array is \(indexArray)")
        
        self.view.backgroundColor=UIColor.black
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing=0
        layout.minimumLineSpacing=0
        layout.scrollDirection = .horizontal
        
       
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.delegate=self
        myCollectionView.dataSource=self
        myCollectionView.register(ImagePreviewFullViewCell.self, forCellWithReuseIdentifier: "Cell")
        myCollectionView.isPagingEnabled = true
        
        myCollectionView.isScrollEnabled = false
        
        myCollectionView.scrollToItem(at: passedContentOffset, at: .left, animated: true)
        
        myCollectionView.cellForItem(at: passedContentOffset)
        
        self.view.addSubview(myCollectionView)
        
        myCollectionView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.RawValue(UInt8(UIView.AutoresizingMask.flexibleWidth.rawValue) | UInt8(UIView.AutoresizingMask.flexibleHeight.rawValue)))
        
        let logoutBarButtonItem = UIBarButtonItem(title: "Options", style: .done, target: self, action: #selector(userOptions))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
        self.navigationItem.title = "ImgID: \(imageID)"
    }
    
    
    //was the delet option
    @objc func userOptions(){
        print("clicked")

        print("The imageid is: \(imageID)")
        
        let alert1 = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this image?", preferredStyle: .alert)
        let Y = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default){
            UIAlertAction in
            self.EditPhoto(EditMode: 1)
        }
        let N = UIAlertAction(title: "No", style: UIAlertAction.Style.default){
            UIAlertAction in
            self.dismiss(animated: false, completion: nil)
        }
        alert1.addAction(Y)
        alert1.addAction(N)
        
        let alert = UIAlertController(title: "Options", message: "What would you like to do with this image?", preferredStyle: .alert)
        //alert.view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2) )
        
        let del = UIAlertAction(title: "Delete", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            self.present(alert1, animated: true, completion: nil)

            
        }
        let mas = UIAlertAction(title: "Make Default", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
                self.EditPhoto(EditMode: 2)


        }
        let can = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            print("do nothing")
            return
            
        }
        alert.addAction(del)
        alert.addAction(mas)
        alert.addAction(can)
        present(alert, animated: true, completion: nil)
        print("You hit eaiter make or delete")
        //https://mobile.aane.com/Auction.asmx/ImageEdit

    }
    
    
    func EditPhoto(EditMode: Int) {
        print("editmode =\(EditMode)")
        print("imageID =\(imageID)")


        if EditMode == 1{
            print("Delete photo")

        }else{
            print("Make photo master")
        }
        
        let todoEndpoint: String = "https://mobile.aane.com/auction.asmx/ImageEdit?EditMode=\(EditMode)&imgID=\(imageID)"
        //https://mobile.aane.com/auction.asmx/ImageEdit?EditMode=1&imgID=1785310
        //https://mobile.aane.com/auction.asmx/VehicleImageCollection?requestStr=2CKDL43F086045757
        //https://mobile.aane.com/auction.asmx/VehicleImageCollection?requestStr=2CKDL43F086045757


        
        
        guard let url = URL(string: todoEndpoint) else {
            print("ERROR: cannot create URL")
            return
        }
        print(url)
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("text/xml", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest){ data, response, error in
            guard error == nil else{
                print("ERROR: calling GET: \(error!)")
                return
            }
            
            
            
            print(data!)
            print("------------------------------------------------------------")
            print(response!)
            
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            //print(jsonData!)
            if let json = jsonData as? [String: Any] {
                print(json)
            }else{
                print("the hell went wrong?")
            }
            
        }
        task.resume()
        
        
       /*
         procImageEdit_Mobile
         @EditMode int -- 1= delete, 2 = Master
         , @imgID int    */
    }
    
    
    //-----------------------------------------------COLLECTION VIEW--------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        }
        collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.left, animated: true)
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("IndexPath:\(indexPath)")
        
         print("ImageID was: \(imageID)")
        
         imageID = indexArray[indexPath.row]
        self.navigationItem.title = "ImgID: \(imageID), index: \(indexPath.row)"
        
         print("Now the imageID is: \(imageID)")
        
        if layout.accessibilityScroll(.next){
            print("next")
        }
        
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
        
         print("just scrolled")

        let newOffset = CGPoint(x: index * size.width, y: offset.y)
        
        myCollectionView.setContentOffset(newOffset, animated: false)
        
        coordinator.animate(alongsideTransition: { (context) in
            self.myCollectionView.reloadData()
            
            self.myCollectionView.setContentOffset(newOffset, animated: false)
        }, completion: nil)
        
       
    }
    
    
    override func viewDidLayoutSubviews() {
        
        myCollectionView.scrollToItem(at:IndexPath(item: passedContentOffset.item, section: 0), at: .right, animated: false)
        
    }
    
        
        //print("just scrolled, id it \(title)")
        //imageID = indexArray[indexPath.row]
        //self.navigationItem.title = "ImgID: \(imageID)"
    
   /* func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Scroll")
        print(layout.accessibilityScroll(.next))
        
        if scrollView.accessibilityScroll(.left) {
            print("left")
        }
        
        
    }*/
    
    }
    



    

    
    

    

