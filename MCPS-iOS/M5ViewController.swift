//
//  M5ViewController.swift
//  MCPS-iOS
//
//  Created by Yuta on 2023/11/19.
//
//  Mostly from https://github.com/FromF/M5Stack-Color-BluetoothLE/tree/master

import Foundation
import UIKit
import CoreBluetooth

class M5ViewController: UIViewController , CBCentralManagerDelegate , CBPeripheralDelegate {
    
    /// 接続先ローカルネーム
    private let connectToLocalName:String = "M5Stack-Color"
    /// CBCentralManagerインスタンス
    private var centralManager: CBCentralManager!
    /// 接続先Peripheral情報
    private var connectToPeripheral: CBPeripheral!
    /// Write Characteristic
    private var writeCharacteristic: CBCharacteristic?
    /// Notify Characteristic
    private var notifyCharacteristic: CBCharacteristic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeCBCentralManager()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Bluetooth LE
    public func initializeCBCentralManager() {
        centralManager = CBCentralManager(delegate: self, queue: nil, options: nil)
    }
    
    public func sendString(sendText:String) -> Bool {
        var result = false
        if let sendData = sendText.data(using: .utf8, allowLossyConversion: true) , let characteristic = writeCharacteristic , let peripheral = connectToPeripheral {
            peripheral.writeValue(sendData, for: characteristic, type: .withResponse)
            result = true
        }
        return result
    }
    
    private func scanForPeripherals() {
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    private func connectPeripheral() {
        centralManager.stopScan()
        centralManager.connect(connectToPeripheral, options: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOff:
            debugLog("poweredOff")
        case .unknown:
            debugLog("unknown")
        case .resetting:
            debugLog("resetting")
        case .unsupported:
            debugLog("unsupported")
        case .unauthorized:
            debugLog("unauthorized")
        case .poweredOn:
            debugLog("poweredOn")
            scanForPeripherals()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let uuid = UUID(uuid: peripheral.identifier.uuid)
        if let localName = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            debugLog("UUID=[\(uuid)] Name=[\(localName)]")
            if localName == connectToLocalName {
                connectToPeripheral = peripheral
                connectPeripheral()
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheralDiscoverServices()
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        if let error = error {
            debugLog("error:\(error)")
        } else {
            debugLog("error:unkown")
        }
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        connectToPeripheral = nil
        writeCharacteristic = nil
        notifyCharacteristic = nil
        scanForPeripherals()
    }
    
    //MARK:- CBPeripheralDelegate
    private func peripheralDiscoverServices() {
        connectToPeripheral.delegate = self
        connectToPeripheral.discoverServices(nil)
    }
    
    private func peripheralDiscoverCharacteristics(service: CBService) {
        connectToPeripheral.discoverCharacteristics(nil, for: service)
    }
    
    private func peripheralNotifyStart() {
        if let characteristic = notifyCharacteristic {
            connectToPeripheral.setNotifyValue(true, for: characteristic)
            debugLog(characteristic.uuid)
        }
    }
    
    private func peripheralNotifyStop() {
        if let characteristic = notifyCharacteristic {
            connectToPeripheral.setNotifyValue(false, for: characteristic)
            debugLog(characteristic.uuid)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let error = error {
            debugLog("error:\(error)")
        } else {
            if let services = peripheral.services {
                for service in services {
                    debugLog("service uuid = \(service.uuid.uuidString)")
                    peripheralDiscoverCharacteristics(service: service)
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let error = error {
            debugLog("error:\(error)")
        } else {
            if let characteristics = service.characteristics {
                for characteristic in characteristics {
                    debugLog("characteristic = \(characteristic)")
                    switch characteristic.properties {
                    case .write:
                        debugLog("write")
                        writeCharacteristic = characteristic
                    case .notify:
                        debugLog("notify")
                        notifyCharacteristic = characteristic
                        peripheralNotifyStart()
                    default:
                        debugLog("unknown")
                    }
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
        if let error = error {
            debugLog("error:\(error)")
        } else {
            debugLog("ok")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            debugLog("error:\(error) uuid:\(characteristic.uuid)")
        } else {
            debugLog("ok uuid:\(characteristic.uuid)")
            //labelWrite(text: "notify ok")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            debugLog("error:\(error) uuid:\(characteristic.uuid)")
        } else {
            if let value = characteristic.value , let str = String(data: value, encoding: .utf8) {
                debugLog("\(str)")
            }
        }
    }
}

