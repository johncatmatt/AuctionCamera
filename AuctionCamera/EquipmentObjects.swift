//
//  EquipmentObjects.swift
//  AuctionCamera
//
//  Created by Matthew Sansoucie on 8/15/19.
//  Copyright © 2019 Matthew Sansoucie. All rights reserved.
//

import Foundation



class EquipmentCodes {
    
    var EQGroup: String
    var EQDesc: String
    var id: String
    
    init(EQGroup: String, EQDesc: String, id: String) {
        self.EQGroup = EQGroup
        self.EQDesc = EQDesc
        self.id = id
    }
    
}




class Engine {
    var NA = "<N/A>"
    var Cyl10 = "10-Cylinder"                       //10
    var Cyl10Dis = "10-Cylinder Diesel"             //10D
    var Cyl10DisTurbo = "10-Cylinder Diesel Turbo"  //1DT
    var Cyl10Gas = "10-Cylinder Gas"                //10G
    var Cyl10GassTurbor = "10-Cylinder Gas Turbo"   //10GT
    var cyl12 = "12-Cylinder"                       //12
    var cyl12Gas = "12-Cylinder Gas"                //12G
    var cyl1Gas = "1-Cylinder Gas"                  //1G
    var cyl2 = "2-Cylinder Gas"                     //2G
    var cyl3Gas = "3-Cylinder Gas"                  //3G
    var cyl3GasTurbo = "3-Cylinder Gas Turbo"       //3GT
    var cyl3Propane = "3-Cylinder Propane"          //3P
    var cyl4Diesel = "4-Cylinder Diesel"            //4D
    var cyl4DiselTurbo = "4-Cylinder Diesel Turbo"  //4DT
    var cyl4FlexFuel = "4-Cylinder Flex Fuel"       //4F
    var cyl4Gas = "4-Cylinder Gas"                  //4G
    var cyl4GasTurbo = "4-Cylinder Gas Turbo"       //4GT
    var cyl4Hybrid = "4-Cylinder Hybrid"            //4H
    var cyl4NatGas = "4-Cylinder Natural Gas"       //4NG
    var cyl4Propane = "4-Cylinder Propane"          //4P
    var cyl5Diesel = "5-Cylinder Diesel"            //5D
    var cyl5DieselTurbo = "5-Cylinder Diesel Turbo" //5DT
    var cyl5FlexFuel = "5-Cylinder Flex Fuel"       //5F
    var cyl5Gas = "5-Cylinder Gas"                  //5G
    var cyl5GasTurbo = "5-Cylinder Gas Turbo"       //5GT
    var cyl5NatGas = "5-Cylinder Natural Gas"       //5NG
    var cyl6Diesel = "6-Cylinder Diesel"            //6D
    var cyl6DieselTurbo = "6-Cylinder Diesel Turbo" //6DT
    var cyl6FlexFuel = "6-Cylinder Flex Fuel"       //6F
    var cyl6Gas = "6-Cylinder Gas"                  //6G
    var cyl6GasTurbo = "6-Cylinder Gas Turbo"       //6GT
    var cyl6Hybrid = "6-Cylinder Hybrid"            //6H
    var cyl6NatGas = "6-Cylinder Natural Gas"       //6NG
    var cyl6Propane = "6-Cylinder Propane"          //6P
    var cyl8Disel = "8-Cylinder Diesel"             //8D
    var cyl8DieselTurbo = "8-Cylinder Diesel Turbo" //8DT
    var cyl8FlexFuel = "8-Cylinder Flex Fuel"       //8F
    var cyl8Gas = "8-Cylinder Gas"                  //8G
    var cyl8GasTurbo = "8-Cylinder Gas Turbo"       //8GT
    var cyl8Hybrid = "8-Cylinder Hybrid"            //8H
    var cyl8NatGas = "8-Cylinder Natural Gas"       //8NG
    var cyl8Propane = "8-Cylinder Propane"          //8P
    var caterpillar = "Caterpillar"                 //CAT
    var cummins = "Cummins"                         //CMN
    var detroit = "Detroit"                         //DET
    var electric = "Electric"                       //EL
    var flatFour = "Flat Four"                      //F4
    var flatSix = "Flat Six"                        //F6
    var flatTwin = "Flat Twin"                      //FT
    var inlineFour = "Inline Four"                  //I4
    var inlineSix = "Inline Six"                    //I6
    var inlineTriple = "Inline Triple"              //I3
    var millerCycle = "Miller Cycle"                //MC
    var rotaryEngGas = "Rotary Engine Gas"          //RG
    var rotaryEngTurbo = "Rotary Engine Turbo"      //RT
    var vTwin = "V-Twin"                            //VT
}

