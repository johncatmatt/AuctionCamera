//
//  VCMissingPhotos.swift
//  AuctionCamera
//
//  Created by Matthew Sansoucie on 6/11/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//




import UIKit

class VCMissingPhotos: UIViewController {

    struct missingPhotoList: Decodable {
        let vl: [t]
    }
    struct t: Decodable {
        var LaneLot: String
        var dlrname: String
        var YrMakeModel: String
        var vin6: String
    }
    
    var carArray=[MissingPhotos]()
    
    var photoNumber = ""
    
    @IBOutlet weak var lblColor: UILabel!
    
   // var CarList
    @IBOutlet weak var tvCarList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        let btnRefresh = UIBarButtonItem(title: "Refresh", style: .done, target: self, action: #selector(refreshPage))
        self.navigationItem.rightBarButtonItem = btnRefresh
       
        
        
        getCars()
        
        

    }

    @objc func refreshPage(){
        getCars()
    }
    
    
    func getCars(){
        showSpinner(onView: self.view)
        let todoEndpoint: String = "https://mobile.aane.com/auction.asmx/MissingPhotoCollection?requestStr=\(photoNumber)"
        print(todoEndpoint)
        
        //empty the array
        carArray.removeAll()
        
        guard let url = URL(string: todoEndpoint) else {
            print("ERROR: cannot create URL")
            self.removeSpinner()
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("text/xml", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest){ data, response, error in
            guard error == nil else{
                print("ERROR: calling GET: \(error!)")
                self.removeSpinner()
                return
            }
        
            guard let data = data else { print("DATA ERROR!!!"); return }
            
            do {
                
                print(data)
                
                let t = try JSONDecoder().decode(missingPhotoList.self, from: data)
                
                DispatchQueue.main.async {
                    if t.vl.isEmpty{
                        print("No missing photos found")
                        let empty = MissingPhotos(LaneLot: "", dlrname: "No Vehiles Missing Photos"
                            , YrMakeModel: "", vin6: "")
                        self.carArray.append(empty)
                    }else{
                        for p in t.vl{
                            let car = MissingPhotos(LaneLot: p.LaneLot, dlrname: p.dlrname, YrMakeModel: p.YrMakeModel, vin6: p.vin6)
                            self.carArray.append(car)
                        }
                    }
                    
                    if self.photoNumber == "14" {
                        self.navigationItem.title = "More Photos Required: \(self.carArray.count)"
                    }else{
                        self.navigationItem.title = "Missing Online Pictures: \(self.carArray.count)"
                    }
                    
                    self.tvCarList.reloadData()
                    
                }
                self.removeSpinner()
                
            } catch _{
                print("Error")
                self.removeSpinner()
            }

        }
        task.resume()

    }
    
}



extension VCMissingPhotos: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvCarList.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! MissingPhotosCell
        
        if carArray[indexPath.row].dlrname == "No Vehiles Missing Photos" {
            
            print("No Vehicles Found")
            let alert = UIAlertController(title: "Search List Empty", message: "No vehicles require photos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                action in
                    self.dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true)
            
            cell.lblCount.text = ""
        }else{
            cell.lblCount.text = "\(indexPath.row + 1): "
        }
        
        cell.lblLotLane.text = "\(carArray[indexPath.row].LaneLot)"
        cell.lblConsignor.text = "\(carArray[indexPath.row].dlrname)"
        cell.lblYearMakeModel.text = "\(carArray[indexPath.row].YrMakeModel)"
        cell.lblVin.text = "\(carArray[indexPath.row].vin6)"
        
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = lblColor.backgroundColor
        } else {
            cell.backgroundColor = UIColor.white
        }
        return cell
    }
    

}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
