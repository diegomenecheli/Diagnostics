//
//  StartDiagnostic.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 18/04/24.
//
import SwiftUI
import SwiftData
import UIKit

struct StoreDetailsView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
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
                VStack(alignment: .leading) {
                    Spacer()
                    
                    if locationManager.authorizationStatus == .authorizedWhenInUse ||
                        locationManager.authorizationStatus == .authorizedAlways {
                        // User has granted location permission
                        NavigationLink(destination: LoadingDiagnosticsView()) {
                            Text("Run Network Diagnostic")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.leviSecondary)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding()
                        .disabled(selectedOption == "Select" || (selectedOption == "Other" && descriptionInput.isEmpty))
                        .opacity(selectedOption == "Select" || (selectedOption == "Other" && descriptionInput.isEmpty) ? 0.5 : 1.0)
                        .simultaneousGesture(TapGesture().onEnded {
                            let existent_store = SharedStoreInfo.shared.getStoreInfo()
                            if (existent_store.storeID == "" && storeNameInput != "") {
                                SharedStoreInfo.shared.requestStoreInfo(storeName: storeNameInput)
                            }
                        })
                    } else {
                        // User hasn't granted location permission yet
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
                        .background(Color.leviSecondary)
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
#if DEBUG
            .navigationBarItems(leading: NavigationLink(destination: TestsView().preferredColorScheme(userTheme.colorScheme)) {
                Image(systemName: "exclamationmark.warninglight")
                    .font(.callout)
                    .foregroundColor(.gray)
                    .padding()
            })
#endif
            .navigationBarItems(trailing:
                                    NavigationLink(destination: SettingsView().preferredColorScheme(userTheme.colorScheme)) {
                Image(systemName: "gearshape")
                    .font(.callout)
                    .foregroundColor(.gray)
                    .padding()
            })
            .onTapGesture {
                hideKeyboard()
            }
            .ignoresSafeArea(.keyboard, edges: .all)
        }
    }
}

private func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

#Preview {
    StoreDetailsView()
        .modelContainer(for: Item.self, inMemory: true)
}
