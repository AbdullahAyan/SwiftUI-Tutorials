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
                    
                }
            }
            .toolbar {
                Button {
                    showAddHabit.toggle()
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
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
}


struct Habit: Identifiable, Codable,Equatable {
    var id = UUID()
    let name: String
    var count: Int = 0
}

class Habits: ObservableObject {
    @Published var habits = [Habit]()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
