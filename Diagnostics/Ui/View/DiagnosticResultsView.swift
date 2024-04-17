//
//  DiagnosticResultsView.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 17/04/24.
//

import SwiftUI
import SwiftData

struct DiagnosticResultsView: View {
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    var body: some View {
        NavigationStack {
            List {
                Section("Informations") {
                    //                InformationCell(title: "Network", icon: "gauge.with.needle", destination: AnyView(NetworkInfoView()))
                    //
                    //                InformationCell(title: "Wifi", icon: "wifi", destination: AnyView(WifiInfoView()))
                    //
                    //                InformationCell(title: "Ping", icon: "circle.circle", destination: AnyView(PingInfoView()))
                    
                    InformationCell(title: "Device", icon: "iphone.gen1", destination: AnyView(DeviceInfoView()))
                }
            }
            .navigationBarTitle("Diagnostics", displayMode: .inline)
            .navigationTitle("")
            .navigationBarItems(
                trailing: NavigationLink(
                    destination: SettingsView().preferredColorScheme(userTheme.colorScheme)) {
                        Image(systemName: "gearshape")
                            .font(.callout)
                            .foregroundColor(.gray)
                            .padding()
                    })
        }
    }
}

#Preview {
    DiagnosticResultsView()
        .modelContainer(for: Item.self, inMemory: true)
}

