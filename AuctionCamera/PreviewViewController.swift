//
//  VCPreview.swift
//  AuctionCamera
//
//  Created by Matthew Sansoucie on 3/2/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit
import Photos

class PreviewViewController: UIViewController
    , URLSessionDelegate, URLSessionDataDelegate   // ,URLSessionDownloadDelegate
{
  
 //   func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
 //       var uploadProgress:Float = Float(totalBytesSent) / Float(totalBytesExpectedToSend)

 //   }
  
    
    struct j: Decodable {
        let error: String
        let imageid: Int
    }
    
    //UNCOMMENT CHILD IF TESTING FAILS!!!!!!!!!!!!!!!!
     //let child = SpinnerViewController()

  //  @IBOutlet weak var spinner: UIActivityIndicatorView!
    //   @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet var downloadProgressLabel: UILabel!
    
    let MAXTIME : Float = 5.0
    var currentTime : Float = 0.0
    
  //  var expectedContentLength = 0
  //  var buffer:NSMutableData = NSMutableData()
   // var session:URLSession?
  //  var dataTask:URLSessionDataTask?
    
    
   @IBOutlet var progressView: UIProgressView!
    
    @IBOutlet var imageViewProgressOutlet: UIView!
    @IBOutlet weak var photo: UIImageView!
    var image1: UIImage!
     @IBOutlet weak var switchMasterPhoto: UISwitch!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var labelVIN: UILabel!
    
    @IBOutlet weak var labelVIN6: UILabel!
    
    
       let url = URL(string: "https://mobile.aane.com/Auction.asmx/SendPicture")
    
    typealias BatchPhotoDownloadingCompletionClosure = (_ error: NSError?) -> Void
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = self.image1
      //  spinner.isHidden =  true
     //   progressView.transform = progressView.transform.scaledBy(x: 1, y: 4)
        
        
        
        labelVIN.text = UserDefaults.standard.string(forKey: "vin")
        labelVIN.isHidden = true
        let str = UserDefaults.standard.string(forKey: "vin")!
        let index = str.index(str.endIndex, offsetBy: -6)
        let mySubstring = str.suffix(from: index)
        
        labelVIN6.text = String(mySubstring)
         labelVIN6.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        
    //    let boolAsString = String(switchMasterPhoto!.isOn)
    //    let myDevice = UIDevice.current.name
        
     //   labelVIN.text = (labelVIN.text ?? "") + boolAsString
      //  + localImageID + myDevice
      
        
        
        print(labelVIN.text!)
        
  //      progressView.progress = 0.0
        cancelButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        
        saveButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        
        print(switchMasterPhoto.isOn)
        
        
     //   let configuration = URLSessionConfiguration.default
     //   let manqueue = OperationQueue.main
    //    session = URLSession(configuration: configuration, delegate:self, delegateQueue: manqueue)
     //   dataTask = session?.dataTaskWithRequest(NSURLRequest(URL: erfl))
     //   dataTask?.resume()
        

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    @IBAction func cancelButton_TouchUpInside(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButton_TouchUpInside(_ sender: UIButton) {
 /*
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
       dismiss(animated: true, completion: nil)
  */
        
  /*
       let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // choose a name for your image
        let fileName = labelVIN.text! + ".jpg" //+ "image.jpg"
        // create the destination file url to save your image
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        // get your UIImage jpeg data representation and check if the destination file url already exists
        if let data = image.jpegData(compressionQuality: 0.75),
            !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                // writes the image data to disk
                try data.write(to: fileURL)
                print("file saved")
            } catch {
                print("error saving file:", error)
            }
   */
       // let imageData:NSData = image1!.jpegData(compressionQuality: 0.25)! as NSData
        
        
      
  /*
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("Picture9.png")
            let image    = UIImage(contentsOfFile: imageURL.path)
            
           // let imageResized = image?.jpegData(compressionQuality: 25)
            
         //   let base64String = imageData?.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters) // encode the image
   
            let imageResized = image!.resizeWith(percentage: 0.1)
            let base64 = imageResized?.toBase64()
            
            
            ExportImage(myData: base64)            // Do whatever you want with the image
        }
   */
      
        
     // let jpg = image1.base64
      //  let imageBase64String = UIImagePNGRepresentation(myimageview.image!)?.base64EncodedString()

     //   let jpg = image1.pngData()?.base64EncodedString()
        //Saved Image
      //  UserDefaults.standard.set(imageData, forKey: "savedImage")
        //Decode
     //   let myData = UserDefaults.standard.object(forKey: "savedImage") as! NSData
       // let s = String(decoding: myData, as: UTF8.self)
   //     ExportImage(myData: base64String!)
       
     //   let imageResized = image1!.resizeWith(percentage: 0.1)
     //   let base64 = imageResized?.toBase64()
//       let imageData:NSData = image1!.jpegData(compressionQuality: 0.25)! as NSData
       // let imageData:NSData = image1.pngData()! as NSData
   
        
   //     let imageStr = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
     //  let imageResized = imageData.resizeWith(percentage: 0.1)
     //   let base64 = imageData.toBase64()
     //   let datastring = NSString(data: (imageData as NSData) as Data, encoding: String.Encoding.utf8.rawValue)
        
//let datastring = NSString(data: imageData as Data, encoding: String.Encoding.utf8.rawValue)!
        
     //   let plainData = (datastring as! NSString).dataUsingEncoding(NSUTF8StringEncoding)
     //   let base64String = plainData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.fromRaw(0)!)
     //   println(base64String) // bXkgcGxhbmkgdGV4dA==

        
    //    let resultString = imageStr as String
   //    let base64Encoded = Data(resultString.utf8).base64EncodedString()
        
       // postRequest(myData: jpg!)
      
      //  testpic()
     // dismiss(animated: true, completion: nil)
      //  let image = UIImage(named: "icons8-Tornado Filled-29 (1).png")
          self.currentTime = 0
      //    saveButton.isEnabled = true

   //   self.view.isUserInteractionEnabled = false

   //     spinner.startAnimating()
    //    spinner.isHidden = false
         // add the spinner view controller


      //  addChild(child)
      //  self.child.view.frame = view.frame
      //  view.addSubview(self.child.view)
      //  self.child.didMove(toParent: self)
        
          DispatchQueue.global().sync {
            // yada yada something
     
            //addChild(self.child)
            //self.child.view.frame = view.frame
            //view.addSubview(self.child.view)
            //self.child.didMove(toParent: self);
  
            let myFileName = "\(labelVIN.text!)"
            
 //self.SaveImagetoDevice(paramName: self.labelVIN.text!, fileName: myFileName, image: self.image1!)
          //  DispatchQueue.main.async {
            let boolAsString = String(self.switchMasterPhoto!.isOn)
            let vin = String(self.labelVIN.text!) + boolAsString
            self.labelVIN.text = vin
            let myImage = self.image1!
            
            let localImageName =  self.saveImageDocumentDirectory(image: myImage, imageName: myFileName)
                
            
            
                
                //     self.createSpinnerView()
            
            //self.addChild(<#T##childController: UIViewController##UIViewController#>)
            
                self.uploadImage(paramName: vin, fileName: localImageName, image: myImage)
                
           //    }
            
         
            
 
            
            
            
            
            
            //DispatchQueue.main.async {
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    
                    //managging spinner
                    //self.child.willMove(toParent: nil)
                    //self.child.view.removeFromSuperview()
                    //self.child.removeFromParent()
            
            }
        }


        
        
        
        
        
        
        
        
        //}
    }
    

    
    
    
    
    func uploadImage(paramName: String, fileName: String,
           image: UIImage) {

        
        var worked = false
       //show the spinner
        showSpinner(onView: self.view)
        
        saveButton.isEnabled = false
       
   //    progressView.setProgress(currentTime, animated: true)
    //      perform(#selector(updateProgress),with: nil, afterDelay: 1.0)
        
        
      // let url = URL(string: "https://mobile.aane.com/Auction.asmx/SendPicture")
      //     let url = URL(string: "https://mobile.aane.com/auction/auction.asmx/SendPicture")
        
        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString
        
       // let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        let session = URLSession.shared
        //changed to above 2019/03/21 let session = URLSession.shared
        
        // Set the URLRequest to POST and to the specified URL
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
        let imgResized =  image.resizeWithPercent(percentage: 0.4)
        
        let img = imgResized?.jpegData(compressionQuality: 0.9)
        
        
        let base64String = img?.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
        // let myDataEncoded = base64String?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        data.append(base64String!)
        
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
                         //self.dismiss(animated: true, completion: nil)
               /*         let alert = UIAlertController(title: "Upload Status", message: "\(json)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                 */
                    /*
                        let alert = UIAlertController(title: "Upload Status", message: "\(json)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Okay", style: .default){(action)->() in })

                        self.present(alert, animated: true, completion: {() -> Void in
                            alert.view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2) )
                        })
                    */
                            
                           
                            
                            
                            /*guard let test = json else {
                                print("failed")
                            }*/
                            
                           /* print(jsonData!)
                            print(type(of: jsonData))
                            do {
                                let decoder = JSONDecoder()
                                let r = try decoder.decode(j.self, from: responseData as! Data)
                                print(" TRYING TO DECODE JSON \(r.error)")
                                
                                
                                print(r.imageid)
                            }catch { print(error)}*/
                            
                            self.removeSpinner()
                            print(type(of: json))
                                 //PreviewViewController.showAlertMessage(message:"\(json)", viewController: self)
                            
                            let alert = UIAlertController(title: "Upload Status", message: "\(json)", preferredStyle: .alert)
                            //alert.view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2) )
                            
                            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                
                                self.dismiss(animated: true, completion: nil)
                                
                               // self.cancelButton_TouchUpInside
                                //cancelButton.
                                
                            }
                            alert.addAction(okAction)
                            
                            self.present(alert, animated: true, completion: {() -> Void in
                                alert.view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
                                
                            })
                         
                            
                         //    self.CloseSpinnerView()
                            
                        
                    }
        
             
                    self.removeSpinner()
                }
          
                
                self.removeSpinner()
            }
        }).resume()
     
      //  CloseSpinnerView()
        
        
        self.saveButton.isEnabled = true
        
        
    
        
    }
    
    
    struct pic: Codable {
        let vin: String
    }
    
    struct jsonData: Decodable {
        
        var imageid : NSInteger
        
        var error : String
        
        //  var lineAmount : String
        
    }
