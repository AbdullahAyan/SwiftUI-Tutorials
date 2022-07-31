//
//  GameView.swift
//  Challenge3
//
//  Created by Abdullah Ayan on 31.07.2022.
//

import SwiftUI

struct GameView: View {
    static var selectedNumbers: (first: Int,second: Int) = (0,0)
    @State private var answer = ""
    @FocusState private var answerFocused: Bool
    @State private var firstNumber = selectedNumbers.first
    @State private var secondNumber = selectedNumbers.second
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Text(String(GameView.selectedNumbers.first))
                            .gameButtonStyle()
                        Text("X")
                            .gameButtonStyle()
                        Text(String(GameView.selectedNumbers.second))
                            .gameButtonStyle()
                        Text("=")
                            .gameButtonStyle()
                        TextField("  ?", text: $answer)
                            .foregroundColor(.black)
                            .gameButtonStyle()
                            .keyboardType(.numberPad)
                            .focused($answerFocused)
                    }
                    .frame(width: 300, height: 300)
                    .background(.red)
                }
                .frame(width: 300, height: 600)
                .background(.white)
            }
            .onAppear {
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        answerFocused = false
                        checkAnswer()
                    }
                }
            }

            
        }
    }
    
    func askQuestion() {
        
    }
    
    func checkAnswer() {
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(selectedNumbers: (first: 5, second: 7))
    }
}

struct GameButtonsModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .frame(width: 50, height: 50, alignment: .center)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
    }
}

extension View {
    func gameButtonStyle() -> some View {
        modifier(GameButtonsModifier())
    }
}
