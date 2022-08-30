//
//  AddHabit.swift
//  Challenge4
//
//  Created by Abdullah Ayan on 28.08.2022.
//

import SwiftUI

struct AddHabit: View {
    @ObservedObject var habits: Habits
    @State var habitName = ""
    @State var showAlert = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Enter Your Habit Name",text: $habitName)
                }
                .alert("Don't leave empty!", isPresented: $showAlert) {
                    Button("OK") { }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                    Button("Done") {
                        habitName = habitName.trimmingCharacters(in: .whitespacesAndNewlines)
                        if !habitName.isEmpty {
                            habits.habits.append(Habit(name: habitName))
                            dismiss()
                        } else {
                            showAlert.toggle()
                        }
                    }
                    
                }
            }
        }
        .accentColor(.white)
    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddHabit(habits: Habits())
            .preferredColorScheme(.dark)
            .accentColor(.white)
    }
}
