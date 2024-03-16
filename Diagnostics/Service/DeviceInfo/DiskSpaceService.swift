//
//  DiskSpaceService.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 16/03/24.
//

import Foundation

protocol DiskSpaceServiceProtocol {
    func getDiskSpaceInfo() -> (totalSpace: String, freeSpace: String, usedSpace: String)?
}

class DiskSpaceService: DiskSpaceServiceProtocol {
    func getDiskSpaceInfo() -> (totalSpace: String, freeSpace: String, usedSpace: String)? {
        guard let totalSpaceInBytes = FileManagerUility.getFileSize(for: .systemSize),
              let freeSpaceInBytes = FileManagerUility.getFileSize(for: .systemFreeSize) else {
            return nil
        }

        let usedSpaceInBytes = totalSpaceInBytes - freeSpaceInBytes
        let totalSpace = String(format: "%.2f GB", Double(totalSpaceInBytes) / 1_000_000_000)
        let freeSpace = String(format: "%.2f GB", Double(freeSpaceInBytes) / 1_000_000_000)
        let usedSpace = String(format: "%.2f GB", Double(usedSpaceInBytes) / 1_000_000_000)

        return (totalSpace, freeSpace, usedSpace)
    }
}
