////
////  PingController.swift
////  Diagnostics
////
////  Created by Diego Menecheli on 18/03/24.
////
//
//import Foundation
//
//class PingController: ObservableObject {
//    private var pingManager: SwiftyPing? = nil
//    
//    public var sharedPings: SharedPings = SharedPings.shared
//    @Published var loading: Bool = false
//    public var onPingInfoFinished: (() -> Void)?
//
//    func ping(host: String) {
//        self.loading = true;
//        self.sharedPings.clear();
//        
//        do {
//            let cleanedHost = host.replacingOccurrences(of: "https://", with: "")
//            self.pingManager = try SwiftyPing(host: cleanedHost, configuration: PingConfiguration(interval: 0.5, with: 80), queue: DispatchQueue.global())
//
//            self.pingManager?.observer = { [weak self] response in
//                DispatchQueue.main.async {
//                    if let self = self {
//                        let result = round(response.duration * 1000)
//                        let message = self.processPingResponse(response)
//                        _ = self.sharedPings.addPing(location: host, result: result, ipAddress: response.ipAddress ?? "", error: message)
//                    }
//                }
//            }
//            
//            self.pingManager?.finished = { [weak self] response in
//                DispatchQueue.main.async {
//                    self?.loading = false;
//                    _ = self?.sharedPings.createAveragePingInfo(for: host)
//                    self?.onPingInfoFinished?()
//                }
//            }
//
//            self.pingManager?.targetCount = 10
//            try self.pingManager?.startPinging()
//        } catch {
//            _ = self.sharedPings.addAveragePing(location: host, averageLatency: 0.0, error: "An error ocurred while pinging")
//        }
//    }
//
//    func processPingResponse(_ response: PingResponse) -> String {
//        var message = "\(response.duration * 1000) " + NSLocalizedString("ms", comment: "")
//        if let error = response.error {
//            if error == .responseTimeout {
//                message = NSLocalizedString("Timeout", comment: "") + " \(message)"
//            } else {
//                message = error.localizedDescription
//            }
//        }
//        return message
//    }
//}
