//
//  VCPreview.swift
//  AuctionCamera
//
//  Created by Matthew Sansoucie on 3/2/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit


class PreviewViewController: UIViewController
    , URLSessionDelegate, URLSessionDataDelegate   // ,URLSessionDownloadDelegate
{
  
 //   func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
 //       var uploadProgress:Float = Float(totalBytesSent) / Float(totalBytesExpectedToSend)

 //   }
  
    

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
    
       let url = URL(string: "https://mobile.aane.com/Auction.asmx/SendPicture")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = self.image1
   
       progressView.transform = progressView.transform.scaledBy(x: 1, y: 4)
        
        labelVIN.text = UserDefaults.standard.string(forKey: "vin")
        labelVIN.isHidden = true
        let boolAsString = String(switchMasterPhoto!.isOn)        
        labelVIN.text = (labelVIN.text ?? "") + boolAsString
        
        print(labelVIN.text!)
        
        progressView.progress = 0.0
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

        uploadImage(paramName: labelVIN.text!, fileName: "image.jpeg", image: image1!)
        
        
    }
    

    
    func uploadImage(paramName: String, fileName: String,
           image: UIImage) {
        
        saveButton.isEnabled = false
       
       progressView.setProgress(currentTime, animated: true)
          perform(#selector(updateProgress),with: nil, afterDelay: 1.0)
        
        
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
        let img = image.jpegData(compressionQuality: 0.04)
        
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
                        let alert = UIAlertController(title: "Upload Status", message: "\(json)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    //else {
                        
                    //     self.dismiss(animated: true, completion: nil)
                   // }
        
             
                    
                }
          
                
                
            }
        }).resume()
      
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
    
  

    
    
    
}






extension UIImage {
    
    /// EZSE: Returns base64 string
    public var base64: String {
        return self.jpegData(compressionQuality: 0.20)!.base64EncodedString()
    }
}
    
