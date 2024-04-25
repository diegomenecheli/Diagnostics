//
//  PingViewModel.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 17/03/24.
//

import Foundation

class PingViewModel: ObservableObject {
    static let shared = PingViewModel()
    
    @Published private var pings: [PingInfo] = []
    @Published private var avgPing: AvgPingInfo = AvgPingInfo(averageLatency: 0.0)
    private let pingService: PingServiceProtocol
    
    init(pingService: PingServiceProtocol = PingService()) {
        self.pingService = pingService
    }
    
    func updatePings(completion: @escaping () -> Void) {
        pingService.updatePings { [weak self] updatedPings in
            DispatchQueue.main.async {
                self?.pings = updatedPings
                completion()
            }
        }
    }
    
    func updateAvgPing() {
        self.avgPing = self.pingService.updateAvgPing(pings: pings)
    }
    
    func getPings() -> [PingInfo] {
        return pings
    }
    
    func getAvgPing() -> AvgPingInfo {
        return avgPing
    }
}
