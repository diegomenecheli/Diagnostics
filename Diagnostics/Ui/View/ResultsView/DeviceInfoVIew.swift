//
//  DeviceInfoVIew.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 17/04/24.
//

import SwiftUI
import SwiftData

struct DeviceInfoView: View {
    let deviceInfo: DeviceInfo = DeviceViewModel.shared.getDeviceInfo()
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section("Battery") {
                    InformationCell(title: "Battery Status", value: "\(String(deviceInfo.batteryLevel))%")
                }
                Section("Storage"){
                    InformationCell(title: "Total Storage", value: String(deviceInfo.totalSpace))
                    InformationCell(title: "Used", value: String(deviceInfo.usedSpace))
                    InformationCell(title: "Free", value: String(deviceInfo.freeSpace))
                }
                Section("CPU"){
                    InformationCell(title: "Usage", value: "\(String(format: "%.1f", deviceInfo.cpuUsage))%")
                    InformationCell(title: "Idle", value: "\(String(format: "%.1f", deviceInfo.cpuIdle))%")
                }
                Section("System"){
                    InformationCell(title: "Last Restart", value: String(deviceInfo.rebootTime))
                    InformationCell(title: "Uptime", value: String(deviceInfo.uptime))
                }
            }
        }
        .navigationBarTitle("Device", displayMode: .inline)
        .navigationTitle("")
    }
}

#Preview {
    DeviceInfoView()
        .modelContainer(for: Item.self, inMemory: true)
}

