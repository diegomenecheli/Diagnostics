//
//  ResultsDiagnosticsView.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 12/03/24.
//

//
import SwiftUI

struct ResultsDiagnosticsView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var viewModel: DeviceViewModel
    
    init(viewModel: DeviceViewModel = DeviceViewModel.shared) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("Device Name: \(viewModel.getDeviceInfo().name)")
        Text("Device Model: \(viewModel.getDeviceInfo().model)")
    }
}

#Preview {
    ResultsDiagnosticsView()
        .modelContainer(for: Item.self, inMemory: true)
}
