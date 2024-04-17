//
//  ResultsCompletedView.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 12/03/24.
//

//
import SwiftUI

struct ResultsCompletedView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    let deviceViewModel = DeviceViewModel.shared
    
    var body: some View {
        Text("Device Name: \(deviceViewModel.getDeviceInfo().name)")
        Text("Device Model: \(deviceViewModel.getDeviceInfo().model)")
    }
}

#Preview {
    ResultsCompletedView()
}
