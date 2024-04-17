//
//  PingInfo.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 17/03/24.
//

import Foundation

struct PingInfo: Hashable {
    let result: Double
    let ipAddress: String
    let error: String?
}
