//
//  UptimeService.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 16/03/24.
//

import Foundation

protocol UptimeServiceProtocol {
    func getUptime(lastRebootDate: Date) -> String
}

class UptimeService: UptimeServiceProtocol {
    func getUptime(lastRebootDate: Date) -> String {
        let now = Date()
        let difference = Calendar.current.dateComponents([.day, .hour, .minute], from: lastRebootDate, to: now)

        let days = difference.day ?? 0
        let hours = difference.hour ?? 0
        let minutes = difference.minute ?? 0

        var components: [String] = []

        if days > 0 {
            components.append(String.localizedStringWithFormat(NSLocalizedString("%dd", comment: ""), days))
        }

        if hours > 0 {
            components.append(String.localizedStringWithFormat(NSLocalizedString("%dh", comment: ""), hours))
        }

        if minutes > 0 {
            components.append(String.localizedStringWithFormat(NSLocalizedString("%dm", comment: ""), minutes))
        }

        return components.joined(separator: " ")
    }
}
