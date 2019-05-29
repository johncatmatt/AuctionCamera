//
//  ViewController.swift
//  AuctionCamera
//
//  Created by Matthew Sansoucie on 3/2/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit
import AVFoundation
//import Alamofire



class ViewController: UIViewController {

    
    @IBOutlet weak var switchMasterPhoto: UISwitch!
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var portriatCamera: AVCaptureDevice?
    var landscapeCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    @IBOutlet weak var cemeraButton: UIButton!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     //   cemeraButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput() //dw
        setupPreviewLayer()
        
        startRunningCapturSession()
        let vin = UserDefaults.standard.string(forKey: "vin")!
        
        let upperTitle = NSMutableAttributedString(string: "\(vin)", attributes: [NSAttributedString.Key.font: UIFont(name: "Arial", size: 17)!])
        
        let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height:66))
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.attributedText = upperTitle  //assign it to attributedText instead of text
        self.navigationItem.titleView = label1
        
   //dw     let image = UIImage(named: "download.jpeg")
        
   //dw    uploadImage(paramName: "1GDJK74K29F134095", fileName: "image.jpeg", image: image!)
   //
        
       // uploadImageOne()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setCameraOrientation()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switchMasterPhoto.isOn = false
        cemeraButton.setTitle("Photo", for: .normal)
        
    }

    func setupCaptureSession(){
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func switchValueDidChange(sender:UISwitch!){
        
        print("Switch Value : \(sender.isOn))")
    }
    
    func uploadImage(paramName: String, fileName: String, image: UIImage) {
        let url = URL(string: "https://mobile.aane.com/Auction.asmx/SendPicture")
        
        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString
        
        let session = URLSession.shared
        
        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        
        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        
        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        
        
        let img = image.pngData()
        
        let base64String = img?.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
       // let myDataEncoded = base64String?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        data.append(base64String!)
        
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any] {
                    print(json)
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
     
     //  var lineAmount : String
     
     }
    
   
    func setupDevice(){
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            }else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
         currentCamera = backCamera
    }
    
    func setupInputOutput(){
        do {
        let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
            
   
            
        } catch{
            print(error)
        }
    }
    
    
    func setupPreviewLayer(){
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        //cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
   
        
        //   cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeRight
        
        cameraPreviewLayer?.frame = self.view.frame
        
//cameraPreviewLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 0.7)
        //CGRectMake(0 , 0, self.view.frame.width, self.view.frame.height * 0.7)

        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
        
        
    }
    
    func startRunningCapturSession(){
        captureSession.startRunning()
    }
    
    
    @IBAction func cameraButton_TouchUpInside(_ sender: Any) {
           let settings = AVCapturePhotoSettings()
        

      
        
        
            photoOutput?.capturePhoto(with: settings, delegate: self)
        
  // performSegue(withIdentifier: "showPhoto_Segue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto_Segue" {
            let previewVC = segue.destination as! PreviewViewController
            
            print(image!.imageOrientation.rawValue)
       print(cameraPreviewLayer!.connection!.videoOrientation.rawValue)
      
        //          image = rotateImage(image: image!)
            
       
            if (image!.imageOrientation.rawValue == cameraPreviewLayer!.connection!.videoOrientation.rawValue)
            {
                image = rotateImage(image: image!)
                
            }
         
            previewVC.image1 = self.image
            
            previewVC.switchMasterPhoto = self.switchMasterPhoto
            
        }
    }

    func rotateImage(image:UIImage) -> UIImage
    {
        var rotatedImage = UIImage()
        switch image.imageOrientation
        {
        case .right:
            rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .up )//.down)
            
        case .down:
            rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .up )//.left)
            
        case .left:
            rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .up)
            
        default:
            rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .right)
        }
        
        return rotatedImage
    }
    
    
    
    
    @IBAction func switchMasterPhoto_touchupInside(_ sender: Any) {
               UserDefaults.standard.set(switchMasterPhoto.isOn, forKey: "masterPic")
        print(UserDefaults.standard.string(forKey: "masterPic") as Any)
        let onOff = (UserDefaults.standard.string(forKey: "masterPic") )!
        
        if onOff == "1" as String {
            cemeraButton.setTitle("Master", for: .normal)
            
        } else {
                    cemeraButton.setTitle("Photo", for: .normal)
        }
        
    }
    @objc func setCameraOrientation() {
        if let connection =  self.cameraPreviewLayer?.connection  {
            let currentDevice: UIDevice = UIDevice.current
            let orientation: UIDeviceOrientation = currentDevice.orientation
            let previewLayerConnection : AVCaptureConnection = connection
            if previewLayerConnection.isVideoOrientationSupported {
                let o: AVCaptureVideoOrientation
                switch (orientation) {
                case .portrait: o = .portrait
                case .landscapeRight: o = .landscapeLeft
                case .landscapeLeft: o = .landscapeRight
                case .portraitUpsideDown: o = .portraitUpsideDown
                default: o = .portrait
                }
                
                previewLayerConnection.videoOrientation = o
                cameraPreviewLayer!.frame = self.view.bounds
            }
        }
    }

}

extension ViewController: AVCapturePhotoCaptureDelegate {
    
    
    
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation(){
     //  print(imageData)
            image = UIImage(data: imageData)
            performSegue(withIdentifier: "showPhoto_Segue", sender: nil)
            
        }
    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator)
    {
        super.viewWillTransition(to: size, with: coordinator)
        setCameraOrientation()
        
      
        
        /*
        super.viewWillTransition(to: size, with: coordinator)
        guard
            let conn = self.cameraPreviewLayer?.connection,
            conn.isVideoOrientationSupported
            else { return }
        let deviceOrientation = UIDevice.current.orientation
        switch deviceOrientation {
        case .portrait: conn.videoOrientation = .portrait
        case .landscapeRight: conn.videoOrientation = .landscapeLeft
        case .landscapeLeft: conn.videoOrientation = .landscapeRight
        case .portraitUpsideDown: conn.videoOrientation = .portraitUpsideDown
        default: conn.videoOrientation = .portrait
        */
    }
 
    
}
extension Data{
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}
extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        
        return self
    }
}
