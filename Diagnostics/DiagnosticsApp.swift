//
//  DiagnosticsApp.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 11/03/24.
//

import SwiftUI
import SwiftData

@main
struct WiFi_DiagnosticsApp: App {
    @State private var showSplashScreen = true
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            if showSplashScreen {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                            withAnimation {
                                showSplashScreen = false
                            }
                        }
                    }
                    .preferredColorScheme(userTheme.colorScheme)
            } else {
                StartDiagnosticView()
                    .preferredColorScheme(userTheme.colorScheme)
            }
        }
        .environment(\.colorScheme, userTheme.colorScheme ?? .light)
        .modelContainer(sharedModelContainer)
    }
}