/*
    @objc func updateProgress() {
    currentTime = currentTime + 1.0
        progressView.progress = currentTime/MAXTIME
     //   labelVIN.text = "\(currentTime)"
        
        if currentTime < MAXTIME {
              perform(#selector(updateProgress),with: nil, afterDelay: 1.0)
            
        } else {
            print("stop")
            currentTime = 0.0
            
        //  self.view.isUserInteractionEnabled = true
            
            
        }
        
    }
    */
    
  
    func replace(myString: String)  {
    
        let oldString = "Hello, playground"
        let newString: String = myString.prefix(4) + "0" + oldString.dropFirst(5)
        labelVIN.text = newString
        
    }
  
    class func showAlertMessage(message:String, viewController: UIViewController) {
        DispatchQueue.main.async {
         /*
            let alertMessage = UIAlertController(title: "", message: message, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
            
            alertMessage.addAction(cancelAction)
            
            viewController.present(alertMessage, animated: true, completion: nil)
            */
          
            
            
 
 let alert = UIAlertController(title: "Upload Status", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default){(action)->(
                ) in
                
            })
            
            viewController.present(alert, animated: true, completion: {() -> Void in
                alert.view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2) )
                      })
            
        }
    }
  
    
    
    func createSpinnerView() {
      //  let child = SpinnerViewController()
          /*
        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // then remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
       */
      
/*                // add the spinner view controller
                addChild(child)
                child.view.frame = view.frame
                view.addSubview(child.view)
                child.didMove(toParent: self)
        
  */
    }
            
    func CloseSpinnerView(
        ) {
      //  let child = SpinnerViewController()
        /*
         // add the spinner view controller
         addChild(child)
         child.view.frame = view.frame
         view.addSubview(child.view)
         child.didMove(toParent: self)
         */
    /*
        // wait two seconds to simulate some work happening
         DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
         // then remove the spinner view controller
            self.child.willMove(toParent: nil)
            self.child.view.removeFromSuperview()
            self.child.removeFromParent()
         }
 */
        

        }

    
    func SaveImagetoDevice(paramName: String, fileName: String,
                           image: UIImage){
        

        
        
          let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
 
        if let filePath = paths.first?.appendingPathComponent(fileName            ) {
            // Save image.
            do {
                print(filePath)
                print(fileName)
                try image.jpegData(compressionQuality: 0.1)?.write(to: filePath, options: .atomic)
            } catch {
                // Handle the error
                print(error.localizedDescription)
            }
        }
        
    }
    
    func saveImageDocumentDirectory(image: UIImage, imageName: String)-> String {
      
       
      
       
        
        var myDevice = UIDevice.current.name
        

        /*
        let randomInt = Int.random(in: 100000000...999999999)
        let randomImageName = "\(imageName)\(randomInt).jpg"
        print(randomInt)
        print(randomImageName)
        let fileManager = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("AANEImages")
        if !fileManager.fileExists(atPath: path) {
            try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        let url = NSURL(string: path)
        let imagePath = url!.appendingPathComponent(randomImageName)
        let urlString: String = imagePath!.absoluteString
        let imageData = image.jpegData(compressionQuality: 0.1) //UIImageJPEGRepresentation(image, 0.5)
        
        print(path)
        print(urlString)
        
          fileManager.createFile(atPath: urlString as String, contents: imageData, attributes: nil)
        */
        
        
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.saveImageComplete(image:err:context:)), nil)
        
      
        let fetchResult = PHAsset.fetchAssets(with: .image, options: nil)
        if fetchResult.count > 0 {
            if let asset = fetchResult.lastObject {
               // let date = asset.creationDate ?? Date()
                
                let date =  asset.creationDate!
           //     let localDate = date.subtract(hours: 4)
            
                
            
           
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
                let myString = formatter.string(from: date)
               
                print("Fetch date: \(date)")
                print("Creation date: \(myString)")
                myDevice = "\(UIDevice.current.name) \(myString)"
                print("current date: \(Date())")
                
                PHImageManager.default().requestImageData(for: asset, options: PHImageRequestOptions(),
                    resultHandler: { (imagedata, dataUTI, orientation, info) in
                    if let info = info {
                    if info.keys.contains(NSString(string: "PHImageFileURLKey")) {
                   if let path = info[NSString(string: "PHImageFileURLKey")] as? NSURL {
                     print(UIDevice.current.name)
                     print(path)
                    
                      myDevice = UIDevice.current.name + "\(myString)" + "\(path)"
                    
                    
                            }
                           }
                         }
                })
            }
        }
            
            

       
       
   return myDevice
            
        
    }
    
    
    @objc private func saveImageComplete(image:UIImage, err:NSError, context:UnsafeMutableRawPointer?) {
      //  print(context!)
        
    }
    
    class MyThread: Thread {
        public var runloop: RunLoop?
        public var done = false
        
        override func main() {
            runloop = RunLoop.current
            done = false
            repeat {
                let result = CFRunLoopRunInMode(.defaultMode, 10, true)
                if result == .stopped  {
                    done = true
                }
            }
                while !done
        }
        
        func stop() {
            if let rl = runloop?.getCFRunLoop() {
                CFRunLoopStop(rl)
                runloop = nil
                done = true
            }
        }
    }
    
   
    
    
    
}


