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
    var body: some View {
        ZStack {
            if !gameStatus {
                SettingsView { status,first,second in
                    gameStatus = status
                    selectedNumbers.first = first
                    selectedNumbers.second = second
                }
            } else {
                GameView(selectedNumbers: (first: selectedNumbers.first , second: selectedNumbers.second))
            }
        }
        .animation(.easeInOut(duration: 1), value: gameStatus)
    }
}

struct GameContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(selectedNumbers: (first: 5, second: 7))
    }
}
