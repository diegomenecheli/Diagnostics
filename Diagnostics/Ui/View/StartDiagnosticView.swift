//
//  StartDiagnosticView.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 18/04/24.
//

import SwiftUI
import SwiftData
import UIKit

struct StartDiagnosticView: View {
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    @StateObject private var locationManager = LocationManager()
    
    func openSettings() {
        if let appSettings = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    
                    Spacer()
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    if locationManager.authorizationStatus == .authorizedWhenInUse ||
                        locationManager.authorizationStatus == .authorizedAlways {
                        NavigationLink(destination: LoadingView()) {
                            Text("Run Network Diagnostic")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.appSecondary)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding()
                    } else {
                        Text("Location permission is required to proceed. Please tap the button below to grant access.")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .multilineTextAlignment(.center)
                        Button {
                            openSettings()
                        } label: {
                            Text("Request Location Permission")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.appSecondary)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding()
                    }
                }
                .onAppear{
                    locationManager.requestAuthorization()
                }
                
            }
            .navigationBarTitle("Network Diagnostics", displayMode: .inline)
            .navigationBarItems(trailing:
                                    NavigationLink(destination: SettingsView().preferredColorScheme(userTheme.colorScheme)) {
                Image(systemName: "gearshape")
                    .font(.callout)
                    .foregroundColor(.gray)
                    .padding()
            })
            .ignoresSafeArea(.keyboard, edges: .all)
        }
    }
}


#Preview {
    StartDiagnosticView()
        .modelContainer(for: Item.self, inMemory: true)
}