class Trans {
    var NA = "<N/A>"
    var autoStickTrans = "Auto Stick Transmission"
    var autoTranswOverdrive = "Auto Trans with Overdrive"
    var autotrans = "Automatic Transmission"
    var autotranswOverdrive = "Automatic Transmission w/ Overdrive"
    var autoStick = "AutoStick"
    var continVariTrans = "Continuously Variable Transmission"
    var fiveSpeedManualTrans = "Five Speed Manual Transmission"
    var fourSpeedManualTrans = "Four Speed Manual Transmission"
    var manTrans = "Manual Transmission"
    var sequentialManualGearbox = "Sequential Manual Gearbox"
    var sixSpeedManualTrans = "Six Speed Manual Transmission"
    var steptronicTrans = "Steptronic Transmission"
    var threeSpeedManualTrans = "Three Speed Manual Transmission"
}

class Interior {
    var NA = "<N/A>"
    var cloth = "Cloth Interior"
    var clothVinyl = "Cloth/Vinyl"
    var leather = "Leather Interior"
    var leatherCloth = "Leather/Cloth Interior"
    var leatherette = "Leatherette"
    var textile = "Textile"
    var velour = "Velour"
    var vinyl = "Vinyl Interior"
}


class Roof {
    var NA = "<N/A>"
    var carriage = "Carriage"
    var coach = "Coach"
    var convertible = "Convertible"
    var convertibleSoftTop = "Convertible Soft Top"
    var convertibleBoot = "Convertible with Boot"
    var fiberglass = "Fiberglass Camper Shell"
    var flip = "Flip"
    var glassSun = "Glass Sun"
    var hardTop = "Hard Top"
    var hardTunnCov = "Hard Tunneau Cover"
    var hatchBack = "Hatchback"
    var landdau = "Landau"
    var manGlassSun = "Man Glass Sun Roof"
    var manSteelSun = "Man Steel Sun Roof"
    var manual = "Manual Sun"
    var moonRoof = "Moon Roof"
    var powerSun = "Power Sun"
    var pwrGlassSun = "Pwr Glass Sun Roof"
    var pwrSteelSun = "Pwr Steel Sun Roof"
    var skyView = "Sky View"
    var steelSun = "Steel Sun"
    var sun = "Sun Roof"
    var targa = "Targa"
    var tiltSlideSun = "Tilt and Slide Sun Roof"
    var tTopStyle = "T-Top Style"
    var vinylTop = "Vinyl Top"
}

class Radio {
    var NA = "<N/A>"

}

class Breaks {
    var NA = "N/A"
    var airBrks = "Air Breaks"
    var antiLkBreaks = "Anti Lock Brakes"
    var disc = "Disc"
    var drum = "Drum"
    var hydralic = "Hydraulic Breaks"
    var power = "Power Breaks"
    var traction = "Traction Control"
}

class Seats {
    var NA = "<N/A>"

}

class Airbags {
    var NA = "N/A"
    var air10 = "10 Airbags"
    var air3 = "3 Airbags"
    var air4 = "4 Airbags"
    var air5 = "5 Airbags"
    var air6 = "6 Airbags"
    var air7 = "7 Airbags"
    var air8 = "8 Airbags"
    var air9 = "9 Airbags"
    var driverSideAir = "Driver Side Air Bag"
    var dualAir = "Dual Air Bag"
    var dualAirfront = "Dual Alr Bags w/front SI Bags"
    var dualAndSide = "Dual and Side Airbags"
}

class DriveType {
    var NA = "<N/A>"
    var wheel2 = "2 Wheel"
    var wheel4Drive = "4-Wheel Drive"
    var x4x2x = "4x2"
    var allWheel = "All Wheel"
    var frontWheel = "Front Wheel"
    var rearWheel = "Rear Wheel"
}

class ExteriorColor {
    var NA = "<N/A>"

}

class InteriorColor {
    var NA = "<N/A>"

}

class MileageType {
    var NA = "<N/A>"
    var digital = "Digital"
    var digitalBrkn = "Digital Broken"
    var exmpt = "Exempt"
    var man = "Manual"
    var manBrkn = "Manual Broken"
    var OdoDiscrepancy = "Odo Discrepancy"
    var repairedReplaced = "Repaired/Replaced"
    var unverified = "Unverified"
    var verified = "Verified"
}

class TrieRating {
    var NA = "<N/A>"
    var average = "Average"
    var good = "Good"
    var poor = "Poor"
}

class Wheels {
    var NA = "NA"
    var alloy = "Alloy"
    var chrome = "Chrome"
    var steel = "Steel"
}


