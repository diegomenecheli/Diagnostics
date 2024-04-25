//
//  PingService.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 17/03/24.
//

import Foundation

protocol PingServiceProtocol {
    typealias UpdatePingsCompletion = ([PingInfo]) -> Void
    
    func updatePings(completion: @escaping UpdatePingsCompletion)
    func updateAvgPing(pings: [PingInfo]) -> AvgPingInfo
}

class PingService: PingServiceProtocol {
    private let pingInfoService: PingInfoServiceProtocol
    private let avgPingService: AvgPingServiceProtocol
    
    init(
        pingInfoService: PingInfoServiceProtocol = PingInfoService(),
        avgPingService: AvgPingServiceProtocol = AvgPingService()
    ) {
        self.pingInfoService = pingInfoService
        self.avgPingService = avgPingService
    }
    
    func updatePings(completion: @escaping ([PingInfo]) -> Void) {
        pingInfoService.updatePings(completion: completion)
    }
    
    
    func updateAvgPing(pings: [PingInfo]) -> AvgPingInfo {
        return avgPingService.createAvgPingInfo(pings: pings)
    }
    
}
