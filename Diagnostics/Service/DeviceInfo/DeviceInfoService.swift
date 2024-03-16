//
//  DeviceInfoService.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 16/03/24.
//

import Foundation
import UIKit

protocol DeviceInfoServiceProtocol {
    func getDeviceInfo() -> DeviceInfo
}

class DeviceInfoService: DeviceInfoServiceProtocol {
    private let batteryService: BatteryServiceProtocol
    private let diskSpaceService: DiskSpaceServiceProtocol
    private let uptimeService: UptimeServiceProtocol

    init(batteryService: BatteryServiceProtocol = BatteryService(),
         diskSpaceService: DiskSpaceServiceProtocol = DiskSpaceService(),
         uptimeService: UptimeServiceProtocol = UptimeService()) {
        self.batteryService = batteryService
        self.diskSpaceService = diskSpaceService
        self.uptimeService = uptimeService
    }

    func getDeviceInfo() -> DeviceInfo {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true

        let name = device.name
        let model = device.model
        let systemName = device.systemName
        let systemVersion = device.systemVersion
        let identifier = device.identifierForVendor?.uuidString ?? "Unknown"
        var cpuUsage: Double = 0
        var cpuIdle: Double = 0
        let batteryLevel = batteryService.getBatteryLevel()

        guard let diskSpaceInfo = diskSpaceService.getDiskSpaceInfo() else {
            return DeviceInfo(name: name, model: model, systemName: systemName, systemVersion: systemVersion, identifier: identifier, totalSpace: "", freeSpace: "", usedSpace: "", batteryLevel: batteryLevel, rebootTime: "", uptime: "", cpuUsage: 0, cpuIdle: 0)
        }

        let rebootDate = getLastRebootDate()
        let rebootTime = rebootDate != nil ? StringHelper().convertDateToString(date: rebootDate!, format: "dd/MM/yy hh:mm a") : ""
        let uptime = rebootDate != nil ? uptimeService.getUptime(lastRebootDate: rebootDate!) : ""

        if let cpuLoadInfo = hostCPULoadInfo() {
            let loadInfo = host_cpu_load_info()
            let cpuUsageDiff = Double(cpuLoadInfo.cpu_ticks.0 - loadInfo.cpu_ticks.0)
            let sysDiff = Double(cpuLoadInfo.cpu_ticks.1 - loadInfo.cpu_ticks.1)
            let cpuIdleDiff = Double(cpuLoadInfo.cpu_ticks.2 - loadInfo.cpu_ticks.2)
            let niceDiff = Double(cpuLoadInfo.cpu_ticks.3 - loadInfo.cpu_ticks.3)

            let totalTicks = cpuUsageDiff + cpuIdleDiff + sysDiff + niceDiff
            cpuUsage = cpuUsageDiff / totalTicks * 100.0
            cpuIdle = cpuIdleDiff / totalTicks * 100.0
        }

        return DeviceInfo(name: name, model: model, systemName: systemName, systemVersion: systemVersion, identifier: identifier, totalSpace: diskSpaceInfo.totalSpace, freeSpace: diskSpaceInfo.freeSpace, usedSpace: diskSpaceInfo.usedSpace, batteryLevel: batteryLevel, rebootTime: rebootTime, uptime: uptime, cpuUsage: cpuUsage, cpuIdle: cpuIdle)
    }

    private func getLastRebootDate() -> Date? {
        var tv = timeval()
        var tvSize = MemoryLayout<timeval>.size
        let err = sysctlbyname("kern.boottime", &tv, &tvSize, nil, 0)
        guard err == 0, tvSize == MemoryLayout<timeval>.size else {
            return nil
        }
        return Date(timeIntervalSince1970: Double(tv.tv_sec) + Double(tv.tv_usec) / 1_000_000.0)
    }

    private func hostCPULoadInfo() -> host_cpu_load_info? {
        let HOST_CPU_LOAD_INFO_COUNT = MemoryLayout<host_cpu_load_info>.stride / MemoryLayout<integer_t>.stride

        var size = mach_msg_type_number_t(HOST_CPU_LOAD_INFO_COUNT)
        var hostInfo = host_cpu_load_info()

        let result = withUnsafeMutablePointer(to: &hostInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(size)) {
                host_statistics(mach_host_self(), HOST_CPU_LOAD_INFO, $0, &size)
            }
        }

        if result != KERN_SUCCESS{
            print("Error  - \(#file): \(#function) - kern_result_t = \(result)")
            return nil
        }

        return hostInfo
    }
}
