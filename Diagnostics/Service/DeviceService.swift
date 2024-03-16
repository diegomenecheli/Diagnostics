//
//  DeviceService.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 16/03/24.
//

import Foundation
import UIKit

import Foundation

protocol DeviceServiceProtocol {
    func getDeviceInfo() -> DeviceInfo
}

class DeviceService: DeviceServiceProtocol {
    private let deviceInfoService: DeviceInfoServiceProtocol
    
    init(deviceInfoService: DeviceInfoServiceProtocol = DeviceInfoService()) {
        self.deviceInfoService = deviceInfoService
    }
    
    func getDeviceInfo() -> DeviceInfo {
        return deviceInfoService.getDeviceInfo()
    }
}
