//
//  NetworkIssueView.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 17/04/24.
//

import SwiftUI
import SwiftData

struct NetworkIssueView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "circle.slash")
                    .font(.system(size: 150))
                    .foregroundColor(.red)
                    .padding(.bottom, 20)
                Text(
                    "This app will only work with internet. Please turn on the internet to use it."
                )
                .font(.headline)
                .padding(.horizontal, 48)
                .multilineTextAlignment(.center)
            }
            .padding(.bottom, 90)
            .navigationBarTitle("Network Diagnostics", displayMode: .inline)
        }
    }
}

#Preview {
    NetworkIssueView()
        .modelContainer(for: Item.self, inMemory: true)
}

