//
//  ContentView.swift
//  Challenge1
//
//  Created by Abdullah Ayan on 8.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputUnit = UnitLength.meters
    @State private var outputUnit = UnitLength.kilometers
    
    @State private var inputAmount = 0
     var outputAmount: Measurement<UnitLength> {
         let amount = Measurement(value: Double(inputAmount), unit: inputUnit)
         return amount.converted(to: outputUnit)
    }
    
    var inputArray = [UnitLength.kilometers,UnitLength.meters,UnitLength.feet,UnitLength.yards,UnitLength.miles]
    var outputArray = [UnitLength.kilometers,UnitLength.meters,UnitLength.feet,UnitLength.yards,UnitLength.miles]

    
    
    var body: some View {
        Form {
            
            Section {
                Picker("Input Unit",selection: $inputUnit){
                    ForEach(inputArray, id: \.self){
                        Text("\($0.symbol)")
                    }
                }
                .pickerStyle(.menu)
                TextField(String(inputAmount),value: $inputAmount, format: .number)
                
            } header: {
                Text("Input Unit")
            }
            
            Section {
                Picker("Output Unit",selection: $outputUnit){
                    ForEach(outputArray, id: \.self){
                        Text("\($0.symbol)")
                    }
                }
                .pickerStyle(.menu)
                Text("\(outputAmount.value)")
                
            } header: {
                Text("Output Unit")
            }
            
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