extension Date {
    
    /// Returns a Date with the specified amount of components added to the one it is called with
    func add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date? {
        let components = DateComponents(year: years, month: months, day: days, hour: hours, minute: minutes, second: seconds)
        return Calendar.current.date(byAdding: components, to: self)
    }
    
    /// Returns a Date with the specified amount of components subtracted from the one it is called with
    func subtract(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date? {
        return add(years: -years, months: -months, days: -days, hours: -hours, minutes: -minutes, seconds: -seconds)
    }
    
}
    



extension UIImage {
 /*
    /// EZSE: Returns base64 string
    public var base64: String {
        return self.jpegData(compressionQuality: 0.20)!.base64EncodedString()
    }
   */
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
        
    }
    
}


var vSpinner : UIView?

var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()

extension UIViewController{
    func showSpinner(onView : UIView) {
        let SpinnerView = UIView.init(frame: onView.bounds)
        SpinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = SpinnerView.center
        DispatchQueue.main.async {
            SpinnerView.addSubview(ai)
            onView.addSubview(SpinnerView)
        }
        vSpinner = SpinnerView
        vSpinner?.bringSubviewToFront(onView)
        vSpinner?.isHidden = false
    }
    func removeSpinner(){
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
            vSpinner?.isHidden = true
        }
    }
}
