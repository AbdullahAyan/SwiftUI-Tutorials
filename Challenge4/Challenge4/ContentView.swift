//
//  ContentView.swift
//  Challenge4
//
//  Created by Abdullah Ayan on 28.08.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits = Habits()
    @State var showAddHabit = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(habits.habits) { habit in
                        NavigationLink {
                            HabitDetails(habits: habits,habit: habit)
                        } label: {
                            Text(habit.name)
                        }
                    }
                    .onDelete(perform: performDelete)
                }
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    EditButton()
                    Button {
                        showAddHabit.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                    }
                    
                }
            }
            .sheet(isPresented: $showAddHabit) {
                AddHabit(habits: habits)
            }
            .navigationTitle("Habit Tracker")
            .preferredColorScheme(.dark)
        }
        .accentColor(.white)
    }
    
    func performDelete(index: IndexSet) {
        habits.habits.remove(atOffsets: index)
    }
}




struct Habit: Identifiable, Codable,Equatable {
    var id = UUID()
    let name: String
    var count: Int = 0
}

class Habits: ObservableObject {
    @Published var habits: [Habit] {
        didSet {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(habits) {
                UserDefaults.standard.set(data, forKey: "Habits")
            }
        }
    }
    
    init() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "Habits") {
            if let habits = try? decoder.decode([Habit].self, from: data) {
                self.habits = habits
                return
            }
        }
        habits = []
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
