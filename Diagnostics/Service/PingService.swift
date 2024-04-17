//
//  PingService.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 17/03/24.
//

import Foundation

protocol PingServiceProtocol {
    func getPings() -> [PingInfo]
    func getAvgPing() -> AvgPingInfo
}

class PingService: PingServiceProtocol {
    private let pingInfoService: PingInfoServiceProtocol
    
    init(pingInfoService: PingInfoServiceProtocol = PingInfoService()) {
        self.pingInfoService = pingInfoService
    }
    
    func getPings() -> [PingInfo] {
        return pingInfoService.getPings()
    }
    
    func getAvgPing() -> AvgPingInfo {
        return pingInfoService.getAvgPing()
    }
}
