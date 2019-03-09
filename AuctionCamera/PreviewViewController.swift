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
       // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
      //  UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
       // dismiss(animated: true, completion: nil)
        
        
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
         
            
            
        }

        
        dismiss(animated: true, completion: nil)    }
    
 //   @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
 //       if let error = error {
 //           // we got back an error!
 //           let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
 //           ac.addAction(UIAlertAction(title: "OK", style: .default))
 //           present(ac, animated: true)
 //       } else {
 //           let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
  //          ac.addAction(UIAlertAction(title: "OK", style: .default))
  //          present(ac, animated: true)
  //      }
  //  }
    
    
    
}
