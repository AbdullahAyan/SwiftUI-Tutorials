//
//  GameView.swift
//  Challenge3
//
//  Created by Abdullah Ayan on 31.07.2022.
//

import SwiftUI

struct GameView: View {
    
    var selectedNumbers: (first: Int,second: Int)
    var numberOfQuestion: Int
    
    @State private var answer = ""
    @FocusState private var answerFocused: Bool
    @State private var firstNumber = 0
    @State private var secondNumber = 0
    @State private var isTrue = false
    @State private var isTrueAlertShow = false
    @State private var remainigQuestion = 0
    @State private var trueAmount = 0
    @State private var falseAmount = 0
    @State private var gameOverAlert = false
    @State private var gameOver = false
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.red
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Text("Remaining Question: \(remainigQuestion)")
                        .font(.headline)
                    Spacer()
                    HStack {
                        Text(String(firstNumber))
                            .gameButtonStyle()
                        Text("X")
                            .gameButtonStyle()
                        Text(String(secondNumber))
                            .gameButtonStyle()
                        Text("=")
                            .gameButtonStyle()
                        TextField("  ?", text: $answer)
                            .foregroundColor(.black)
                            .gameButtonStyle()
                            .keyboardType(.numberPad)
                            .focused($answerFocused)
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Text("True: \(trueAmount)")
                        Spacer()
                        Text("False: \(falseAmount)")
                        Spacer()
                    }
                    .font(.headline)
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                if gameOver == true {
                    ZStack {
                        Color.red
                        VStack {
                            Spacer()
                            Text("Game Over")
                                .font(.custom("New", size: 100))
                            Spacer()
                            Spacer()
                        }
                    }
                    
                }
            }
            
            
            .onAppear {
                askQuestion()
                remainigQuestion = numberOfQuestion
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
            .alert(isTrue ? "True!" : "False!", isPresented: $isTrueAlertShow) {
                Button("OK") {
                    askQuestion()
                }
            } message: {
                if isTrue {
                    Text("Your anser is true!")
                } else {
                    Text("Your answer is false!")
                }
            }
            .alert("Game Over", isPresented: $gameOverAlert) {
                Button("OK") {
                }
            } message: {
                Text("Your score is \(trueAmount - falseAmount)")
            }
            
            
        }
    }
    
    func askQuestion() {
        firstNumber = Int.random(in: selectedNumbers.first...selectedNumbers.second)
        secondNumber = Int.random(in: 0...16)
    }
    
    func checkAnswer() {
        withAnimation(.default) {
            if firstNumber * secondNumber == Int(answer) {
                isTrue = true
                trueAmount += 1
            } else {
                isTrue = false
                falseAmount += 1
            }
        }
        answer = ""
        remainigQuestion -= 1
        if remainigQuestion == 0 {
            gameOverAlert = true
            withAnimation(.default.delay(1)) {
                gameOver = true
            }
        } else {
            isTrueAlertShow = true
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(selectedNumbers: (first: 5, second: 7),numberOfQuestion: 10)
    }
}

struct GameButtonsModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .frame(width: 60, height: 50, alignment: .center)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
    }
}

extension View {
    func gameButtonStyle() -> some View {
        modifier(GameButtonsModifier())
    }
}
