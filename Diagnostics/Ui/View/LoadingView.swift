//
//  LoadingView.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 12/03/24.
//
import SwiftUI

struct LoadingView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State private var statusMessage = "Getting WiFi..."
    @State private var messages = ["Getting WiFi...", "Checking Device...", "Pinging Server...", "Testing Speed...", "Saving Results..."]
    @State private var currentMessageIndex = 0
    @State private var showMessage = false
    
    @State private var updatedData = false
    @ObservedObject var deviceViewModel: DeviceViewModel = DeviceViewModel.shared
    @ObservedObject var pingViewModel: PingViewModel = PingViewModel.shared
//    @ObservedObject  var sharedNetworkInfo: SharedNetworkInfo = SharedNetworkInfo()
//
//    

    private func handleData() {
        showMessage = true
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            withAnimation {
                currentMessageIndex = (currentMessageIndex + 1) % messages.count
                showMessage = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showMessage = true
                }
            }
        }
        
        pingViewModel.updatePings()
        deviceViewModel.updateDeviceInfo()
        updatedData = true
//        _ = SharedDeviceInfo.shared.updateDeviceInfo()
//        SharedWifiInfo.shared.checkWifiInfo()
//
        
//
//        sharedNetworkInfo.startNetworkInfo()
//        
//        sharedNetworkInfo.onNetworkInfoUpdated = { [self] in
//            createWDRController.createWDR {
//                updatedData = true
//            }
//        }
    }
    
    var body: some View {
        if updatedData {
            DiagnosticResultsView()
        } else {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                
                LottieView(filename: colorScheme == .dark ? "test-loading-dark" : "test-loading-light")
                    .frame(height: 240)
                    .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                    .padding(.bottom, 120)
                
                VStack {
                    Text(messages[currentMessageIndex])
                        .font(.headline)
                        .foregroundColor(.primary)
                        .opacity(showMessage ? 1 : 0)
                        .animation(.easeInOut(duration: 1), value: showMessage)
                        .padding(.bottom, 20)
                    
                    Text("Tests usually takes 10-50s, please wait")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 12)
                }
                .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
            }
            .onAppear {
                handleData()
            }
            .navigationBarBackButtonHidden()
            .navigationTitle("")
        }
    }
}

#Preview {
    LoadingView()
        .modelContainer(for: Item.self, inMemory: true)
}

