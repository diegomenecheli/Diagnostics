//
//  LoadingView.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 12/03/24.
//
import SwiftUI

struct LoadingView: View {
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
        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
    }
}

#Preview {
    LoadingView()
}
