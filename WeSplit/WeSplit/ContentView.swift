//
//  ContentView.swift
//  WeSplit
//
//  Created by Abdullah Ayan on 6.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 0

    @FocusState private var amountIsFocused: Bool
    
    
    var currency: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currencyCode ?? "USD")
    }
    
        
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return tipValue + checkAmount
    }
    
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople+2)
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                
                Section {
                    TextField("Amount", value: $checkAmount, format: currency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                
                Section {
                    Picker("Tip percentage",selection: $tipPercentage){
                        ForEach(0..<101){
                        Text($0,format: .percent)
                        }
                    }
                    .pickerStyle(.automatic)
                } header: {
                    Text("How muck tip do you want to leave?")
                }
                
                
                Section {
                    Text(grandTotal, format: currency)
                } header: {
                    Text("Total")
                }
                
                
                Section {
                    Text(totalPerPerson,format: currency)
                } header: {
                    Text("Amount per person")
                }
                
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done"){
                    amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
