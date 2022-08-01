//
//  SettingsView.swift
//  Challenge3
//
//  Created by Abdullah Ayan on 31.07.2022.
//

import SwiftUI

struct SettingsView: View {
    
    var gameStatusClosure: (Bool,Int,Int,Int) -> (Void)
    @State private var selectedNumbers = (first: 0,second: 0)
    @State private var scaleEfectAmount = 1.0
    @State private var alertMessage = ""
    @State private var alertStatus = false
    @State private var numberOfQuestion = 10
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.red
                    .ignoresSafeArea()
                    .navigationTitle("Edutainment")
                VStack {
                    Spacer()
                    Spacer()
                    Text("Which multiplication tables do you want to practice?\n")
                        .font(.headline.bold())
                    Table { selectedNumber in
                        if selectedNumbers.first == 0 {
                            selectedNumbers.first = selectedNumber
                        }else if selectedNumbers.second == 0 {
                            if selectedNumber < selectedNumbers.first {
                                selectedNumbers.second = selectedNumbers.first
                                selectedNumbers.first = selectedNumber
                                withAnimation(.interpolatingSpring(stiffness: 100, damping: 3)) {
                                    scaleEfectAmount = 1.1
                                }
                            } else {
                                selectedNumbers.second = selectedNumber
                                withAnimation(.interpolatingSpring(stiffness: 100, damping: 3)) {
                                    scaleEfectAmount = 1.1
                                }
                            }
                        }
                        else if selectedNumbers.first != 0 && selectedNumbers.second != 0 {
                            selectedNumbers.first = selectedNumber
                            selectedNumbers.second = 0
                            scaleEfectAmount = 1
                        }
                    }
                    Spacer()
                    Spacer()
                    Text("Number of Question")
                        .font(.headline)
                    Picker("Number of Question", selection: $numberOfQuestion) {
                        ForEach(0..<51) {
                            Text(String($0))
                        }
                    }
                    .pickerStyle(.inline)
                    .background(.gray)
                    .frame(width: 50, height: nil)
                    .cornerRadius(10)
                    
                    Spacer()
                    Button("\(selectedNumbers.first) to \(selectedNumbers.second)"){
                        if selectedNumbers.first != 0 && selectedNumbers.second != 0 {
                            gameStatusClosure(true,selectedNumbers.first,selectedNumbers.second, numberOfQuestion)
                        } else {
                            alertMessage = "Choose 2 number."
                            alertStatus = true
                        }
                    }
                    .font(.title3)
                    .padding()
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .shadow(color: .black, radius: 10, x: 0, y: 0)
                    .scaleEffect(scaleEfectAmount)
                    .alert("Wait a second !", isPresented: $alertStatus) {
                        Button("OK"){ }
                    } message: {
                        Text(alertMessage)
                    }
                }
                
            }
        }
    }
}

struct Table: View {
    var closure : (Int) -> (Void)
    var body: some View {
        VStack {
            ForEach(0..<4) { col in
                HStack {
                    ForEach(1..<5) {row in
                        Button("\(col * 4 + row)"){
                            closure(col * 4 + row)
                        }
                        .frame(width: 50, height: 40)
                        .background(.gray)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    }
                }
            }
        }
    }
}

struct SettingsContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
