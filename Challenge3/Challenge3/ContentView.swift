//
//  ContentView.swift
//  Challenge3
//
//  Created by Abdullah Ayan on 29.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var gameStatus = false
    @State private var selectedNumbers = (first: 0,second: 0)
    @State private var numberOfQuestion = 0
    var body: some View {
        ZStack {
            if !gameStatus {
                SettingsView { status,first,second,noq in
                    gameStatus = status
                    selectedNumbers.first = first
                    selectedNumbers.second = second
                    numberOfQuestion = noq
                }
            } else {
                GameView(selectedNumbers: (first: selectedNumbers.first , second: selectedNumbers.second), numberOfQuestion: numberOfQuestion)
            }
        }
        .animation(.easeInOut(duration: 1), value: gameStatus)
    }
}

struct GameContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(selectedNumbers: (first: 5, second: 7),numberOfQuestion: 10)
    }
}
