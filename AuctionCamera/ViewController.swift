//
//  ViewController.swift
//  AuctionCamera
//
//  Created by Matthew Sansoucie on 3/2/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit
import AVFoundation



class ViewController: UIViewController {

    
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCapturSession()
        
        
        
    }

    func setupCaptureSession(){
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func ExportImage(){
        
        
        
        //setup URL
        let vin = "hfhhfhfhfhfhfhfh";
        
        
        
        let todoEndpoint: String = "https://auction.catmatt.com/Auction/Auction.asmx/StorePicture?vin=\(vin)&image=0";
        
        //  let todoEndpoint: String = "https://secureservice.autouse.com/dlrweb/WebService1.asmx/HelloWorld?dlrno=00216";
        
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
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
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
            previewVC.image = self.image
            
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
}

