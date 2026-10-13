//
//  ContentView.swift
//  BetterRest
//
//  Created by Remitbee on 12/10/26.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date.now
    var body: some View {
        VStack {
            DatePicker("Please enter a date", selection: $wakeUp,  in: Date.now..., displayedComponents: .date)
                .labelsHidden()
        }
        .padding()
    }
    
}

#Preview {
    ContentView()
}
