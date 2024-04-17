//
//  AvgPingService.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 17/03/24.
//

import Foundation

protocol AvgPingServiceProtocol {
    func calculateAvgPing(pings: [PingInfo]) -> Double
    func createAvgPingInfo(pings: [PingInfo]) -> AvgPingInfo
}

class AvgPingService: AvgPingServiceProtocol {
    func calculateAvgPing(pings: [PingInfo]) -> Double {
        let sumOfResults = pings.reduce(0.0) { $0 + $1.result }
        return sumOfResults / Double(pings.count)
    }
    
    public func createAvgPingInfo(pings: [PingInfo]) -> AvgPingInfo {
        let averageLatency = calculateAvgPing(pings: pings)
        let avgPing = AvgPingInfo(averageLatency: averageLatency)
        return avgPing
    }
}
