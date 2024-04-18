//
//  SplashView.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 18/04/24.
//

import SwiftUI

struct SplashView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            LottieView(filename: colorScheme == .dark ? "wifi-dark" : "wifi-light")
                .frame(height: 240)
                .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                .padding(.bottom, 120)
        }
    }
}

#Preview {
    SplashView()
        .modelContainer(for: Item.self, inMemory: true)
}
