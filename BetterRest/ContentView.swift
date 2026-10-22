//
//  ContentView.swift
//  BetterRest
//
//  Created by Remitbee on 12/10/26.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    @State private var sleepAmount = 8.0
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    var body: some View {
        NavigationStack {
            Form {
                // CHALLENGE 1: Replace VStack with Section
                Section("When do you want to wake up") {
                    DatePicker("Please enter a time ", selection: $wakeUp, displayedComponents: .hourAndMinute ).labelsHidden()
                }
                
                // CHALLENGE 1: Replace VStack with Section
                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted())",
                            value: $sleepAmount, in: 4...12,
                            step: 0.25)
                    
                }
                
                // CHALLENGE 2: Replace Stepper with a Picker
                Section("Daily coffee intake") {
                    Picker("Daily coffee intake",
                           selection: $coffeeAmount) {
                        ForEach(1...20, id: \.self) { num in
                            Text("^[\(num) cup](inflect: true)")
                        }
                    }
                }
                
                // CHALLENGE 3: Prominent real-time bedtime display
                Section("Recommended Bedtime") {
                    Text(calculateBedTime())
                        .font(.largeTitle.bold())
                        .foregroundStyle(.blue)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 8)
                }
            }
            .navigationTitle("BetterRest")
        }
    }
    
    func calculateBedTime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return "Error"
        }
    }
    
    func exampleDates() {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        let date = Calendar.current.date(from: components) ?? .now
    }
}

#Preview {
    ContentView()
}
