//
//  WifiInfoView.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 17/04/24.
//

import SwiftUI
import SwiftData

struct WifiInfoView: View {
//    let wifiInfo: WifiInfo = SharedWifiInfo.shared.getWifiInfo()
//    let networkInfo: NetworkInfo = SharedNetworkInfo.shared.getNetworkInfo()
    var body: some View {
        List {
            Section("Wifi Info") {
//                InformationCell(title: "SSID", value: wifiInfo.SSID)
//                InformationCell(title: "BSSID", value: wifiInfo.BSSID)
//                InformationCell(title: "IP Address", value: wifiInfo.ipAddress)
//                InformationCell(title: "Subnet Mask", value: wifiInfo.subnetmask)
//                InformationCell(title: "IPv6 Address", value: wifiInfo.ipv6Address)
//                InformationCell(title: "Network Band", value: networkInfo.connectionType)
//                InformationCell(title: "Network Channel", value: networkInfo.provider)
            }
        }
        .navigationBarTitle("Wifi")
        .navigationTitle("")
    }
}

#Preview {
    WifiInfoView().modelContainer(for: Item.self, inMemory: true)
}
