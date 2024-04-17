//
//  PingInfoService.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 17/03/24.
//

import Foundation

protocol PingInfoServiceProtocol {
    func getPings() -> [PingInfo]
    func getAvgPing() -> AvgPingInfo
}

class PingInfoService: PingInfoServiceProtocol {
    private let avgPingService: AvgPingServiceProtocol
    
    init(avgPingService: AvgPingServiceProtocol = AvgPingService()) {
        self.avgPingService = avgPingService
    }
    
    func getPings() -> [PingInfo] {
        var pings: [PingInfo] = []
        
        func append(pingInfo: PingInfo) {
            pings.append(pingInfo)
        }
        
        func addPing(result: Double, ipAddress: String, error: String? = nil) -> PingInfo {
            let pingInfo = PingInfo(result: result, ipAddress: ipAddress, error: error)
            append(pingInfo: pingInfo)
            return pingInfo
        }
        
        return pings
    }
    
    func getAvgPing() -> AvgPingInfo {
        let pings = getPings()
        return avgPingService.createAvgPingInfo(pings: pings)
    }
}
