//
//  ContentView.swift
//  BetterRest
//
//  Created by Abdullah Ayan on 13.07.2022.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    var sleepTime: Date {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hours = (components.hour ?? 0) * 60 * 60
            let minutes = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hours + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime
        } catch {
            fatalError()
        }
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Please enter a time.", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                } header: {
                    Text("When do you want to wake up?")
                }
                
                Section {
                    Stepper("\(sleepAmount.formatted())",value: $sleepAmount,in: 4...12, step: 0.25)
                } header: {
                    Text("Desired amount of sleep")
                }
                
                Section {
                    Picker(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", selection: $coffeeAmount){
                        ForEach(0..<21){
                            Text($0,format: .number)
                        }
                    }
                    .pickerStyle(.automatic)
                } header: {
                    Text("Daily coffee intake")
                }
                Section {
                    Text("\(sleepTime.formatted(date: .omitted, time: .shortened))")
                        .font(.largeTitle)
                } header: {
                    Text("Ideal Bedtime")
                }
            }
            .navigationTitle("BetterRest")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
