//
//  VCScanner.swift
//  AuctionCamera
//
//  Created by John Sansoucie on 3/7/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import UIKit
import AVFoundation

protocol  SendDataFromDelegate {
    func sendData(data : String)
}

//child
class VCScanner: UIViewController,AVCaptureMetadataOutputObjectsDelegate{

    @IBOutlet var square: UIImageView!
    
    
    var delegate : SendDataFromDelegate?  //Create Delegate Variable for Registering it to pass the data
    
    //display video to user
    var video = AVCaptureVideoPreviewLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    let session = AVCaptureSession()

    var defaultVideoDevice: AVCaptureDevice?
    
    // Choose the back dual camera if available, otherwise default to a wide angle camera.
    if let dualCameraDevice = AVCaptureDevice.default(.builtInDualCamera, for: AVMediaType.video, position: .back) {
        defaultVideoDevice = dualCameraDevice
    }
    else if let backCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back) {
        defaultVideoDevice = backCameraDevice
    }
    else if let frontCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front) {
        defaultVideoDevice = frontCameraDevice
    }
    do {
    let input = try AVCaptureDeviceInput(device: defaultVideoDevice!)
        
    session.addInput(input)
        
    }
    catch {
    print("ERROR")
    }
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        //run on main thread
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        //Bar codes assigned below code39 code128 etc
        //output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.code128
            , AVMetadataObject.ObjectType.code93, AVMetadataObject.ObjectType.qr
            , AVMetadataObject.ObjectType.code39, AVMetadataObject.ObjectType.code39Mod43
            , AVMetadataObject.ObjectType.ean13, AVMetadataObject.ObjectType.ean8              ]
        video = AVCaptureVideoPreviewLayer(session: session)
        
        
    //    let orient = UIDevice.current.orientation
     //   print("orient: \(orient)")
  
    
        
       video.frame = view.layer.bounds
   
      //     self.video.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        view.layer.addSublayer(video)
     self.view.bringSubviewToFront(square)
 
        //   self.view.bringSubviewToFront(butClose)
        session.startRunning()
        
    }
  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       setCameraOrientation()
    }
    
    @objc func setCameraOrientation() {
        if let connection =  self.video.connection  {
            let currentDevice: UIDevice = UIDevice.current
            let orientation: UIDeviceOrientation = currentDevice.orientation
            let previewLayerConnection : AVCaptureConnection = connection
            if previewLayerConnection.isVideoOrientationSupported {
                let o: AVCaptureVideoOrientation
                //changes made to allow for only landscape use
                switch (orientation) {
                case .portrait: o = .landscapeRight       //portrait
                case .landscapeRight: o = .landscapeLeft // landscapeLeft
                case .landscapeLeft: o = .landscapeRight  //landscapeRight
                case .portraitUpsideDown: o = .landscapeRight //portraitUpsideDown
                default: o = .landscapeRight  //portrait
                }
                
                previewLayerConnection.videoOrientation = o
                
                /*if o == .landscapeRight{
                    print("right!!!")
                }*/
                
                video.frame = self.view.bounds
            }
        }
    }
    
    
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator)
    {
        
        super.viewWillTransition(to: size, with: coordinator)
        setCameraOrientation()
        /*
         guard
            let conn = self.video.connection,
            conn.isVideoOrientationSupported
            else { return }
        let deviceOrientation = UIDevice.current.orientation
        switch deviceOrientation {
        case .portrait: conn.videoOrientation = .portrait
        case .landscapeRight: conn.videoOrientation = .landscapeLeft
        case .landscapeLeft: conn.videoOrientation = .landscapeRight
        case .portraitUpsideDown: conn.videoOrientation = .portraitUpsideDown
        default: conn.videoOrientation = .portrait
        }
         */
    }
    
   
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count > 0 {
            //if metadataObjects[0] is AVMetadataMachineReadableCodeObject {
            //   let object =  metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            //  let alert = UIAlertController(title: "QR Code", message: object!.stringValue, preferredStyle: .alert)
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            {
                if object.type == AVMetadataObject.ObjectType.code128
                {
                    let alert = UIAlertController(title: "code128 Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    //   alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in UIPasteboard.general.string = object.stringValue
                    alert.addAction(UIAlertAction(title: "Copy Close", style: .destructive, handler: {
                        _ in  if self.delegate != nil {
                            self.delegate?.sendData(data:object.stringValue!)
                            self.navigationController?.popViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                        }}))
                    
                    present(alert, animated: true, completion: nil)
                }
                else if object.type == AVMetadataObject.ObjectType.qr
                {
                    let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    //   alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in UIPasteboard.general.string = object.stringValue
                    //   }))
                    //   alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in UIPasteboard.general.string = object.stringValue
                    alert.addAction(UIAlertAction(title: "Copy Close", style: .destructive, handler: {
                        _ in  if self.delegate != nil {
                            self.delegate?.sendData(data:object.stringValue!)
                            self.navigationController?.popViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                        }}))
                    present(alert, animated: true, completion: nil)
                    
                }
                else if object.type == AVMetadataObject.ObjectType.code39
                {
                   /*
                    let alert = UIAlertController(title: "code39 VIN Scan", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    //   alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in UIPasteboard.general.string = object.stringValue
                    alert.addAction(UIAlertAction(title: "Accept", style: .destructive, handler: {
                        _ in  if self.delegate != nil {
                            self.delegate?.sendData(data:object.stringValue!)
                            self.navigationController?.popViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                        }}))
                    present(alert, animated: true, completion: nil)
                */
             
                //    VCScanner.showAlertMessage(message: object.stringValue!, viewController: self)
                    self.delegate?.sendData(data:object.stringValue!)
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                }
                else if object.type == AVMetadataObject.ObjectType.code93
                {
                    let alert = UIAlertController(title: "code93 Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    //   alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in UIPasteboard.general.string = object.stringValue
                    alert.addAction(UIAlertAction(title: "Copy Close", style: .destructive, handler: {
                        _ in  if self.delegate != nil {
                            self.delegate?.sendData(data:object.stringValue!)
                            self.navigationController?.popViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                        }}))
                    present(alert, animated: true, completion: nil)
                    
                }
                else if object.type == AVMetadataObject.ObjectType.code39Mod43
                {
                    let alert = UIAlertController(title: "code39Mod43 Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    //   alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in UIPasteboard.general.string = object.stringValue
                    alert.addAction(UIAlertAction(title: "Copy Close", style: .destructive, handler: {
                        _ in  if self.delegate != nil {
                            self.delegate?.sendData(data:object.stringValue!)
                            self.navigationController?.popViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                        }}))
                    present(alert, animated: true, completion: nil)
                    
                }
                else if object.type == AVMetadataObject.ObjectType.ean13
                {
                    let alert = UIAlertController(title: "ean13 Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    //   alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in UIPasteboard.general.string = object.stringValue
                    alert.addAction(UIAlertAction(title: "Copy Close", style: .destructive, handler: {
                        _ in  if self.delegate != nil {
                            self.delegate?.sendData(data:object.stringValue!)
                            self.navigationController?.popViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                        }}))
                    present(alert, animated: true, completion: nil)
                    
                }
                else if object.type == AVMetadataObject.ObjectType.ean8
                {
                    let alert = UIAlertController(title: "ean8 Code VIN", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    //   alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in UIPasteboard.general.string = object.stringValue
                    alert.addAction(UIAlertAction(title: "Accept", style: .destructive, handler: {
                        _ in  if self.delegate != nil {
                            self.delegate?.sendData(data:object.stringValue!)
                            self.navigationController?.popViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                        }
                    }))
                    
                    present(alert, animated: true, completion: nil)
                    
                }
                
            }
        }
    }
    
    func pressed(_ object: Any)
    {
        UIPasteboard.general.string = (object as AnyObject).stringValue
        print(object)
        
        
    }
    
  

    
    
    
    
    class func showAlertMessage(message:String, viewController: UIViewController) {
        DispatchQueue.main.async {
            /*
             let alertMessage = UIAlertController(title: "", message: message, preferredStyle: .alert)
             
             let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
             
             alertMessage.addAction(cancelAction)
             
             viewController.present(alertMessage, animated: true, completion: nil)
             */
       //     let alert = UIAlertController(title: "Upload Status", message: message, preferredStyle: .alert)
       //     alert.addAction(UIAlertAction(title: "Okay", style: .default){(action)->() in })
            
            let alert = UIAlertController(title: "code39 VIN Scan", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
     /*
            alert.addAction(UIAlertAction(title: "Accept", style: .destructive, handler:{
                _ in  if self.delegate != nil {
                    self.delegate?.sendData(data:object.stringValue!)
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                }
            }))
            
       */
            
            viewController.present(alert, animated: true, completion: {() -> Void in
                alert.view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2) )
                
            })
            
            
        }
    }
    
    
    
}
