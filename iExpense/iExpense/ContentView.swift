//
//  ContentView.swift
//  iExpense
//
//  Created by Abdullah Ayan on 4.08.2022.
//

import SwiftUI

struct ExpenseItem: Codable,Identifiable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedData = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedData) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}



struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(item.name)
                                .font(.largeTitle)
                            Text(item.type)
                        }
                        
                        Spacer()
                        Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    }
                    .styling(amount: item.amount)
                }
                .onDelete(perform: removeItems)
            }
            //            .preferredColorScheme(.dark)
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
    
}



struct Styling: ViewModifier {
    var amount: Double
    func body(content: Content) -> some View {

        if amount < 10 {
            content
                .foregroundColor(.green)
            
        }else if amount < 100 {
            content
                .foregroundColor(.yellow)
            
        }else {
            content
                .foregroundColor(.red)
        }
    }
}

extension View {
    func styling(amount: Double) -> some View{
        modifier(Styling(amount: amount))
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
