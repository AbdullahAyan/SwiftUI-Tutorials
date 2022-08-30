//
//  HabitDetails.swift
//  Challenge4
//
//  Created by Abdullah Ayan on 28.08.2022.
//

import SwiftUI

struct HabitDetails: View {
    @ObservedObject var habits: Habits
    var habit: Habit
    @State var animationAmount = 0.5
    
    var body: some View {
        VStack {
            Text(String(habit.count))
                .font(Font(CTFont(.application, size: 250)))
                .scaleEffect(animationAmount)
            Spacer()
            Spacer()
            if animationAmount != 1.0 {
                Button("Add") {
                    var updateHabit = habit
                    updateHabit.count += 1
                    let index = habits.habits.firstIndex(of: habit)
                    habits.habits[index!] = updateHabit
                    withAnimation {
                        animationAmount = 1.0
                    }
                }
                .font(Font(CTFont(.application, size: 30)))
                .foregroundColor(.white)
                .frame(width: 130, height:70, alignment: .center)
                .background(.gray)
                .cornerRadius(20)
                .padding(.bottom,100)
            }
        }
    }
    
}




struct HabitDetails_Previews: PreviewProvider {
    static var habits = Habits()
    static var habit = Habit(name: "zort")
    
    
    static var previews: some View {
        HabitDetails(habits: habits,habit: habit)
            .preferredColorScheme(.dark)
    }
}
