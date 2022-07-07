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
    @State private var tipPercentage = 20
    
    var body: some View {
        Form {
            Section {
                TextField("Amount",value: $checkAmount, format: .currency(code:  Locale.current.currencyCode ?? "USD"))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
