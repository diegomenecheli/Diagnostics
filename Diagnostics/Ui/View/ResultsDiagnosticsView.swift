//
//  ResultsDiagnosticsView.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 12/03/24.
//

//
import SwiftUI

struct ResultsDiagnosticsView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        ZStack {
            
        }
        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
    }
}

#Preview {
    ResultsDiagnosticsView()
        .modelContainer(for: Item.self, inMemory: true)
}
