//
//  PingInfoService.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 17/03/24.
//

import Foundation

protocol PingInfoServiceProtocol {
    typealias UpdatePingsCompletion = ([PingInfo]) -> Void
    
    func updatePings(completion: @escaping UpdatePingsCompletion)
}

class PingInfoService: PingInfoServiceProtocol {
    private let avgPingService: AvgPingServiceProtocol
    private var pingManager: SwiftyPing? = nil
    private let host = "https://www.google.com"
    private var pings: [PingInfo] = []    
    init(avgPingService: AvgPingServiceProtocol = AvgPingService()) {
        self.avgPingService = avgPingService
    }
    
    func updatePings(completion: @escaping ([PingInfo]) -> Void) {
        do {
            let cleanedHost = host.replacingOccurrences(of: "https://", with: "")
            self.pingManager = try SwiftyPing(host: cleanedHost, configuration: PingConfiguration(interval: 0.5, with: 80), queue: DispatchQueue.global())
            
            self.pingManager?.observer = { [weak self] response in
                DispatchQueue.main.async {
                    if let self = self {
                        let result = round(response.duration * 1000)
                        let message = self.processPingResponse(response)
                        let pingInfo = PingInfo(result: result, ipAddress: response.ipAddress ?? "", error: message)
                        print("Ping Info: \(pingInfo)")
                        self.pings.append(pingInfo)
                        

                        
                        if self.pings.count == self.pingManager?.targetCount {
                            self.pingManager?.stopPinging()
                            completion(self.pings)
                        }
                    }
                }
            }
            
            self.pingManager?.targetCount = 10
            try self.pingManager?.startPinging()
        } catch {
            pings.append(PingInfo(result: 0.0, ipAddress: "", error: error.localizedDescription))
            completion(pings) // Return the pings array with error via completion handler
        }
    }
    
    func processPingResponse(_ response: PingResponse) -> String {
        let roundedResult = String(format: "%.2f", response.duration * 1000)
        var message = "\(roundedResult) " + NSLocalizedString("ms", comment: "")
        
        if let error = response.error {
            if error == .responseTimeout {
                message = NSLocalizedString("Timeout", comment: "") + " \(message)"
            } else {
                message = error.localizedDescription
            }
        }
        return message
    }
}
