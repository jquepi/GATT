//
//  PeripheralTests.swift
//  GATT
//
//  Created by Alsey Coleman Miller on 4/2/16.
//  Copyright © 2016 PureSwift. All rights reserved.
//

import XCTest
import Foundation
import CoreBluetooth
import SwiftFoundation
import Bluetooth
import GATT
import GATTTest

final class ClientTests: XCTestCase {
    
    func testServices() {
        
        for testService in TestData.services {
            
            guard let foundService = foundServices.filter({ $0.UUID == TestData.testService.UUID }).first
                else { XCTFail("Service \(testService.UUID) not found"); continue }
            
            /*
            XCTAssert(foundService.primary == testService.primary,
                      "Service \(testService.UUID) primary is \(foundService.primary), should be \(testService.primary)")
            */
        }
    }
    
    func testCharacteristics() {
        
        for testService in TestData.services {
            
            guard let characteristics = foundCharacteristics[testService.UUID]
                else { XCTFail("No characteristics found for service \(testService.UUID)"); continue }
            
            for testCharacteristic in testService.characteristics {
                
                guard let foundCharacteristic = characteristics.filter({ $0.UUID == testCharacteristic.UUID }).first
                    else { XCTFail("Characteristic \(testCharacteristic.UUID) not found"); continue }
                
                // validate properties (CoreBluetooth Peripheral may add extended properties)
                for property in testCharacteristic.properties {
                    
                    guard foundCharacteristic.properties.contains(property)
                        else { XCTFail("Property \(property) not found in \(testCharacteristic.UUID)"); continue }
                }
                
                // permissions are server-side only
                
                // read value
                if testCharacteristic.properties.contains(.Read) {
                    
                    let foundData = foundCharacteristicValues[testCharacteristic.UUID]
                    
                    XCTAssert(foundData == testCharacteristic.value, "Invalid value for characteristic \(testCharacteristic.UUID)")
                }
            }
        }
    }
    
    /*
    func testGetServices() {
        
        guard let service = TestCentralManager.manager.fetchTestService()
            else { XCTFail("Could not fetch test service. "); return }
        
        let foundServices = service.peripheral.services ?? []
        
        print("Found services: \(foundServices.map({ $0.UUID.UUIDString }))")
        
        for service in TestData.services {
            
            guard let foundService = foundServices.filter({ Bluetooth.UUID(foundation: $0.UUID) == service.UUID }).first
                else { XCTFail("Test service \(service.UUID) not found"); continue }
            
            /*
            XCTAssert(foundService.isPrimary == service.primary,
                      "Found service \(service.UUID) primary value is \(foundService.isPrimary), should be \(service.primary)")
            */
            
            let foundCharacteristics = foundService.characteristics ?? []
            
            for characteristic in service.characteristics {
                
                guard let foundCharacteristic = foundCharacteristics.filter({ Bluetooth.UUID(foundation: $0.UUID) == characteristic.UUID }).first else { XCTFail("Test characteristic \(characteristic.UUID) not found"); continue }
                
                // validate data
                if characteristic.properties.contains(.Read) {
                    
                    let foundData = Data(foundation: (foundCharacteristic.value ?? NSData()))
                    
                    //XCTAssert(foundData == characteristic.value, "Test characteristic \(characteristic.UUID) data does not match. (\(foundData.toFoundation()) == \(characteristic.value.toFoundation()))")
                }
            }
        }
 
    }*/
}