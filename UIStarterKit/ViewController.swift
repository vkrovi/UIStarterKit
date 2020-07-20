//
//  ViewController.swift
//  UIStarterKit
//
//  Created by Venkat Krovi on 5/29/20.
//  Copyright © 2020 110DigitalLabs. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth
import UIKit
import CoreBluetooth

class ParticlePeripheral: NSObject {

    /// MARK: - Particle LED services and charcteristics Identifiers

    public static let particleLEDServiceUUID     = CBUUID.init(string: "913C5856-A5B4-A01C-6243-E9F784808242")
//    public static let redLEDCharacteristicUUID   = CBUUID.init(string: "b4250401-fb4b-4746-b2b0-93f0e61122c6")
//    public static let greenLEDCharacteristicUUID = CBUUID.init(string: "b4250402-fb4b-4746-b2b0-93f0e61122c6")
//    public static let blueLEDCharacteristicUUID  = CBUUID.init(string: "b4250403-fb4b-4746-b2b0-93f0e61122c6")

}
class ViewController: BaseViewController, CBPeripheralDelegate, CBCentralManagerDelegate, CLLocationManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Central state update")
        if central.state != .poweredOn {
            print("Central is not powered on")
        } else {
            print("Central scanning for", ParticlePeripheral.particleLEDServiceUUID);
            centralManager.scanForPeripherals(withServices: nil,
                                              options: nil)
            
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {

        // We've found it so stop scan
        if peripheral.name == "BlueCharm_757" {
            self.centralManager.stopScan()
            self.peripheral = peripheral
            self.peripheral.delegate = self
            self.centralManager.connect(self.peripheral, options: nil)
            Logger.info("connected \(peripheral.description)")
        }

        // Copy the peripheral instance
        
        Logger.info(peripheral.description)

        // Connect!
        

    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        if peripheral == self.peripheral {
            print("Connected to your Particle Board")
            peripheral.delegate = self
            
            peripheral.discoverServices(nil)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
//                if service.uuid == ParticlePeripheral.particleLEDServiceUUID {
//                    print("LED service found")
                    //Now kick off discovery of characteristics
                
                    peripheral.discoverCharacteristics(nil, for: service)
//                    return
//                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        print(descriptor)
    }
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("char \(characteristic)")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
        print("disc\(descriptor)")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        print(characteristic)
    }
    
    func peripheralIsReady(toSendWriteWithoutResponse peripheral: CBPeripheral) {
        Logger.info("per \(peripheral)")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        Logger.info("\(characteristic)")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("Service in char\(service.debugDescription)")
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
//                  if ["FEA1", "FEA2","8EC90003-F315-4F60-9FB8-838830DAEA50"].contains(characteristic.uuid) {
//                peripheral.setNotifyValue(true, for: characteristic)
                characteristic.setValue(true, forKey: "notifying")
                print("Red LED characteristic found\(characteristic.debugDescription)")
                peripheral.discoverDescriptors(for: characteristic)
                peripheral.readValue(for: characteristic)
//                }
            }
        }
    }
    
    var locationManager: CLLocationManager = CLLocationManager()
    private var centralManager: CBCentralManager!
    private var peripheral: CBPeripheral!
    func assignView() {
        let thisView = UIView()
        thisView.backgroundColor = .red
        self.view = thisView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
//        centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        } else if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
        } else {
            Logger.error("no auth for locaion")
        }
    }
    
    func startScanning() {
        let uuid = UUID(uuidString: "426C7565-4368-6172-6D42-6561636F6E73")!
        let uuidSingle = UUID(uuidString: "426C7565-4368-6172-6D42-6561636F6E76")!
        let uuidDouble = UUID(uuidString: "426C7565-4368-6172-6D42-6561636F6E79")!
        let idString = "DD330A111A3D"
        let major = 3838
        let minor = 4949
        for uuids in [ uuidSingle, uuidDouble] {
            let constraint = CLBeaconIdentityConstraint(uuid: uuids, major: CLBeaconMajorValue(major), minor: CLBeaconMinorValue(minor))
            let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: constraint, identifier: idString)
            
            locationManager.startMonitoring(for: beaconRegion)
            locationManager.startRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)

        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if beacons.count > 0 {
            updateDistance(beacons[0].proximity)
        } else {
            updateDistance(.unknown)
        }
    }
    
    
    func updateDistance(_ distance: CLProximity) {
        Logger.info("distance \(distance.rawValue)")
        UIView.animate(withDuration: 0.8) {
            switch distance {
            case .far:
                self.view.backgroundColor = UIColor.blue

            case .near:
                self.view.backgroundColor = UIColor.orange

            case .immediate:
                self.view.backgroundColor = UIColor.red
            default:
                self.view.backgroundColor = UIColor.gray
            }
        }
    }
}

