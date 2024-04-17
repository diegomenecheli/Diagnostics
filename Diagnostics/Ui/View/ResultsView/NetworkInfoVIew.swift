//
//  NetworkInfoVIew.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 17/04/24.
//

import SwiftUI
import SwiftData

struct NetworkInfoView: View {
//    let networkInfo: NetworkInfo = SharedNetworkInfo.shared.getNetworkInfo()
//    let wifiInfo: WifiInfo = SharedWifiInfo.shared.getWifiInfo()
//    
    var body: some View {
        List {
            Section("Connection Info") {
//                InformationCell(title: "Avg Download Spped (Mbps)", value: "\(String(format: "%.2f", networkInfo.avgDownloadSpeed))%")
//                InformationCell(title: "Max Download Speed (Mbps)", value: "\(String(format: "%.2f", networkInfo.maxDownloadSpeed))%")
//                InformationCell(title: "Avg Upload Speed (Mbps)", value: "\(String(format: "%.2f", networkInfo.avgUploadSpeed))%")
                //                InformationCell(title: "Max Upload Speed (Mbps)", value: "\(String(format: "%.2f", networkInfo.maxUploadSpeed))%")
//                InformationCell(title: "Connection Strength", value: wifiInfo.connectionStrength)
//                InformationCell(title: "Latency (ms)", value: "\(String(format: "%.2f", networkInfo.latency))%")
//                
            }
        }
        .navigationBarTitle("Connection")
        .navigationTitle("")
    }
}

#Preview {
    NetworkInfoView().modelContainer(for: Item.self, inMemory: true)
}
