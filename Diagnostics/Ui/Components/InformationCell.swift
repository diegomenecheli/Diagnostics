//
//  InformationCell.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 17/04/24.
//

import Foundation
import SwiftUI
import SwiftData

struct InformationCell: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    let icon: String!
    let title: String
    let value: String!
    let destination: AnyView!
    
    init(title: String, value: String? = "", icon: String? = "", destination: AnyView? = nil) {
        self.title = title
        self.value = value
        self.icon = icon
        self.destination = destination
    }
    
    
    var body: some View {
        if let destination = destination {
            NavigationLink(destination: destination) {
                content
            }
        } else {
            content
        }
    }
    
    private var content: some View {
        HStack {
            if let icon = icon {
                Image(systemName: icon)
            }
            
            Text(title)
                .font(.subheadline)
            
            Spacer()
            
            if let value = value {
                Text(value)
                    .font(.subheadline)
                    .padding(.trailing)
            }
        }
    }
    
}

struct TestView: View {
    
    var body: some View {
        List{
            InformationCell(title: "Wi-Fi")
            InformationCell(title: "Wi-Fi", value: "Connected")
            InformationCell(title: "Wi-Fi", value: "Connected", icon: "wifi")
            InformationCell(title: "Wi-Fi", value: "Connected", icon: "wifi", destination: AnyView(DiagnosticResultsView()))

        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
