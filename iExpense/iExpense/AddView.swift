//
//  AddView.swift
//  iExpense
//
//  Created by Abdullah Ayan on 9.08.2022.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var expenses: Expenses
    
    @State var name = ""
    @State var amount = 0.0
    @State var type = "Personal"
    
    let types = ["Personal","Business"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    TextField("Name", text: $name)
                    
                    Picker("Type", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    TextField("Amount", value: $amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                }
                .preferredColorScheme(.dark)
                .navigationTitle("Add new expense")
                .toolbar {
                    Button("Save") {
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(item)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
