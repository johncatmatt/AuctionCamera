//
//  VCPreview.swift
//  AuctionCamera
//
//  Created by Matthew Sansoucie on 3/2/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit


class PreviewViewController: UIViewController
{

    
    @IBOutlet weak var photo: UIImageView!
    var image1: UIImage!
    
    @IBOutlet var labelVIN: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = self.image1
   
       
        labelVIN.text = UserDefaults.standard.string(forKey: "vin")
        print(labelVIN.text!)
        
        // Do any additional setup after loading the view.
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

        let jpg = image1.pngData()?.base64EncodedString()
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
        
        postRequest(myData: jpg!)
        dismiss(animated: true, completion: nil)
        
        
        
        
    }
    

    
    func ExportImage(myData:String?){
        
        let vin = labelVIN.text!

        //setup URL
        
        
      //let myStr =  String(decoding: myData, as: UTF8.self)
       // let base64 = myStr.base64EncodedData(options: .lineLength64Characters)
        
   //     let decodedData = NSData(base64Encoded: myData.base64EncodedData(options: NSData.Base64EncodingOptions).init(rawValue: 0))
      //  let test = myData.base64EncodedString(options: <#T##NSData.Base64EncodingOptions#>)
      //  let decodedString = myData.base64EncodedString(options: .lineLength64Characters);
    //    print(decodedString!) // my plain data
        
        
        let todoEndpoint: String = "https://auction.catmatt.com/Auction/Auction.asmx/StorePicture?vin=\(vin)&image=\(myData!)";
   //     todoEndpoint += decodedString as String
        
       
        
        guard let url = URL(string: todoEndpoint) else {
            
            print("Error: cannot create URL")
            
            return
            
        }
        
        
        
        var urlRequest = URLRequest(url: url)
        
        
        
        urlRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        
        urlRequest.addValue("text/xml", forHTTPHeaderField: "Accept")
        
        
        
        //start the url session
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest){ data, response, error in
            //check for errors
            
            guard error == nil else {
                
                print("Error calling GET: \(error!)")
                
                return
                
            }
            guard let data = data else { print("DATA error"); return }
            
            
            
            do {
                
                //decodes the json from the data
                
                
                //       let testString = try JSONSerialization.jsonObject(with: data, options: .allowFragments);
                
                let d = try JSONDecoder().decode(jsonData.self,from: data)
                
                
                DispatchQueue.main.async {
                    
                    let x =  d.imageid;
                    let y = d.error;
                    
                    
                    //self.lineAmount = d.lineAmount
                    
                    //     self.lblLineAmmount.text = self.lblLineAmmount.text! + //d.lineAmount
                    
                    
                    
                    let msgAlert = UIAlertController(title: "Data Recieved!", message: "The following data was recieved by the app: \(d)", preferredStyle: UIAlertController.Style.alert)
                    
                    msgAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        msgAlert.dismiss(animated: true, completion: nil)
                        
                        
                        
                    }))
                    
                    
                    
                    self.present(msgAlert, animated: true, completion: nil)
                    
                    
                    
                }
                
                
                
                
                
            } catch let jsonErr{
                
                print("JSON Error: ", jsonErr)
                
            }
            
            
            
        }
        
        task.resume()
        
    }
    struct jsonData: Decodable {
        
        var imageid : NSInteger
        
        var error : String
        
        //  var lineAmount : String
    }
    func test(image:NSData){
    // the ima(ge in UIImage type
   // guard let image = myData else { return  }
     let vin = labelVIN.text!
    let filename = "avatar.png"
    
    // generate boundary string using a unique per-app string
    let boundary = UUID().uuidString
    
    let fieldName = "vin"
  //  let fieldValue = "fileupload"
    
    let fieldName2 = "image"
  //  let fieldValue2 = "caa3dce4fcb36cfdf9258ad9c"
    
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    // Set the URLRequest to POST and to the specified URL
    var urlRequest = URLRequest(url: URL(string: "https://auction.catmatt.com/Auction/Auction.asmx")!)
    urlRequest.httpMethod = "POST"
    
    // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
    // And the boundary is also set here
    urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
    var data = Data()
    
    // Add the reqtype field and its value to the raw http request data
    data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
    data.append("Content-Disposition: form-data; name=vin\r\n\r\n".data(using: .utf8)!)
    data.append("\(vin)".data(using: .utf8)!)
    
  //  // Add the userhash field and its value to the raw http reqyest data
  data.append("Content-Disposition: form-data; name=image\r\n\r\n".data(using: .utf8)!)
//
    // Add the image data to the raw http request data
    data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
   // data.append("Content-Disposition: form-data; name=\"fileToUpload\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
    data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image1.pngData()!)   // End the raw http request data, note that there is 2 extra dash ("-") at )the end, this is to indicate the end of the data
    // According to the HTTP 1.1 specification https://tools.ietf.org/html/rfc7230
    data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
    
    // Send a POST request to the URL, with the data we created earlier
    session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
    
    if(error != nil){
    print("\(error!.localizedDescription)")
    }
    
    guard let responseData = responseData else {
    print("no response data")
    return
    }
    
    if let responseString = String(data: responseData, encoding: .utf8) {
    print("uploaded to: \(responseString)")
    }
    }).resume()
    }
    
    
    
    
    
    func postRequest(myData: String)
    {
        let vin = labelVIN.text!
        
        let url = URL(string : "https://auction.catmatt.com/Auction/Auction.asmx/StorePicture")!
       // let url:URL = URL(string: "https://auction.catmatt.com/Auction/Auction.asmx/StorePicture")!
       // var request = NSMutableURLRequest(URL: NSURL(string: url))
        let request = NSMutableURLRequest(url: NSURL(string: "https://auction.catmatt.com/Auction/Auction.asmx/StorePicture")! as URL)
    
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
   //     var imageData = image1([1,2,254,255])
     //   var base64String = image1.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.fromRaw(0)!) // encode the image
        

        // jjs    UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
 
        
        //vin=\(vin)&image=\(decodedString)"
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        // your post request data
        let postDict : [String: Any] = ["vin": vin,
                                        "image": myData]

        
        
        guard let postData = try? JSONSerialization.data(withJSONObject: postDict, options: []) else {
            return
        }
        
        urlRequest.httpBody = postData
        
        print(urlRequest)
        
        let task = session.dataTask(with: urlRequest){ data, response, error in
            //check for errors
            
            guard error == nil else {
                
                print("Error calling GET: \(error!)")
                
                return
                
            }
            guard let data = data else { print("DATA error"); return }
            
            
            
            do {
                
                //decodes the json from the data
                
                
                //       let testString = try JSONSerialization.jsonObject(with: data, options: .allowFragments);
                
                let d = try JSONDecoder().decode(jsonData.self,from: data)
                
                
                DispatchQueue.main.async {
                    
               //     let x =  d.imageid;
                //    let y = d.error;
                    
                    
                    //self.lineAmount = d.lineAmount
                    
                    //     self.lblLineAmmount.text = self.lblLineAmmount.text! + //d.lineAmount
                    
                    
                    
                    let msgAlert = UIAlertController(title: "Data Recieved!", message: "The following data was recieved by the app: \(d)", preferredStyle: UIAlertController.Style.alert)
                    
                    msgAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        msgAlert.dismiss(animated: true, completion: nil)
                        
                        
                        
                    }))
                    
                    
                    
                    self.present(msgAlert, animated: true, completion: nil)
                    
                    
                    
                }
                
                
                
                
                
            } catch let jsonErr{
                
                print("JSON Error: ", jsonErr)
                
            }
            
            
            
        }
        
        task.resume()
    }

}





/*
extension UIImage {
    func resizeWith(percentage: CGFloat) -> UIImage? {
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

 
extension UIImage {
    
    func toBase64() -> String? {
     var image1: UIImage
       
       //  let imageData : NSData = UIImageJPEGRepresentation(self, 1.0)! as NSData
        // let imageData : Data = image.jpegData(compressionQuality: 1.0)!
        
        let imageData: NSData = image1.jpegData(compressionQuality: 1.0)! as NSData
        
        return  imageData.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
    }
}
 */
/*
extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else {
            return nil
        }
        
        return String(data: data as Data, encoding: String.Encoding.utf8)
    }
    
    func toBase64() -> String? {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }
*/

extension UIImage {
    
    /// EZSE: Returns base64 string
    public var base64: String {
        return self.jpegData(compressionQuality: 0.25)!.base64EncodedString()
    }
}
    

    




 
 

