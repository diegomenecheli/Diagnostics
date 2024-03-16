//
//  BatteryService.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 16/03/24.
//

import Foundation
import UIKit

protocol BatteryServiceProtocol {
    func getBatteryLevel() -> Float
}

class BatteryService: BatteryServiceProtocol {
    func getBatteryLevel() -> Float {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return UIDevice.current.batteryLevel * 100
    }
}
