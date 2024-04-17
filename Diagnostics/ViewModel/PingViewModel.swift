//
//  PingViewModel.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 17/03/24.
//

import Foundation

class PingViewModel: ObservableObject {
    static let shared = PingViewModel()
    
    @Published private var pings: [PingInfo]
    @Published private var avgPing: AvgPingInfo
    private let pingService: PingServiceProtocol
    
    init(pingService: PingServiceProtocol = PingService()) {
        self.pingService = pingService
        self.pings = pingService.getPings()
        self.avgPing = pingService.getAvgPing()
    }
    
    func updatePings() {
        self.pings = pingService.getPings()
    }
    
    func getPings() -> [PingInfo] {
        return pings
    }
    
    func getAvgPing() -> AvgPingInfo {
        return avgPing
    }
}
