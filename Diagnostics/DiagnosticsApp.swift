//
//  DiagnosticsApp.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 11/03/24.
//

import SwiftUI
import SwiftData

@main
struct DiagnosticsApp: App {
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    @ObservedObject var deviceViewModel: DeviceViewModel = DeviceViewModel.shared
    @State private var updatedData = false
    
    private func handleData() {
        deviceViewModel.updateDeviceInfo()
        updatedData = true
    }
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            if updatedData {
                LoadingView()
                    .onAppear {
                        handleData()
                    }
                    .preferredColorScheme(userTheme.colorScheme)
            } else {
                DiagnosticResultsView()
                    .preferredColorScheme(userTheme.colorScheme)
            }
        }
        .environment(\.colorScheme, userTheme.colorScheme ?? .light)
        
    }
}
