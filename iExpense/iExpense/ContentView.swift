//
//  ContentView.swift
//  iExpense
//
//  Created by Abdullah Ayan on 4.08.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 0
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add Number") {
                    numbers.append(currentNumber+1)
                    currentNumber += 1
                }
            }
            .toolbar {
                EditButton()
            }
        }
    }
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
        numbers.removeAll()
        currentNumber -= 1
        for number in 1...currentNumber {
            numbers.append(number)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
