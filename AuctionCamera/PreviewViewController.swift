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
    var image: UIImage!
    
    @IBOutlet var labelVIN: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = self.image
   
       
        labelVIN.text = UserDefaults.standard.string(forKey: "vin")
        
        
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
        let imageData:NSData = image!.jpegData(compressionQuality: 0.25)! as NSData
        //Saved Image
        UserDefaults.standard.set(imageData, forKey: "savedImage")
        //Decode
        let myData = UserDefaults.standard.object(forKey: "savedImage") as! NSData
       // let s = String(decoding: myData, as: UTF8.self)
        ExportImage(myData: myData as Data)
        
        dismiss(animated: true, completion: nil)
        
    }
    

    
    func ExportImage(myData:Data){
        
        
        
        //setup URL
            let vin = labelVIN.text!
        
      let myStr =  String(decoding: myData, as: UTF8.self)
       // let base64 = myStr.base64EncodedData(options: .lineLength64Characters)
        
        let decodedData = NSData(base64Encoded: myStr, options:NSData.Base64DecodingOptions.init(rawValue: 0))
        let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue)
        print(decodedString!) // my plain data
        
        
        var todoEndpoint: String = "https://auction.catmatt.com/Auction/Auction.asmx/StorePicture?vin=\(vin)&image="
        todoEndpoint += decodedString! as String
        
        
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


}
