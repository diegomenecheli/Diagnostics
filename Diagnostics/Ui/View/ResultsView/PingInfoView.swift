//
//  PingInfoView.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 17/04/24.
//

import SwiftUI
import SwiftData

struct PingInfoView: View {
    let pings: [PingInfo] = PingViewModel.shared.getPings()
    let avgPing: AvgPingInfo = PingViewModel.shared.getAvgPing()
   

    var body: some View {
        List {
            Section("Average Pings") {
                InformationCell(title: "Average Ping", value: "\(String(format: "%.0f", avgPing.averageLatency)) ms")
            }
            Section("Pings") {
                ForEach(Array(pings.enumerated()), id: \.element.self) { index, ping in
                    InformationCell(title: "\(index + 1)", value: ping.error)
                }
            }
        }
        .navigationBarTitle("Ping")
        .navigationTitle("")
    }
}

#Preview {
    PingInfoView()
        .modelContainer(for: Item.self, inMemory: true)
}

