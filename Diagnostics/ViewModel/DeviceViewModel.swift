//
//  DeviceViewModel.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 16/03/24.
//

import Foundation

class DeviceViewModel: ObservableObject {
    static let shared = DeviceViewModel()
    
    @Published private var deviceInfo: DeviceInfo
    private let deviceService: DeviceServiceProtocol
    
    init(deviceService: DeviceServiceProtocol = DeviceService()) {
        self.deviceService = deviceService
        self.deviceInfo = deviceService.getDeviceInfo()
    }
    
    func updateDeviceInfo() {
        self.deviceInfo = deviceService.getDeviceInfo()
    }
    
    func getDeviceInfo() -> DeviceInfo {
        return deviceInfo
    }
}
