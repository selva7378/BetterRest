//
//  ContentView.swift
//  BetterRest
//
//  Created by Remitbee on 12/10/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text(Date.now, format: .dateTime.hour().minute())
        Text(Date.now, format: .dateTime.day().month().year())
        Text(Date.now.formatted(date: .long, time: .shortened))
    }
    
    func exampleDates() {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        let date = Calendar.current.date(from: components) ?? .now
        
        let componentsOne = Calendar.current.dateComponents([.hour, .minute], from: .now)
        let hour = componentsOne.hour ?? 0
        let minute = componentsOne.minute ?? 0
    }
}

#Preview {
    ContentView()
}
